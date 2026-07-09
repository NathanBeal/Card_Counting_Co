//
//  PlayingCardView.swift
//  Card Counting Co.
//
//  A playing card rendered entirely from `rank` + `suit` — rank text in the
//  corners plus SF Symbol suit pips. This is what replaces the old app's 52
//  card PNGs.
//

import SwiftUI

struct PlayingCardView: View {
    let card: Card
    var width: CGFloat = 68
    var faceUp: Bool = true

    private var height: CGFloat { width * 1.4 }
    private var corner: CGFloat { width * 0.11 }

    var body: some View {
        Group {
            if faceUp { face } else { back }
        }
        .frame(width: width, height: height)
        .shadow(color: .black.opacity(0.35), radius: width * 0.06, x: 0, y: width * 0.05)
        .accessibilityElement()
        .accessibilityLabel(faceUp ? "\(card.rank.word) of \(card.suit.name)" : "Face-down card")
    }

    // MARK: Face

    private var face: some View {
        RoundedRectangle(cornerRadius: corner, style: .continuous)
            .fill(Felt.cardFace)
            .overlay(
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .stroke(Color.black.opacity(0.10), lineWidth: 0.5)
            )
            .overlay(alignment: .topLeading) { cornerIndex.padding(width * 0.08) }
            .overlay(alignment: .bottomTrailing) {
                cornerIndex.rotationEffect(.degrees(180)).padding(width * 0.08)
            }
            .overlay {
                Image(systemName: card.suit.sfSymbolName)
                    .resizable().scaledToFit()
                    .frame(width: width * 0.42)
                    .foregroundColor(card.suit.color)
                    .opacity(0.92)
            }
    }

    private var cornerIndex: some View {
        VStack(spacing: -width * 0.02) {
            Text(card.rank.label)
                .font(.system(size: width * 0.30, weight: .bold, design: .rounded))
                .fixedSize()
            Image(systemName: card.suit.sfSymbolName)
                .resizable().scaledToFit()
                .frame(width: width * 0.17)
        }
        .foregroundColor(card.suit.color)
    }

    // MARK: Back

    private var back: some View {
        RoundedRectangle(cornerRadius: corner, style: .continuous)
            .fill(
                LinearGradient(colors: [Felt.backA, Felt.backB],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .overlay(
                RoundedRectangle(cornerRadius: corner * 0.7, style: .continuous)
                    .stroke(Felt.gold.opacity(0.55), lineWidth: width * 0.03)
                    .padding(width * 0.10)
            )
            .overlay(
                Image(systemName: "suit.spade.fill")
                    .resizable().scaledToFit()
                    .frame(width: width * 0.34)
                    .foregroundColor(Felt.gold.opacity(0.75))
            )
            .overlay(
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .stroke(Color.white.opacity(0.12), lineWidth: 0.5)
            )
    }
}

/// An empty community-card slot, drawn as a dashed outline placeholder.
struct CardSlotView: View {
    var width: CGFloat = 68
    private var height: CGFloat { width * 1.4 }

    var body: some View {
        RoundedRectangle(cornerRadius: width * 0.11, style: .continuous)
            .strokeBorder(style: StrokeStyle(lineWidth: 1.5, dash: [5, 4]))
            .foregroundColor(.white.opacity(0.18))
            .frame(width: width, height: height)
    }
}

#if DEBUG
struct PlayingCardView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            PlayingCardView(card: Card(.ace, .spades))
            PlayingCardView(card: Card(.ten, .hearts))
            PlayingCardView(card: Card(.king, .diamonds), faceUp: false)
            CardSlotView()
        }
        .padding()
        .background(Felt.mid)
    }
}
#endif
