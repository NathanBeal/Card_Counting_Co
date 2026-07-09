//
//  Theme.swift
//  Card Counting Co.
//
//  Central colors and small view helpers. The whole app is a dark poker-felt
//  aesthetic, drawn entirely in code — there are no image assets.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

enum Felt {
    static let deep   = Color(red: 0.03, green: 0.22, blue: 0.14)
    static let mid    = Color(red: 0.05, green: 0.33, blue: 0.21)
    static let rail    = Color(red: 0.20, green: 0.11, blue: 0.06)
    static let gold    = Color(red: 0.85, green: 0.69, blue: 0.34)
    static let cardFace = Color(red: 0.98, green: 0.98, blue: 0.96)
    static let redSuit  = Color(red: 0.80, green: 0.16, blue: 0.16)
    static let blackSuit = Color(red: 0.12, green: 0.13, blue: 0.16)
    static let backA    = Color(red: 0.55, green: 0.09, blue: 0.13)
    static let backB    = Color(red: 0.28, green: 0.04, blue: 0.08)

    /// Radial felt gradient used behind the whole table.
    static var background: some View {
        RadialGradient(
            colors: [mid, deep],
            center: .center,
            startRadius: 40,
            endRadius: 520
        )
        .ignoresSafeArea()
    }
}

extension Suit {
    /// UI color for the suit (the engine only knows `isRed`).
    var color: Color { isRed ? Felt.redSuit : Felt.blackSuit }
}

/// Light haptic feedback, no-op where UIKit isn't available.
enum Haptics {
    static func tap() {
        #if canImport(UIKit)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #endif
    }
    static func thud() {
        #if canImport(UIKit)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        #endif
    }
}

extension PokerAction {
    /// Color-coded so the recommendation reads at a glance.
    var tint: Color {
        switch self {
        case .fold:  return Color(red: 0.78, green: 0.22, blue: 0.22)
        case .check: return Color(red: 0.40, green: 0.45, blue: 0.52)
        case .call:  return Color(red: 0.20, green: 0.52, blue: 0.78)
        case .bet:   return Color(red: 0.18, green: 0.60, blue: 0.36)
        case .raise: return Color(red: 0.90, green: 0.55, blue: 0.15)
        }
    }
}
