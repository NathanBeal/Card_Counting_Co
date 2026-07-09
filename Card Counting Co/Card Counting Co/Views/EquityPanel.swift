//
//  EquityPanel.swift
//  Card Counting Co.
//
//  Shows the hero's live win / tie / lose equity as a big number plus a
//  segmented bar.
//

import SwiftUI

struct EquityPanel: View {
    let equity: EquityResult?
    let isCalculating: Bool

    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text("Your equity")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.white.opacity(0.7))
                Spacer()
                if isCalculating && equity == nil {
                    ProgressView().tint(.white)
                } else {
                    Text(String(format: "%.1f%%", equity?.equityPercent ?? 0))
                        .font(.system(size: 34, weight: .heavy, design: .rounded))
                        .foregroundColor(Felt.gold)
                        .contentTransition(.numericText())
                        .monospacedDigit()
                }
            }

            bar

            HStack {
                legend("Win", equity?.winPercent ?? 0, .green)
                Spacer()
                legend("Tie", equity?.tiePercent ?? 0, Felt.gold)
                Spacer()
                legend("Lose", equity?.losePercent ?? 0, .red)
            }
            .font(.caption.weight(.medium))
        }
        .padding(16)
        .background(panelBackground)
        .opacity(isCalculating ? 0.75 : 1)
        .animation(.easeInOut(duration: 0.25), value: isCalculating)
    }

    private var bar: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let win = CGFloat((equity?.win ?? 0))
            let tie = CGFloat((equity?.tie ?? 0))
            HStack(spacing: 0) {
                Rectangle().fill(Color.green).frame(width: w * win)
                Rectangle().fill(Felt.gold).frame(width: w * tie)
                Rectangle().fill(Color.red.opacity(0.85))
            }
        }
        .frame(height: 12)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(.white.opacity(0.15), lineWidth: 1))
    }

    private func legend(_ label: String, _ value: Double, _ color: Color) -> some View {
        HStack(spacing: 5) {
            Circle().fill(color).frame(width: 8, height: 8)
            Text("\(label) \(String(format: "%.0f%%", value))")
                .foregroundColor(.white.opacity(0.8))
        }
    }

    private var panelBackground: some View {
        RoundedRectangle(cornerRadius: 18, style: .continuous)
            .fill(Color.black.opacity(0.28))
            .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(.white.opacity(0.08), lineWidth: 1))
    }
}
