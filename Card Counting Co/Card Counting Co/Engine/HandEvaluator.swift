//
//  HandEvaluator.swift
//  Card Counting Co.
//
//  Evaluates the best 5-card poker hand out of 5, 6 or 7 cards and produces a
//  fully comparable value (category + ordered kickers). This replaces the old
//  app's buggy hand logic with a correct, testable implementation.
//

import Foundation

/// The nine standard hand categories, ordered worst → best by `rawValue`.
public enum HandCategory: Int, Comparable, CaseIterable, Codable {
    case highCard = 0
    case pair
    case twoPair
    case threeOfAKind
    case straight
    case flush
    case fullHouse
    case fourOfAKind
    case straightFlush   // includes the royal flush (an ace-high straight flush)

    public var name: String {
        switch self {
        case .highCard:      return "High Card"
        case .pair:          return "Pair"
        case .twoPair:       return "Two Pair"
        case .threeOfAKind:  return "Three of a Kind"
        case .straight:      return "Straight"
        case .flush:         return "Flush"
        case .fullHouse:     return "Full House"
        case .fourOfAKind:   return "Four of a Kind"
        case .straightFlush: return "Straight Flush"
        }
    }

    public static func < (lhs: HandCategory, rhs: HandCategory) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

/// A fully ranked hand. Comparison is: category first, then kickers compared
/// left-to-right (each kicker is a rank value 2…14, most significant first).
public struct HandValue: Comparable, Codable, Hashable {
    public let category: HandCategory
    public let kickers: [Int]

    public init(category: HandCategory, kickers: [Int]) {
        self.category = category
        self.kickers = kickers
    }

    /// Human-readable description, e.g. "Full House, Kings over Threes".
    public var describe: String {
        // Partial (pre-flop) values carry no kickers; fall back to the name.
        guard !kickers.isEmpty else { return category.name }
        func word(_ v: Int) -> String { Rank(rawValue: v)?.word ?? "\(v)" }
        func plural(_ v: Int) -> String { Rank(rawValue: v)?.plural ?? "\(v)s" }
        switch category {
        case .highCard:
            return "High Card, \(word(kickers[0])) high"
        case .pair:
            return "Pair of \(plural(kickers[0]))"
        case .twoPair:
            return "Two Pair, \(plural(kickers[0])) and \(plural(kickers[1]))"
        case .threeOfAKind:
            return "Three of a Kind, \(plural(kickers[0]))"
        case .straight:
            return "Straight, \(word(kickers[0])) high"
        case .flush:
            return "Flush, \(word(kickers[0])) high"
        case .fullHouse:
            return "Full House, \(plural(kickers[0])) over \(plural(kickers[1]))"
        case .fourOfAKind:
            return "Four of a Kind, \(plural(kickers[0]))"
        case .straightFlush:
            return kickers[0] == 14 ? "Royal Flush" : "Straight Flush, \(word(kickers[0])) high"
        }
    }

    public static func < (lhs: HandValue, rhs: HandValue) -> Bool {
        if lhs.category != rhs.category { return lhs.category < rhs.category }
        for (a, b) in zip(lhs.kickers, rhs.kickers) where a != b { return a < b }
        return false
    }
}

public enum HandEvaluator {

    /// Evaluate the best 5-card hand from any 5–7 cards.
    public static func evaluate(_ cards: [Card]) -> HandValue {
        precondition(cards.count >= 5, "Need at least 5 cards to evaluate")

        // Count cards per rank (index 2…14) and per suit.
        var rankCounts = [Int](repeating: 0, count: 15)   // 0,1 unused
        var suitCards: [Suit: [Int]] = [:]                 // suit → rank values present
        for c in cards {
            rankCounts[c.rank.rawValue] += 1
            suitCards[c.suit, default: []].append(c.rank.rawValue)
        }

        // --- Flush / straight-flush detection ---------------------------------
        var flushSuitRanks: [Int]? = nil
        for (_, ranks) in suitCards where ranks.count >= 5 {
            flushSuitRanks = ranks.sorted(by: >)
        }

        if let flushRanks = flushSuitRanks,
           let sfHigh = highestStraight(inRankSet: Set(flushRanks)) {
            return HandValue(category: .straightFlush, kickers: [sfHigh])
        }

        // --- Rank multiplicities ----------------------------------------------
        // Ranks grouped by how many of each we hold, each list sorted high→low.
        var quads: [Int] = [], trips: [Int] = [], pairs: [Int] = [], singles: [Int] = []
        for value in stride(from: 14, through: 2, by: -1) {
            switch rankCounts[value] {
            case 4: quads.append(value)
            case 3: trips.append(value)
            case 2: pairs.append(value)
            case 1: singles.append(value)
            default: break
            }
        }

        // Four of a kind.
        if let quad = quads.first {
            let kicker = bestKickers(excluding: [quad], rankCounts: rankCounts, count: 1)
            return HandValue(category: .fourOfAKind, kickers: [quad] + kicker)
        }

        // Full house: a trip plus a pair (or a second trip acting as the pair).
        if let trip = trips.first {
            let pairCandidates = trips.dropFirst().map { $0 } + pairs
            if let pair = pairCandidates.max() {
                return HandValue(category: .fullHouse, kickers: [trip, pair])
            }
        }

        // Flush (highest five of the flush suit).
        if let flushRanks = flushSuitRanks {
            return HandValue(category: .flush, kickers: Array(flushRanks.prefix(5)))
        }

        // Straight.
        let distinctRanks = Set(cards.map { $0.rank.rawValue })
        if let high = highestStraight(inRankSet: distinctRanks) {
            return HandValue(category: .straight, kickers: [high])
        }

        // Three of a kind.
        if let trip = trips.first {
            let kickers = bestKickers(excluding: [trip], rankCounts: rankCounts, count: 2)
            return HandValue(category: .threeOfAKind, kickers: [trip] + kickers)
        }

        // Two pair (best two pairs + best remaining kicker).
        if pairs.count >= 2 {
            let top = pairs[0], second = pairs[1]
            let kicker = bestKickers(excluding: [top, second], rankCounts: rankCounts, count: 1)
            return HandValue(category: .twoPair, kickers: [top, second] + kicker)
        }

        // One pair.
        if let pair = pairs.first {
            let kickers = bestKickers(excluding: [pair], rankCounts: rankCounts, count: 3)
            return HandValue(category: .pair, kickers: [pair] + kickers)
        }

        // High card.
        return HandValue(category: .highCard, kickers: Array(singles.prefix(5)))
    }

    // MARK: - Helpers

    /// Highest card of the best 5-in-a-row within a set of rank values.
    /// Returns the straight's high card, or nil. Handles the wheel (A-2-3-4-5),
    /// where the ace plays low and the high card is the Five.
    static func highestStraight(inRankSet ranks: Set<Int>) -> Int? {
        var present = ranks
        if present.contains(14) { present.insert(1) }   // ace can play low
        // Check from ace-high (14…10) down to the wheel (5…1).
        for high in stride(from: 14, through: 5, by: -1) {
            if (high - 4 ... high).allSatisfy({ present.contains($0) }) {
                return high
            }
        }
        return nil
    }

    /// Top `count` kicker ranks (each a distinct rank value present in the
    /// hand), skipping any excluded ranks, high→low.
    private static func bestKickers(excluding excluded: [Int],
                                    rankCounts: [Int],
                                    count: Int) -> [Int] {
        var result: [Int] = []
        for value in stride(from: 14, through: 2, by: -1) {
            if excluded.contains(value) { continue }
            if rankCounts[value] > 0 {
                result.append(value)
                if result.count == count { break }
            }
        }
        return result
    }
}
