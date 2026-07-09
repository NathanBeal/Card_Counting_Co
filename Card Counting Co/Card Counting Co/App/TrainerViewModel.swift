//
//  TrainerViewModel.swift
//  Outs
//
//  Drives the trainer in three session modes:
//   • Play  — a random hand vs opponents who hold hidden cards from a range.
//   • Build — you pick the hero cards, board, and (optionally) exact villains.
//   • Quiz  — a random spot with odds hidden: estimate win %, pick a move,
//             reveal + get scored (with a persistent record).
//
//  At the end of any hand you can run a Showdown: opponents' cards flip up and
//  the winner is decided on the real board.
//

import SwiftUI

enum SessionMode: String, CaseIterable, Identifiable {
    case play  = "Play"
    case build = "Build"
    case quiz  = "Quiz"
    var id: String { rawValue }

    /// Play and Quiz deal random cards; only Build is user-picked.
    var dealsRandomly: Bool { self != .build }
}

/// The simplified move a player guesses in Quiz mode.
enum GuessAction: String, CaseIterable, Identifiable {
    case fold      = "Fold"
    case checkCall = "Check / Call"
    case betRaise  = "Bet / Raise"
    var id: String { rawValue }
}

extension PokerAction {
    var asGuess: GuessAction {
        switch self {
        case .fold:         return .fold
        case .check, .call: return .checkCall
        case .bet, .raise:  return .betRaise
        }
    }
}

/// The scored outcome of one Quiz guess. Worth 100 points: up to 60 for the
/// win-% estimate, up to 40 for matching the coach's move.
struct RoundResult: Equatable {
    static let maxAccuracy = 60
    static let maxMove = 40

    let guessedWin: Double
    let actualWin: Double
    let accuracyPoints: Int
    let movePoints: Int
    let guessedAction: GuessAction
    let coachAction: GuessAction
    let actionMatched: Bool

    var roundPoints: Int { accuracyPoints + movePoints }
    var winError: Double { abs(guessedWin - actualWin) }
    /// A "good" round for streak purposes: right move and a close read.
    var isGood: Bool { actionMatched && winError <= 10 }

    var accuracyLabel: String {
        switch winError {
        case ..<4:  return "Perfect read!"
        case ..<9:  return "Great read"
        case ..<16: return "Close"
        default:    return "Way off"
        }
    }
}

/// A pick-able position on the table.
enum CardSlot: Identifiable, Hashable {
    case hero(Int)                     // 0…1
    case board(Int)                    // 0…4
    case villain(opp: Int, card: Int)  // opponent index, card 0…1

    var id: String {
        switch self {
        case .hero(let i):  return "h\(i)"
        case .board(let i): return "b\(i)"
        case .villain(let o, let c): return "v\(o)-\(c)"
        }
    }

    var label: String {
        switch self {
        case .hero(let i):  return i == 0 ? "your 1st card" : "your 2nd card"
        case .board(0), .board(1), .board(2): return "a flop card"
        case .board(3):     return "the turn"
        case .board(4):     return "the river"
        case .villain(let o, _): return "P\(o + 1)'s card"
        default:            return "a card"
        }
    }
}

@MainActor
final class TrainerViewModel: ObservableObject {

    // MARK: Table state
    @Published private(set) var heroSlots: [Card?] = [nil, nil]
    @Published private(set) var boardSlots: [Card?] = [nil, nil, nil, nil, nil]
    @Published private(set) var villainCards: [[Card?]] = [[nil, nil]]   // Build-mode specific villains
    @Published private(set) var opponentHands: [[Card]] = []             // concrete hidden hands (for showdown)

    // MARK: Settings
    @Published var mode: SessionMode = .play { didSet { modeChanged() } }
    @Published var opponents: Int = 1 { didSet { opponentsChanged() } }
    @Published var range: HandRange = .anyTwo { didSet { rangeChanged() } }
    @Published var position: TablePosition = .middle { didSet { rebuildAdvice() } }
    @Published var potSize: Double = 100 { didSet { rebuildAdvice() } }
    @Published var betToCall: Double = 0 { didSet { rebuildAdvice() } }

    // MARK: Results
    @Published private(set) var equity: EquityResult?
    @Published private(set) var advice: Advice?
    @Published private(set) var isCalculating = false
    @Published private(set) var isHandOver = false
    @Published private(set) var showdown: ShowdownResult?

    // MARK: Quiz state
    @Published var estimatedWinPercent: Double = 50
    @Published private(set) var guessedAction: GuessAction?
    @Published private(set) var isRevealed = false
    @Published private(set) var totalScore = 0
    @Published private(set) var guessesScored = 0
    @Published private(set) var lastRound: RoundResult?
    @Published private(set) var currentStreak = 0
    @Published private(set) var bestStreak = 0
    @Published private(set) var lifetimePoints = 0
    @Published private(set) var lifetimeGuesses = 0

    // MARK: Config / internals
    private let iterations = 20_000
    private let maxOpponents = 8
    private var boardPile: [Card] = []
    private var rng = SystemRandomNumberGenerator()
    private var calcToken = 0
    private let store = UserDefaults.standard

    init() {
        bestStreak = store.integer(forKey: "bestStreak")
        lifetimePoints = store.integer(forKey: "lifetimePoints")
        lifetimeGuesses = store.integer(forKey: "lifetimeGuesses")
        newHand()
    }

    // MARK: Derived
    var hero: [Card] { heroSlots.compactMap { $0 } }
    var board: [Card] { boardSlots.compactMap { $0 } }

    var usedCards: Set<Card> {
        var s = Set(hero + board)
        for pair in villainCards { for c in pair { if let c { s.insert(c) } } }
        return s
    }

    var street: Street { Street.forBoard(count: board.count) }
    var canSimulate: Bool { hero.count == 2 && [0, 3, 4, 5].contains(board.count) }
    var showsOdds: Bool { canSimulate && (mode != .quiz || isRevealed) && !isHandOver }

    var canAdvance: Bool {
        guard mode.dealsRandomly, board.count < 5, hero.count == 2, !isHandOver else { return false }
        return mode != .quiz || isRevealed
    }

    var canReveal: Bool {
        mode == .quiz && !isRevealed && !isHandOver
            && guessedAction != nil && equity != nil && advice != nil
    }

    var canShowdown: Bool {
        guard board.count == 5, hero.count == 2, !isHandOver else { return false }
        return mode != .quiz || isRevealed
    }

    var advanceTitle: String {
        switch board.count {
        case 0: return "Deal Flop"
        case 3: return "Deal Turn"
        case 4: return "Deal River"
        default: return "New Hand"
        }
    }

    var toCall: Double { betToCall }

    var manualHint: String? {
        guard mode == .build, !isHandOver else { return nil }
        if hero.count < 2 { return "Tap the bottom slots to choose your two hole cards." }
        switch board.count {
        case 0: return "Deal a flop by tapping the board — or read your pre-flop odds."
        case 1, 2: return "Pick \(3 - board.count) more flop card\(3 - board.count == 1 ? "" : "s")."
        default: return nil
        }
    }

    func card(at slot: CardSlot) -> Card? {
        switch slot {
        case .hero(let i):  return heroSlots[i]
        case .board(let i): return boardSlots[i]
        case .villain(let o, let c):
            return o < villainCards.count ? villainCards[o][c] : nil
        }
    }

    // MARK: Deal / clear

    /// "New Hand": deal fresh in Play/Quiz, clear the table in Build.
    func newHand() {
        resetHandState()
        if mode.dealsRandomly {
            dealRandomHand()
        } else {
            heroSlots = [nil, nil]
            boardSlots = [nil, nil, nil, nil, nil]
            villainCards = Array(repeating: [nil, nil], count: opponents)
            opponentHands = []
        }
        recompute()
    }

    private func dealRandomHand() {
        var deck = Deck()
        deck.shuffle()
        let h = deck.deal(2)
        heroSlots = [h[0], h[1]]
        boardSlots = [nil, nil, nil, nil, nil]

        var used = Set(h)
        var hands: [[Card]] = []
        for _ in 0..<opponents {
            let available = deck.cards.filter { !used.contains($0) }
            if let hand = range.sample(from: available, using: &rng) {
                hands.append(hand)
                used.formUnion(hand)
            }
        }
        opponentHands = hands
        boardPile = deck.cards.filter { !used.contains($0) }   // cards left for the board
    }

    private func resetHandState() {
        isHandOver = false
        showdown = nil
        resetGuess()
    }

    func setOpponents(_ n: Int) { opponents = min(max(1, n), maxOpponents) }

    /// Reveal the next community card(s) in Play/Quiz.
    func advanceStreet() {
        guard canAdvance else { return }
        let need = board.count == 0 ? 3 : 1
        let start = board.count
        for k in 0..<need where k < boardPile.count { boardSlots[start + k] = boardPile[k] }
        boardPile.removeFirst(min(need, boardPile.count))
        resetGuess()
        recompute()
    }

    // MARK: Build editing

    func setCard(_ card: Card, at slot: CardSlot) {
        if usedCards.contains(card), self.card(at: slot) != card { return }
        switch slot {
        case .hero(let i):  heroSlots[i] = card
        case .board(let i): boardSlots[i] = card
        case .villain(let o, let c): if o < villainCards.count { villainCards[o][c] = card }
        }
        recompute()
    }

    func clear(_ slot: CardSlot) {
        switch slot {
        case .hero(let i):  heroSlots[i] = nil
        case .board(let i): boardSlots[i] = nil
        case .villain(let o, let c): if o < villainCards.count { villainCards[o][c] = nil }
        }
        recompute()
    }

    // MARK: Quiz

    func chooseAction(_ action: GuessAction) {
        guard mode == .quiz, !isRevealed else { return }
        guessedAction = action
    }

    func reveal() {
        guard canReveal, let eq = equity, let g = guessedAction, let adv = advice else { return }
        let actual = eq.equityPercent
        let error = abs(estimatedWinPercent - actual)
        let accuracy = max(0, RoundResult.maxAccuracy - Int((error * 3).rounded()))
        let coachG = adv.action.asGuess
        let matched = (g == coachG)
        let move = matched ? RoundResult.maxMove : 0
        let round = RoundResult(guessedWin: estimatedWinPercent, actualWin: actual,
                                accuracyPoints: accuracy, movePoints: move, guessedAction: g,
                                coachAction: coachG, actionMatched: matched)

        lastRound = round
        totalScore += round.roundPoints
        guessesScored += 1
        currentStreak = round.isGood ? currentStreak + 1 : 0
        if currentStreak > bestStreak { bestStreak = currentStreak }
        lifetimePoints += round.roundPoints
        lifetimeGuesses += 1
        persistStats()
        isRevealed = true
    }

    var lifetimeAverage: Double {
        lifetimeGuesses == 0 ? 0 : Double(lifetimePoints) / Double(lifetimeGuesses)
    }

    func resetStats() {
        bestStreak = 0; currentStreak = 0; lifetimePoints = 0; lifetimeGuesses = 0
        persistStats()
    }

    private func persistStats() {
        store.set(bestStreak, forKey: "bestStreak")
        store.set(lifetimePoints, forKey: "lifetimePoints")
        store.set(lifetimeGuesses, forKey: "lifetimeGuesses")
    }

    private func resetGuess() {
        isRevealed = false
        guessedAction = nil
        estimatedWinPercent = 50
        lastRound = nil
    }

    // MARK: Showdown

    func runShowdown() {
        guard canShowdown else { return }
        let fullBoard = board

        if mode.dealsRandomly {
            // Opponent hands were dealt (hidden) at the start of the hand.
        } else {
            // Build: use specified villains; deal the rest from the range.
            var used = usedCards
            var hands: [[Card]] = []
            for o in 0..<opponents {
                if o < villainCards.count,
                   let a = villainCards[o][0], let b = villainCards[o][1] {
                    hands.append([a, b])
                } else {
                    let available = Card.fullDeck.filter { !used.contains($0) }
                    if let h = range.sample(from: available, using: &rng) {
                        hands.append(h); used.formUnion(h)
                    }
                }
            }
            opponentHands = hands
        }

        guard !opponentHands.isEmpty else { return }
        showdown = Showdown.evaluate(hero: hero, board: fullBoard, opponentHands: opponentHands)
        isHandOver = true
    }

    // MARK: Setting changes

    private func modeChanged() {
        if mode == .quiz { totalScore = 0; guessesScored = 0; currentStreak = 0 }
        newHand()
    }

    private func opponentsChanged() {
        if mode.dealsRandomly {
            newHand()
        } else {
            // Preserve the current board/hero; just resize villain slots.
            if opponents > villainCards.count {
                villainCards.append(contentsOf:
                    Array(repeating: [nil, nil], count: opponents - villainCards.count))
            } else if opponents < villainCards.count {
                villainCards.removeLast(villainCards.count - opponents)
            }
            recompute()
        }
    }

    private func rangeChanged() {
        if mode.dealsRandomly { newHand() } else { recompute() }
    }

    // MARK: Equity model

    private func opponentModel() -> [Opponent] {
        if mode.dealsRandomly {
            return Array(repeating: .range(range), count: opponents)
        }
        return (0..<opponents).map { o in
            if o < villainCards.count, let a = villainCards[o][0], let b = villainCards[o][1] {
                return .fixed([a, b])
            }
            return .range(range)
        }
    }

    private func recompute() {
        guard canSimulate else {
            equity = nil; advice = nil; isCalculating = false; calcToken += 1
            return
        }
        let h = hero, b = board, model = opponentModel(), iters = iterations
        calcToken += 1
        let token = calcToken
        isCalculating = true

        Task {
            let result = await Task.detached(priority: .userInitiated) { () -> EquityResult in
                // Exact enumeration when every opponent is known and ≤ 2 board cards remain.
                let allFixed = model.allSatisfy { !$0.isRange }
                if allFixed && (5 - b.count) <= 2 {
                    return EquityCalculator.exact(hero: h, board: b, villains: model.map { $0.fixedCards })
                }
                var g = SystemRandomNumberGenerator()
                return EquityCalculator.simulate(hero: h, board: b, opponents: model,
                                                 iterations: iters, using: &g)
            }.value
            guard token == self.calcToken else { return }
            self.equity = result
            self.rebuildAdvice()
            self.isCalculating = false
        }
    }

    private func rebuildAdvice() {
        guard let equity, canSimulate else { advice = nil; return }
        let draws = DrawDetector.analyze(hero: hero, board: board)
        advice = Coach.advise(hero: hero, board: board, opponents: opponents,
                              pot: potSize, toCall: betToCall,
                              equity: equity, draws: draws, position: position)
    }
}
