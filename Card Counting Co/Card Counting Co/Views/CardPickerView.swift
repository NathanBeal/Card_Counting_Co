//
//  CardPickerView.swift
//  Card Counting Co.
//
//  Manual-mode card chooser: a 4×13 grid of the whole deck. Cards already in
//  play are dimmed and unselectable so you can't pick a duplicate.
//

import SwiftUI

struct CardPickerView: View {
    @ObservedObject var vm: TrainerViewModel
    let slot: CardSlot
    @Environment(\.dismiss) private var dismiss

    private let suitsOrder: [Suit] = [.spades, .hearts, .diamonds, .clubs]
    private var ranksOrder: [Rank] { Rank.allCases.reversed() }   // Ace → Two

    var body: some View {
        ZStack {
            Felt.background
            VStack(spacing: 16) {
                header
                GeometryReader { geo in
                    let spacing: CGFloat = 4
                    let w = (geo.size.width - spacing * 12) / 13
                    VStack(spacing: spacing) {
                        ForEach(suitsOrder, id: \.self) { suit in
                            HStack(spacing: spacing) {
                                ForEach(ranksOrder, id: \.self) { rank in
                                    cardButton(Card(rank, suit), width: w)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
            .padding(18)
        }
        .preferredColorScheme(.dark)
        .presentationDetents([.medium, .large])
    }

    private var header: some View {
        HStack {
            Button("Cancel") { dismiss() }
                .foregroundColor(.white.opacity(0.8))
            Spacer()
            VStack(spacing: 2) {
                Text("Choose \(slot.label)")
                    .font(.headline).foregroundColor(.white)
                Text("Tap a card")
                    .font(.caption2).foregroundColor(.white.opacity(0.55))
            }
            Spacer()
            if vm.card(at: slot) != nil {
                Button("Clear") { vm.clear(slot); dismiss() }
                    .foregroundColor(Felt.gold)
            } else {
                Text("Cancel").opacity(0)   // balances the header spacing
            }
        }
    }

    private func cardButton(_ card: Card, width: CGFloat) -> some View {
        let current = vm.card(at: slot)
        let isCurrent = card == current
        let usedElsewhere = vm.usedCards.contains(card) && !isCurrent

        return Button {
            vm.setCard(card, at: slot)
            dismiss()
        } label: {
            PlayingCardView(card: card, width: width)
                .overlay(
                    RoundedRectangle(cornerRadius: width * 0.11, style: .continuous)
                        .stroke(Felt.gold, lineWidth: isCurrent ? 2.5 : 0)
                )
                .opacity(usedElsewhere ? 0.22 : 1)
        }
        .buttonStyle(.plain)
        .disabled(usedElsewhere)
    }
}
