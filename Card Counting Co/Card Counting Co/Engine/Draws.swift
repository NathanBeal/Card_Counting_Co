//
//  Draws.swift
//  Card Counting Co.
//
//  Names the draws the hero is on and counts outs (unseen cards that improve
//  the hand). Used to explain *why* the coach recommends what it does.
//

import Foundation

public struct DrawAnalysis: Equatable {
    /// The hero's current best made hand.
    public let made: HandValue
    /// Number of unseen cards that raise the hand to a higher category.
    public let outs: Int
    /// Those specific cards (useful for detail / debugging).
    public let outCards: [Card]
    /// Named draws in plain English, e.g. "Flush draw", "Open-ended straight draw".
    public let labels: [String]

    public static let none = DrawAnalysis(made: HandValue(category: .highCard, kickers: [0]),
                                          outs: 0, outCards: [], labels: [])
}

public enum DrawDetector {

    /// Analyse the hero's made hand and drawing potential on the current board.
    /// Outs are only meaningful before the river, so they're 0 on a full board.
    public static func analyze(hero: [Card], board: [Card]) -> DrawAnalysis {
        let all = hero + board
        guard all.count >= 2 else { return .none }

        let made = all.count >= 5
            ? HandEvaluator.evaluate(all)
            : HandValue(category: bestPartialCategory(all), kickers: [])

        // Outs: unseen cards that would bump us to a higher category next street.
        var outs: [Card] = []
        var labels: [String] = []

        if board.count >= 3 && board.count < 5 {
            let known = Set(all)
            let unseen = Card.fullDeck.filter { !known.contains($0) }
            let currentCategory = HandEvaluator.evaluate(all).category
            // Count outs to a *meaningfully* stronger hand. The floor is a pair,
            // so simply pairing a card when you have nothing isn't treated as an
            // out — that keeps the classic counts (flush draw = 9, OESD = 8,
            // gutshot = 4) instead of over-counting every board pair.
            let baseline = max(currentCategory, .pair)
            for card in unseen {
                if HandEvaluator.evaluate(all + [card]).category > baseline {
                    outs.append(card)
                }
            }
            labels = drawLabels(hero: hero, board: board)
        }

        return DrawAnalysis(made: made, outs: outs.count, outCards: outs, labels: labels)
    }

    // MARK: - Helpers

    /// A rough category when we hold fewer than 5 cards (pre-flop), enough to
    /// describe "pair" / "high card" without a full evaluation.
    private static func bestPartialCategory(_ cards: [Card]) -> HandCategory {
        var counts = [Int: Int]()
        for c in cards { counts[c.rank.rawValue, default: 0] += 1 }
        let maxCount = counts.values.max() ?? 1
        switch maxCount {
        case 4: return .fourOfAKind
        case 3: return .threeOfAKind
        case 2: return counts.values.filter { $0 == 2 }.count >= 2 ? .twoPair : .pair
        default: return .highCard
        }
    }

    private static func drawLabels(hero: [Card], board: [Card]) -> [String] {
        var labels: [String] = []
        let all = hero + board

        // Flush draw: four to a flush (and no made flush yet).
        var suitCounts = [Suit: Int]()
        for c in all { suitCounts[c.suit, default: 0] += 1 }
        if suitCounts.values.contains(4) { labels.append("Flush draw") }

        // Straight draw: how many distinct ranks complete a straight?
        let present = Set(all.map { $0.rank.rawValue })
        let alreadyStraight = HandEvaluator.highestStraight(inRankSet: present) != nil
        if !alreadyStraight {
            var completing = 0
            for value in 2...14 where !present.contains(value) {
                var test = present
                test.insert(value)
                if HandEvaluator.highestStraight(inRankSet: test) != nil { completing += 1 }
            }
            if completing >= 2 {
                labels.append("Open-ended straight draw")
            } else if completing == 1 {
                labels.append("Gutshot straight draw")
            }
        }

        // Overcards: two unpaired hole cards both bigger than the whole board.
        if hero.count == 2, hero[0].rank != hero[1].rank,
           let boardHigh = board.map({ $0.rank.rawValue }).max(),
           hero.allSatisfy({ $0.rank.rawValue > boardHigh }),
           !board.map({ $0.rank.rawValue }).contains(hero[0].rank.rawValue),
           !board.map({ $0.rank.rawValue }).contains(hero[1].rank.rawValue) {
            labels.append("Two overcards")
        }

        return labels
    }
}
