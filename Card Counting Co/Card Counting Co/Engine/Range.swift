//
//  Range.swift
//  Outs
//
//  Models opponents as a *range* of starting hands instead of "any two cards".
//  Real players fold trash, so equity against a sensible range is more honest
//  than equity against random holdings. Hand strength uses the Chen formula.
//

import Foundation

/// The Chen formula — a well-known way to score a Texas Hold'em starting hand.
enum ChenFormula {
    static func score(_ a: Rank, _ b: Rank, suited: Bool) -> Int {
        func highCardPoints(_ r: Int) -> Double {
            switch r {
            case 14: return 10   // Ace
            case 13: return 8    // King
            case 12: return 7    // Queen
            case 11: return 6    // Jack
            default: return Double(r) / 2.0
            }
        }
        let hi = max(a.rawValue, b.rawValue)
        let lo = min(a.rawValue, b.rawValue)

        // Pocket pair: high-card points × 2, minimum 5.
        if a == b { return Int(max(highCardPoints(hi) * 2, 5).rounded()) }

        var points = highCardPoints(hi)
        if suited { points += 2 }

        let gap = hi - lo - 1
        switch gap {
        case 0: break
        case 1: points -= 1
        case 2: points -= 2
        case 3: points -= 4
        default: points -= 5
        }
        // Straight bonus: 0/1 gap with both cards below a Queen.
        if gap <= 1 && hi < 12 { points += 1 }

        return Int(points.rounded())
    }
}

/// A preset opponent range, expressed as "roughly the top X% of starting hands".
public struct HandRange: Hashable, Identifiable {
    public let name: String
    public let fraction: Double     // target top fraction of all hands (0…1)
    public var id: String { name }

    public init(name: String, fraction: Double) {
        self.name = name
        self.fraction = fraction
    }

    public static let anyTwo   = HandRange(name: "Any two cards", fraction: 1.0)
    public static let loose    = HandRange(name: "Loose · top 50%", fraction: 0.50)
    public static let standard = HandRange(name: "Standard · top 25%", fraction: 0.25)
    public static let tight    = HandRange(name: "Tight · top 12%", fraction: 0.12)
    public static let premium  = HandRange(name: "Premium · top 6%", fraction: 0.06)

    public static let presets: [HandRange] = [anyTwo, loose, standard, tight, premium]

    /// Short label for compact UI ("50%", "Any").
    public var shortLabel: String {
        fraction >= 1 ? "Any" : "\(Int((fraction * 100).rounded()))%"
    }

    /// Does a two-card hand fall inside this range?
    public func contains(_ c1: Card, _ c2: Card) -> Bool {
        if fraction >= 1.0 { return true }
        return ChenFormula.score(c1.rank, c2.rank, suited: c1.suit == c2.suit) >= threshold
    }

    /// Deal a concrete two-card hand from this range out of `available` cards.
    /// Used to give an opponent a real (hidden) hand for the showdown.
    public func sample<G: RandomNumberGenerator>(from available: [Card], using gen: inout G) -> [Card]? {
        guard available.count >= 2 else { return nil }
        if fraction >= 1.0 {
            var pool = available
            pool.shuffle(using: &gen)
            return [pool[0], pool[1]]
        }
        for _ in 0..<500 {
            let i = Int(gen.next() % UInt64(available.count))
            let j = Int(gen.next() % UInt64(available.count))
            if i == j { continue }
            if contains(available[i], available[j]) { return [available[i], available[j]] }
        }
        return [available[0], available[1]]   // fallback if the range is very tight
    }

    /// Minimum Chen score to be inside this range, derived from the score
    /// distribution over all 1326 possible two-card combinations.
    var threshold: Int {
        let idx = min(Self.sortedScores.count - 1,
                      max(0, Int(Double(Self.sortedScores.count) * fraction) - 1))
        return Self.sortedScores[idx]
    }

    /// All 1326 combo scores, sorted high→low (computed once).
    private static let sortedScores: [Int] = {
        let deck = Card.fullDeck
        var scores: [Int] = []
        scores.reserveCapacity(1326)
        for i in 0..<deck.count {
            for j in (i + 1)..<deck.count {
                scores.append(ChenFormula.score(deck[i].rank, deck[j].rank,
                                                suited: deck[i].suit == deck[j].suit))
            }
        }
        return scores.sorted(by: >)
    }()
}

/// How a single opponent's cards are modeled for an equity calculation.
public enum Opponent {
    case fixed([Card])       // an exact, known two-card hand
    case range(HandRange)    // a random hand drawn from a range

    public var fixedCards: [Card] { if case .fixed(let c) = self { return c } else { return [] } }
    public var isRange: Bool { if case .range = self { return true } else { return false } }
}
