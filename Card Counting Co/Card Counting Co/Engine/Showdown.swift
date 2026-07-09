//
//  Showdown.swift
//  Outs
//
//  At the end of a hand, reveal everyone's cards and decide who wins.
//

import Foundation

public struct PlayerShowdown: Identifiable {
    public let id: Int          // 0 = hero, 1…n = opponents
    public let label: String    // "You", "P1", "P2"…
    public let cards: [Card]
    public let value: HandValue
    public let isWinner: Bool
}

public struct ShowdownResult {
    public let players: [PlayerShowdown]     // hero first
    public let heroWon: Bool                 // hero is among the winners
    public let isChop: Bool                  // more than one winner
    public let winningValue: HandValue

    /// One-line result headline.
    public var headline: String {
        let winners = players.filter { $0.isWinner }.map { $0.label }
        if heroWon && !isChop { return "You win — \(winningValue.describe)" }
        if heroWon && isChop  { return "You split the pot — \(winningValue.describe)" }
        if winners.count == 1 { return "\(winners[0]) wins — \(winningValue.describe)" }
        return "\(winners.joined(separator: " & ")) split — \(winningValue.describe)"
    }
}

public enum Showdown {

    /// Evaluate the hero and every opponent on the final board.
    public static func evaluate(hero: [Card], board: [Card],
                                opponentHands: [[Card]]) -> ShowdownResult {
        let heroValue = HandEvaluator.evaluate(hero + board)

        var scored: [(idx: Int, label: String, cards: [Card], value: HandValue)] = []
        scored.append((0, "You", hero, heroValue))
        for (i, hand) in opponentHands.enumerated() {
            scored.append((i + 1, "P\(i + 1)", hand, HandEvaluator.evaluate(hand + board)))
        }

        let best = scored.map { $0.value }.max()!
        let players = scored.map {
            PlayerShowdown(id: $0.idx, label: $0.label, cards: $0.cards,
                           value: $0.value, isWinner: $0.value == best)
        }
        let winnerCount = players.filter { $0.isWinner }.count

        return ShowdownResult(players: players,
                              heroWon: heroValue == best,
                              isChop: winnerCount > 1,
                              winningValue: best)
    }
}
