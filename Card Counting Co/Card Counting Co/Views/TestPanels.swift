//
//  TestPanels.swift
//  Card Counting Co.
//
//  Test-mode UI: estimate your win %, pick a move, reveal the truth, get scored.
//

import SwiftUI

/// Shown before the player reveals: a win-% slider, three move buttons, and the
/// Reveal button.
struct GuessPanel: View {
    @ObservedObject var vm: TrainerViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your read")
                .font(.headline).foregroundColor(.white)

            // Win-% estimate
            HStack {
                Text("Your win estimate")
                    .font(.subheadline).foregroundColor(.white.opacity(0.85))
                Spacer()
                Text("\(Int(vm.estimatedWinPercent))%")
                    .font(.title3.weight(.bold).monospacedDigit())
                    .foregroundColor(Felt.gold)
            }
            Slider(value: $vm.estimatedWinPercent, in: 0...100, step: 1)
                .tint(Felt.gold)

            // Move
            Text("Your move")
                .font(.subheadline).foregroundColor(.white.opacity(0.85))
            HStack(spacing: 8) {
                ForEach(GuessAction.allCases) { action in
                    moveButton(action)
                }
            }

            Button(action: { vm.reveal() }) {
                Text("Reveal odds")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(Capsule().fill(vm.canReveal ? Felt.gold : Color.gray.opacity(0.35)))
                    .foregroundColor(vm.canReveal ? Felt.blackSuit : .white.opacity(0.5))
            }
            .disabled(!vm.canReveal)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(panel)
    }

    private func moveButton(_ action: GuessAction) -> some View {
        let selected = vm.guessedAction == action
        return Button(action: { vm.chooseAction(action) }) {
            Text(action.rawValue)
                .font(.subheadline.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 11)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(selected ? Felt.gold.opacity(0.9) : Color.white.opacity(0.08))
                )
                .foregroundColor(selected ? Felt.blackSuit : .white.opacity(0.85))
                .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(.white.opacity(selected ? 0 : 0.15), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }

    private var panel: some View {
        RoundedRectangle(cornerRadius: 18, style: .continuous)
            .fill(Color.black.opacity(0.28))
            .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Felt.gold.opacity(0.35), lineWidth: 1.5))
    }
}

/// Shown after reveal: how the guess scored, plus the running session total.
struct ScorePanel: View {
    @ObservedObject var vm: TrainerViewModel

    var body: some View {
        if let r = vm.lastRound {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .firstTextBaseline) {
                    Text(r.accuracyLabel)
                        .font(.headline).foregroundColor(Felt.gold)
                    Spacer()
                    Text("+\(r.roundPoints)")
                        .font(.headline.weight(.heavy).monospacedDigit())
                        .foregroundColor(.white)
                    Text("/ 100")
                        .font(.caption).foregroundColor(.white.opacity(0.5))
                }

                row(icon: "target",
                    text: String(format: "Estimate: you said %d%%, actual %.0f%% (off by %.0f).",
                                 Int(r.guessedWin), r.actualWin, r.winError),
                    points: r.accuracyPoints, maxPoints: RoundResult.maxAccuracy)
                row(icon: r.actionMatched ? "checkmark.circle.fill" : "xmark.circle.fill",
                    text: r.actionMatched
                        ? "Move: \(r.guessedAction.rawValue) matches the recommended play."
                        : "Move: you chose \(r.guessedAction.rawValue); the play is \(r.coachAction.rawValue).",
                    tint: r.actionMatched ? .green : .red,
                    points: r.movePoints, maxPoints: RoundResult.maxMove)

                Divider().overlay(.white.opacity(0.15))

                Text("Session: \(vm.totalScore) pts over \(vm.guessesScored) guess\(vm.guessesScored == 1 ? "" : "es")")
                    .font(.footnote.weight(.medium))
                    .foregroundColor(.white.opacity(0.75))
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.black.opacity(0.30))
                    .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(Felt.gold.opacity(0.30), lineWidth: 1))
            )
        }
    }

    private func row(icon: String, text: String, tint: Color = Felt.gold,
                     points: Int, maxPoints: Int) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: icon).foregroundColor(tint).font(.footnote).padding(.top, 1)
            Text(text)
                .font(.footnote).foregroundColor(.white.opacity(0.88))
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 6)
            Text("+\(points)")
                .font(.footnote.weight(.semibold).monospacedDigit())
                .foregroundColor(.white.opacity(0.9))
            + Text("/\(maxPoints)")
                .font(.caption2.monospacedDigit())
                .foregroundColor(.white.opacity(0.45))
        }
    }
}
