//
//  Deck.swift
//  Card Counting Co.
//
//  A shuffleable 52-card deck plus a small seedable RNG so the Monte-Carlo
//  equity work is reproducible in tests.
//

import Foundation

/// Deterministic, fast PRNG (SplitMix64). Seeding it makes simulations
/// repeatable, which is what lets the engine tests assert on equity numbers.
public struct SeededGenerator: RandomNumberGenerator {
    private var state: UInt64

    public init(seed: UInt64) { self.state = seed }

    public mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }
}

/// A mutable deck you can shuffle and deal from.
public struct Deck {
    public private(set) var cards: [Card]

    /// A fresh, ordered 52-card deck.
    public init() { cards = Card.fullDeck }

    /// A deck that excludes the given cards (e.g. cards already on the table).
    public init(excluding used: Set<Card>) {
        cards = Card.fullDeck.filter { !used.contains($0) }
    }

    public mutating func shuffle<G: RandomNumberGenerator>(using generator: inout G) {
        cards.shuffle(using: &generator)
    }

    public mutating func shuffle() {
        var g = SystemRandomNumberGenerator()
        shuffle(using: &g)
    }

    /// Deal `n` cards off the top.
    public mutating func deal(_ n: Int) -> [Card] {
        let dealt = Array(cards.prefix(n))
        cards.removeFirst(min(n, cards.count))
        return dealt
    }

    public mutating func deal() -> Card? {
        cards.isEmpty ? nil : cards.removeFirst()
    }

    public var count: Int { cards.count }
}
