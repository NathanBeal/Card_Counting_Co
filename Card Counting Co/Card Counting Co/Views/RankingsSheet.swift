//
//  RankingsSheet.swift
//  Outs
//
//  A quick reference of poker hands, best to worst, with example cards drawn in
//  code (the same programmatic cards used everywhere else).
//

import SwiftUI

struct RankingsSheet: View {
    @Environment(\.dismiss) private var dismiss

    private struct Ranking: Identifiable {
        let id = UUID()
        let name: String
        let cards: [Card]
        let note: String
    }

    private let rankings: [Ranking] = [
        Ranking(name: "Royal Flush",
                cards: [Card(.ace, .hearts), Card(.king, .hearts), Card(.queen, .hearts), Card(.jack, .hearts), Card(.ten, .hearts)],
                note: "A-K-Q-J-10, all one suit."),
        Ranking(name: "Straight Flush",
                cards: [Card(.nine, .spades), Card(.eight, .spades), Card(.seven, .spades), Card(.six, .spades), Card(.five, .spades)],
                note: "Five in a row, all one suit."),
        Ranking(name: "Four of a Kind",
                cards: [Card(.queen, .hearts), Card(.queen, .spades), Card(.queen, .diamonds), Card(.queen, .clubs), Card(.king, .hearts)],
                note: "All four of one rank."),
        Ranking(name: "Full House",
                cards: [Card(.king, .hearts), Card(.king, .spades), Card(.king, .clubs), Card(.four, .diamonds), Card(.four, .hearts)],
                note: "Three of a kind plus a pair."),
        Ranking(name: "Flush",
                cards: [Card(.ace, .clubs), Card(.jack, .clubs), Card(.eight, .clubs), Card(.five, .clubs), Card(.two, .clubs)],
                note: "Five of one suit, any order."),
        Ranking(name: "Straight",
                cards: [Card(.eight, .hearts), Card(.seven, .spades), Card(.six, .diamonds), Card(.five, .clubs), Card(.four, .hearts)],
                note: "Five in a row, mixed suits."),
        Ranking(name: "Three of a Kind",
                cards: [Card(.seven, .hearts), Card(.seven, .spades), Card(.seven, .diamonds), Card(.king, .clubs), Card(.two, .hearts)],
                note: "Three of one rank."),
        Ranking(name: "Two Pair",
                cards: [Card(.ace, .hearts), Card(.ace, .spades), Card(.king, .diamonds), Card(.king, .clubs), Card(.three, .hearts)],
                note: "Two different pairs."),
        Ranking(name: "One Pair",
                cards: [Card(.ten, .hearts), Card(.ten, .spades), Card(.ace, .diamonds), Card(.seven, .clubs), Card(.four, .hearts)],
                note: "Two cards of one rank."),
        Ranking(name: "High Card",
                cards: [Card(.ace, .hearts), Card(.king, .spades), Card(.nine, .diamonds), Card(.six, .clubs), Card(.three, .hearts)],
                note: "Nothing else — highest card plays."),
    ]

    var body: some View {
        ZStack {
            Felt.background
            ScrollView {
                VStack(spacing: 12) {
                    HStack {
                        Text("Hand Rankings").font(.title2.weight(.bold)).foregroundColor(.white)
                        Spacer()
                        Button("Done") { dismiss() }.foregroundColor(Felt.gold).font(.headline)
                    }
                    .padding(.bottom, 4)

                    ForEach(Array(rankings.enumerated()), id: \.element.id) { index, r in
                        row(index: index, r: r)
                    }
                }
                .padding(18)
                .frame(maxWidth: 520)
                .frame(maxWidth: .infinity)
            }
        }
        .preferredColorScheme(.dark)
        .presentationDetents([.large])
    }

    private func row(index: Int, r: Ranking) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("\(index + 1). \(r.name)")
                    .font(.subheadline.weight(.bold)).foregroundColor(Felt.gold)
                Spacer()
            }
            HStack(spacing: 4) {
                ForEach(r.cards) { PlayingCardView(card: $0, width: 30) }
            }
            Text(r.note).font(.caption2).foregroundColor(.white.opacity(0.6))
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color.black.opacity(0.26))
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(.white.opacity(0.07), lineWidth: 1)))
    }
}
