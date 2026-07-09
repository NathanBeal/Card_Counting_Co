//
//  ShowdownPanel.swift
//  Outs
//
//  End-of-hand result: everyone's hand revealed and the winner called out.
//

import SwiftUI

struct ShowdownPanel: View {
    let result: ShowdownResult?

    var body: some View {
        if let r = result {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 10) {
                    Image(systemName: icon(r)).foregroundColor(tint(r))
                    Text(r.headline)
                        .font(.headline).foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                }

                VStack(spacing: 8) {
                    ForEach(r.players) { player in
                        row(player)
                    }
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.black.opacity(0.32))
                    .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(tint(r).opacity(0.5), lineWidth: 1.5))
            )
        }
    }

    private func row(_ p: PlayerShowdown) -> some View {
        HStack(spacing: 8) {
            Text(p.label)
                .font(.subheadline.weight(.bold))
                .foregroundColor(p.isWinner ? Felt.gold : .white.opacity(0.7))
                .frame(width: 34, alignment: .leading)
            HStack(spacing: 3) {
                ForEach(p.cards) { PlayingCardView(card: $0, width: 22) }
            }
            Text(p.value.describe)
                .font(.caption)
                .foregroundColor(p.isWinner ? .white : .white.opacity(0.6))
                .lineLimit(1).minimumScaleFactor(0.7)
            Spacer(minLength: 4)
            if p.isWinner {
                Image(systemName: "crown.fill").font(.caption).foregroundColor(Felt.gold)
            }
        }
    }

    private func icon(_ r: ShowdownResult) -> String {
        if r.isChop { return "equal.circle.fill" }
        return r.heroWon ? "trophy.fill" : "xmark.circle.fill"
    }

    private func tint(_ r: ShowdownResult) -> Color {
        if r.isChop { return Felt.gold }
        return r.heroWon ? Color(red: 0.25, green: 0.7, blue: 0.4) : Color(red: 0.8, green: 0.3, blue: 0.3)
    }
}
