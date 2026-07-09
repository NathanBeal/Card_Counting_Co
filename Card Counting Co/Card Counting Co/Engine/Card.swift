//
//  Card.swift
//  Card Counting Co.
//
//  A card is pure data — no images. The UI draws it from `rank` + `suit`.
//  This file imports only Foundation so the whole engine can be unit-tested
//  without a UI (or even a simulator).
//

import Foundation

/// The four suits. `sfSymbolName` and `glyph` are just strings the UI can use
/// to render the card programmatically; the engine itself never touches UIKit.
public enum Suit: Int, CaseIterable, Comparable, Codable, Hashable {
    case clubs, diamonds, hearts, spades

    /// SF Symbol used to draw the suit (no PNG assets required).
    public var sfSymbolName: String {
        switch self {
        case .clubs:    return "suit.club.fill"
        case .diamonds: return "suit.diamond.fill"
        case .hearts:   return "suit.heart.fill"
        case .spades:   return "suit.spade.fill"
        }
    }

    /// Unicode pip, handy for text / accessibility / debugging.
    public var glyph: String {
        switch self {
        case .clubs:    return "♣"
        case .diamonds: return "♦"
        case .hearts:   return "♥"
        case .spades:   return "♠"
        }
    }

    /// Hearts and diamonds render red; clubs and spades render black.
    public var isRed: Bool { self == .hearts || self == .diamonds }

    public var name: String {
        switch self {
        case .clubs:    return "Clubs"
        case .diamonds: return "Diamonds"
        case .hearts:   return "Hearts"
        case .spades:   return "Spades"
        }
    }

    public static func < (lhs: Suit, rhs: Suit) -> Bool { lhs.rawValue < rhs.rawValue }
}

/// Card ranks, valued 2…14 (Ace high). Ace-low straights are handled in the
/// evaluator, not here.
public enum Rank: Int, CaseIterable, Comparable, Codable, Hashable {
    case two = 2, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, ace

    /// Short label drawn on the card face.
    public var label: String {
        switch self {
        case .ace:   return "A"
        case .king:  return "K"
        case .queen: return "Q"
        case .jack:  return "J"
        case .ten:   return "10"
        default:     return String(rawValue)
        }
    }

    /// Singular word used in coaching sentences ("a pair of Kings").
    public var word: String {
        switch self {
        case .two: return "Two";     case .three: return "Three"
        case .four: return "Four";   case .five: return "Five"
        case .six: return "Six";     case .seven: return "Seven"
        case .eight: return "Eight"; case .nine: return "Nine"
        case .ten: return "Ten";     case .jack: return "Jack"
        case .queen: return "Queen"; case .king: return "King"
        case .ace: return "Ace"
        }
    }

    /// Plural word ("a pair of Kings", "three Nines").
    public var plural: String { word == "Six" ? "Sixes" : word + "s" }

    public static func < (lhs: Rank, rhs: Rank) -> Bool { lhs.rawValue < rhs.rawValue }
}

/// A single playing card. `Identifiable` id is stable and unique per card so
/// SwiftUI can animate them without images.
public struct Card: Hashable, Codable, Comparable, Identifiable, CustomStringConvertible {
    public let rank: Rank
    public let suit: Suit

    public init(_ rank: Rank, _ suit: Suit) {
        self.rank = rank
        self.suit = suit
    }

    /// 0…51, unique per card.
    public var id: Int { rank.rawValue * 4 + suit.rawValue }

    public var description: String { "\(rank.label)\(suit.glyph)" }

    /// Compared by rank first (suit only breaks ties for stable ordering — poker
    /// itself has no suit ranking).
    public static func < (lhs: Card, rhs: Card) -> Bool {
        if lhs.rank != rhs.rank { return lhs.rank < rhs.rank }
        return lhs.suit < rhs.suit
    }
}

public extension Card {
    /// The full 52-card deck in a canonical order.
    static let fullDeck: [Card] = Suit.allCases.flatMap { suit in
        Rank.allCases.map { Card($0, suit) }
    }
}
