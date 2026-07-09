//
//  StatsSheet.swift
//  Outs
//
//  Your Quiz record: this session plus an all-time tally that persists between
//  launches.
//

import SwiftUI

struct StatsSheet: View {
    @ObservedObject var vm: TrainerViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Felt.background
            ScrollView {
                VStack(spacing: 18) {
                    HStack {
                        Text("Quiz Record").font(.title2.weight(.bold)).foregroundColor(.white)
                        Spacer()
                        Button("Done") { dismiss() }.foregroundColor(Felt.gold).font(.headline)
                    }

                    section("This session") {
                        tile("Score", "\(vm.totalScore)")
                        tile("Guesses", "\(vm.guessesScored)")
                        tile("Streak", "\(vm.currentStreak)")
                    }

                    section("All time") {
                        tile("Guesses", "\(vm.lifetimeGuesses)")
                        tile("Avg / 100", String(format: "%.0f", vm.lifetimeAverage))
                        tile("Best streak", "\(vm.bestStreak)")
                    }

                    Text("A round is worth 100: up to 60 for your win-% estimate and 40 for matching the recommended move. Streak counts consecutive rounds with the right move and a close read.")
                        .font(.caption2).foregroundColor(.white.opacity(0.55))
                        .fixedSize(horizontal: false, vertical: true)

                    Button(role: .destructive) { vm.resetStats() } label: {
                        Text("Reset all-time record")
                            .font(.subheadline.weight(.semibold))
                            .frame(maxWidth: .infinity).padding(.vertical, 12)
                            .background(Capsule().stroke(.red.opacity(0.6), lineWidth: 1.5))
                            .foregroundColor(.red)
                    }
                }
                .padding(18)
                .frame(maxWidth: 520)
                .frame(maxWidth: .infinity)
            }
        }
        .preferredColorScheme(.dark)
        .presentationDetents([.medium, .large])
    }

    private func section<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold)).tracking(1.5)
                .foregroundColor(.white.opacity(0.5))
            HStack(spacing: 10) { content() }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func tile(_ label: String, _ value: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 26, weight: .heavy, design: .rounded).monospacedDigit())
                .foregroundColor(Felt.gold)
            Text(label).font(.caption2).foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color.black.opacity(0.28))
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(.white.opacity(0.08), lineWidth: 1)))
    }
}
