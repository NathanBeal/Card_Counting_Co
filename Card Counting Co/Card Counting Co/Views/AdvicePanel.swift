//
//  AdvicePanel.swift
//  Card Counting Co.
//
//  The coaching card: a color-coded recommended action plus the reasoning that
//  justifies it (equity, made hand, draws/outs, pot odds).
//

import SwiftUI

struct AdvicePanel: View {
    let advice: Advice?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let advice {
                HStack(spacing: 12) {
                    Text(advice.action.verb.uppercased())
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(advice.action.tint))
                    Text(advice.headline)
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                }

                VStack(alignment: .leading, spacing: 7) {
                    ForEach(Array(advice.reasons.enumerated()), id: \.offset) { _, reason in
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 5))
                                .foregroundColor(Felt.gold)
                                .padding(.top, 6)
                            Text(reason)
                                .font(.footnote)
                                .foregroundColor(.white.opacity(0.85))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }

                if advice.draws.outs > 0, !advice.draws.outCards.isEmpty {
                    OutsStrip(draws: advice.draws)
                }
            } else {
                Text("Deal a hand to get coaching.")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.6))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.black.opacity(0.28))
                .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke((advice?.action.tint ?? .white).opacity(0.35), lineWidth: 1.5))
        )
        .animation(.easeInOut(duration: 0.2), value: advice?.action)
    }
}

/// The actual cards that improve the hand ("your outs"), drawn small.
private struct OutsStrip: View {
    let draws: DrawAnalysis

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("YOUR OUTS · \(draws.outs)")
                .font(.system(size: 10, weight: .bold)).tracking(1.5)
                .foregroundColor(Felt.gold)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    ForEach(draws.outCards) { card in
                        PlayingCardView(card: card, width: 24)
                    }
                }
                .padding(.bottom, 2)
            }
        }
        .padding(.top, 2)
    }
}
