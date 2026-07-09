//
//  Equity.swift
//  Outs
//
//  Your real chance of winning the hand. Opponents can be modeled as a range
//  of hands (Monte-Carlo) or as exact known hands (fast exact enumeration when
//  few board cards remain). Replaces the old app's static probability tables.
//

import Foundation

public struct EquityResult: Equatable {
    public let win: Double
    public let tie: Double
    public let lose: Double
    public let equity: Double        // expected pot share (win + split fraction of ties)
    public let iterations: Int
    /// True when produced by exact enumeration rather than sampling.
    public var exact: Bool = false

    public var winPercent: Double { win * 100 }
    public var tiePercent: Double { tie * 100 }
    public var losePercent: Double { lose * 100 }
    public var equityPercent: Double { equity * 100 }
}

public enum EquityCalculator {

    // MARK: General Monte-Carlo (ranges and/or fixed opponents)

    public static func simulate<G: RandomNumberGenerator>(
        hero: [Card], board: [Card], opponents: [Opponent],
        iterations: Int, using generator: inout G
    ) -> EquityResult {
        precondition(hero.count == 2, "Hero must hold exactly two cards")
        precondition((0...5).contains(board.count), "Board must be 0–5 cards")
        precondition(!opponents.isEmpty, "Need at least one opponent")

        let fixed = opponents.flatMap { $0.fixedCards }
        let known = Set(hero + board + fixed)
        let basePool = Card.fullDeck.filter { !known.contains($0) }
        let boardNeed = 5 - board.count
        let rangeCount = opponents.reduce(0) { $0 + ($1.isRange ? 1 : 0) }
        guard basePool.count >= rangeCount * 2 + boardNeed else {
            return EquityResult(win: 0, tie: 0, lose: 1, equity: 0, iterations: 0)
        }

        var wins = 0, ties = 0, losses = 0
        var equitySum = 0.0

        for _ in 0..<iterations {
            var avail = basePool
            avail.shuffle(using: &generator)
            var idx = 0

            var oppHands: [[Card]] = []
            oppHands.reserveCapacity(opponents.count)
            for opp in opponents {
                switch opp {
                case .fixed(let c): oppHands.append(c)
                case .range(let r): oppHands.append(drawPair(&avail, &idx, r, &generator))
                }
            }

            let full = board + Array(avail[idx..<idx + boardNeed])
            let heroVal = HandEvaluator.evaluate(hero + full)

            var better = 0, equal = 0
            for oh in oppHands {
                let ov = HandEvaluator.evaluate(oh + full)
                if ov > heroVal { better += 1 } else if ov == heroVal { equal += 1 }
            }

            if better > 0 { losses += 1 }
            else if equal > 0 { ties += 1; equitySum += 1.0 / Double(equal + 1) }
            else { wins += 1; equitySum += 1.0 }
        }

        let n = Double(iterations)
        return EquityResult(win: Double(wins) / n, tie: Double(ties) / n,
                            lose: Double(losses) / n, equity: equitySum / n,
                            iterations: iterations)
    }

    /// Draw a two-card hand inside `range` from the front of `avail`, advancing
    /// `idx`. Rejection sampling; `avail` is assumed pre-shuffled.
    private static func drawPair<G: RandomNumberGenerator>(
        _ avail: inout [Card], _ idx: inout Int, _ range: HandRange, _ gen: inout G
    ) -> [Card] {
        let n = avail.count
        if range.fraction >= 1.0 {
            defer { idx += 2 }
            return [avail[idx], avail[idx + 1]]
        }
        var tries = 0
        while tries < 200, n - idx >= 2 {
            tries += 1
            let i = idx + Int(gen.next() % UInt64(n - idx))
            avail.swapAt(idx, i)
            let j = (idx + 1) + Int(gen.next() % UInt64(n - (idx + 1)))
            avail.swapAt(idx + 1, j)
            if range.contains(avail[idx], avail[idx + 1]) {
                defer { idx += 2 }
                return [avail[idx], avail[idx + 1]]
            }
        }
        defer { idx += 2 }
        return [avail[idx], avail[idx + 1]]
    }

    // MARK: Exact enumeration (all opponents are known hands, few board cards left)

    /// Exhaustively enumerate the remaining board cards. Only sensible when at
    /// most two board cards remain (≤ ~1000 combinations); returns 0 iterations
    /// otherwise so the caller can fall back to Monte-Carlo.
    public static func exact(hero: [Card], board: [Card], villains: [[Card]]) -> EquityResult {
        let known = Set(hero + board + villains.flatMap { $0 })
        let pool = Card.fullDeck.filter { !known.contains($0) }
        let need = 5 - board.count

        var wins = 0, ties = 0, losses = 0, count = 0
        var equitySum = 0.0

        func evaluate(_ extra: [Card]) {
            let full = board + extra
            let heroVal = HandEvaluator.evaluate(hero + full)
            var better = 0, equal = 0
            for v in villains {
                let ov = HandEvaluator.evaluate(v + full)
                if ov > heroVal { better += 1 } else if ov == heroVal { equal += 1 }
            }
            if better > 0 { losses += 1 }
            else if equal > 0 { ties += 1; equitySum += 1.0 / Double(equal + 1) }
            else { wins += 1; equitySum += 1.0 }
            count += 1
        }

        switch need {
        case 0: evaluate([])
        case 1: for c in pool { evaluate([c]) }
        case 2:
            for a in 0..<pool.count {
                for b in (a + 1)..<pool.count { evaluate([pool[a], pool[b]]) }
            }
        default:
            return EquityResult(win: 0, tie: 0, lose: 0, equity: 0, iterations: 0)
        }

        guard count > 0 else { return EquityResult(win: 0, tie: 0, lose: 1, equity: 0, iterations: 0) }
        let d = Double(count)
        return EquityResult(win: Double(wins) / d, tie: Double(ties) / d,
                            lose: Double(losses) / d, equity: equitySum / d,
                            iterations: count, exact: true)
    }

    // MARK: Convenience overloads

    public static func simulate<G: RandomNumberGenerator>(
        hero: [Card], board: [Card], opponents: Int, range: HandRange,
        iterations: Int, using generator: inout G
    ) -> EquityResult {
        simulate(hero: hero, board: board,
                 opponents: Array(repeating: .range(range), count: max(1, opponents)),
                 iterations: iterations, using: &generator)
    }

    /// Legacy overload: opponents hold any two random cards.
    public static func simulate<G: RandomNumberGenerator>(
        hero: [Card], board: [Card], opponents: Int, iterations: Int, using generator: inout G
    ) -> EquityResult {
        simulate(hero: hero, board: board, opponents: opponents, range: .anyTwo,
                 iterations: iterations, using: &generator)
    }

    public static func simulate(
        hero: [Card], board: [Card], opponents: Int, range: HandRange = .anyTwo, iterations: Int
    ) -> EquityResult {
        var g = SystemRandomNumberGenerator()
        return simulate(hero: hero, board: board, opponents: opponents, range: range,
                        iterations: iterations, using: &g)
    }
}
