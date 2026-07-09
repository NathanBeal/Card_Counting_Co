//
//  Coach.swift
//  Card Counting Co.
//
//  Turns live equity + pot odds + draws into a recommended action and, more
//  importantly, the reasoning behind it. This is the "teach them what to do"
//  half of the app.
//

import Foundation

public enum Street: Int, Codable {
    case preflop = 0, flop, turn, river

    public var name: String {
        switch self {
        case .preflop: return "Pre-flop"
        case .flop:    return "Flop"
        case .turn:    return "Turn"
        case .river:   return "River"
        }
    }

    /// Community cards on the board at this street.
    public static func forBoard(count: Int) -> Street {
        switch count {
        case 0:  return .preflop
        case 3:  return .flop
        case 4:  return .turn
        default: return .river
        }
    }
}

public enum PokerAction: String, Codable {
    case fold, check, call, bet, raise

    public var verb: String { rawValue.capitalized }
}

public struct Advice: Equatable {
    public let action: PokerAction
    public let headline: String
    public let reasons: [String]
    public let equity: EquityResult
    public let draws: DrawAnalysis
    /// Equity required to profitably call, when facing a bet (0…1). Nil if the
    /// action is checked to the hero.
    public let requiredEquity: Double?
}

/// Where the hero is sitting relative to the button — later position lets you
/// play more hands and bet more freely.
public enum TablePosition: String, CaseIterable, Identifiable, Codable {
    case early = "Early", middle = "Middle", late = "Late", blinds = "Blinds"
    public var id: String { rawValue }

    public var name: String {
        switch self {
        case .early:  return "early position"
        case .middle: return "middle position"
        case .late:   return "late position"
        case .blinds: return "the blinds"
        }
    }

    /// Higher = be more aggressive. Late position is boldest.
    var aggressionBias: Double {
        switch self {
        case .early:  return -0.04
        case .middle: return 0
        case .late:   return 0.04
        case .blinds: return -0.02
        }
    }
}

public enum Coach {

    /// Produce advice for the current spot.
    ///
    /// - Parameters:
    ///   - hero/board/opponents: the situation.
    ///   - pot: chips in the middle before the hero acts.
    ///   - toCall: chips the hero must put in to continue (0 = checked to hero).
    ///   - equity: pre-computed Monte-Carlo equity for this spot.
    ///   - draws: pre-computed draw / outs analysis.
    public static func advise(
        hero: [Card],
        board: [Card],
        opponents: Int,
        pot: Double,
        toCall: Double,
        equity: EquityResult,
        draws: DrawAnalysis,
        position: TablePosition = .middle
    ) -> Advice {
        let street = Street.forBoard(count: board.count)
        let eq = equity.equity                       // 0…1 pot share
        let facingBet = toCall > 0
        let requiredEquity = facingBet ? toCall / (pot + toCall) : nil

        var reasons: [String] = []

        // 1. Equity line.
        reasons.append(String(format: "You win this hand about %.0f%% of the time against %d opponent%@.",
                              equity.equityPercent, opponents, opponents == 1 ? "" : "s"))

        // 2. Made hand.
        if board.count >= 5 || board.count >= 3 {
            reasons.append("Right now you have: \(draws.made.describe).")
        }

        // 3. Draws + rule of 2 and 4.
        if !draws.labels.isEmpty, draws.outs > 0, board.count < 5 {
            let cardsToCome = 5 - board.count
            let improve = min(Double(draws.outs) * (cardsToCome >= 2 ? 4 : 2), 95)
            reasons.append("\(draws.labels.joined(separator: " + ")): \(draws.outs) outs (~\(Int(improve))% to improve by the river).")
        }

        // 4. Pot odds.
        if let req = requiredEquity {
            reasons.append(String(format: "Pot odds: calling %.0f into %.0f needs you to win %.0f%% of the time.",
                                  toCall, pot, req * 100))
        }

        // 5. Position note (only when it changes the read).
        switch position {
        case .early:
            reasons.append("You're in early position with players still to act — lean cautious.")
        case .late:
            reasons.append("You're in late position, so you can play a little wider and bet more freely.")
        case .blinds:
            reasons.append("You'll be out of position after the flop — be a touch more careful.")
        case .middle:
            break
        }

        // Position nudges how aggressive we are: later = looser/bolder.
        let posBias = position.aggressionBias
        let valueBetThreshold = 0.62 - posBias
        let raiseMargin = 0.15 - posBias

        // Decide the action.
        let action: PokerAction
        let headline: String

        if facingBet {
            let req = requiredEquity!
            let margin = eq - req
            if margin < -0.02 {
                // Below the price. Only continue on a big draw with implied odds.
                if draws.outs >= 8 && street != .river {
                    action = .call
                    headline = "Call — close odds with a strong draw"
                    reasons.append("You're slightly short of the direct price, but a big draw plus future betting (implied odds) makes calling reasonable.")
                } else {
                    action = .fold
                    headline = "Fold — the price is too high for your equity"
                    reasons.append("Your chance to win is below what the pot is offering, so calling loses money over time.")
                }
            } else if margin < raiseMargin {
                action = .call
                headline = "Call — you have the odds to continue"
                reasons.append("Your equity clears the pot-odds price, so continuing is profitable.")
            } else {
                action = .raise
                headline = "Raise — you're a clear favorite"
                reasons.append("You're well ahead of the price. Raising builds the pot while you hold the edge.")
            }
        } else {
            // Checked to the hero: no price to pay.
            if eq >= valueBetThreshold {
                action = .bet
                headline = "Bet — value your strong hand"
                reasons.append("You're a favorite, so bet to build the pot and charge draws.")
            } else if draws.outs >= 8 && street != .river && eq >= 0.30 {
                action = .bet
                headline = "Bet — semi-bluff with your draw"
                reasons.append("Betting your draw can win it now and pays off big when you hit.")
            } else if eq >= 0.45 {
                action = .check
                headline = "Check — pot control with a marginal hand"
                reasons.append("Your hand is playable but not strong enough to build a big pot.")
            } else {
                action = .check
                headline = "Check — take a free card"
                reasons.append("No reason to put money in with a weak hand when checking is free.")
            }
        }

        return Advice(action: action,
                      headline: headline,
                      reasons: reasons,
                      equity: equity,
                      draws: draws,
                      requiredEquity: requiredEquity)
    }
}
