//
//  SettingsSheet.swift
//  Outs
//
//  Secondary controls, kept off the main table: opponent count + range, your
//  position, and a custom pot / bet for pot-odds practice.
//

import SwiftUI

struct SettingsSheet: View {
    @ObservedObject var vm: TrainerViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Felt.background
            ScrollView {
                VStack(spacing: 16) {
                    header

                    card("Opponents") {
                        Stepper(value: Binding(get: { vm.opponents }, set: { vm.setOpponents($0) }),
                                in: 1...8) {
                            Text("\(vm.opponents) player\(vm.opponents == 1 ? "" : "s")")
                                .foregroundColor(.white)
                        }
                    }

                    card("Opponent range") {
                        Picker("Range", selection: $vm.range) {
                            ForEach(HandRange.presets) { Text($0.name).tag($0) }
                        }
                        .pickerStyle(.menu).tint(Felt.gold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text("What hands opponents are assumed to hold. Tighter ranges mean stronger opponents.")
                            .font(.caption2).foregroundColor(.white.opacity(0.55))
                    }

                    card("Your position") {
                        Picker("Position", selection: $vm.position) {
                            ForEach(TablePosition.allCases) { Text($0.rawValue).tag($0) }
                        }
                        .pickerStyle(.segmented)
                    }

                    card("Pot & bet") {
                        slider(title: "Pot size", value: $vm.potSize, range: 20...500, step: 10)
                        slider(title: vm.betToCall > 0 ? "Bet to call" : "No bet (checked)",
                               value: $vm.betToCall, range: 0...max(20, vm.potSize * 1.5), step: 5)
                        if vm.betToCall > 0 {
                            let req = vm.betToCall / (vm.potSize + vm.betToCall) * 100
                            Text(String(format: "Calling %.0f into %.0f → you need %.0f%% equity.",
                                        vm.betToCall, vm.potSize, req))
                                .font(.caption).foregroundColor(Felt.gold)
                        }
                    }

                    if vm.mode == .build {
                        card("Tip") {
                            Text("Tap an opponent's cards up top to set their exact hand — equity then uses that hand precisely.")
                                .font(.caption).foregroundColor(.white.opacity(0.7))
                        }
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

    private var header: some View {
        HStack {
            Text("Settings").font(.title2.weight(.bold)).foregroundColor(.white)
            Spacer()
            Button("Done") { dismiss() }.foregroundColor(Felt.gold).font(.headline)
        }
    }

    private func slider(title: String, value: Binding<Double>, range: ClosedRange<Double>, step: Double) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title).font(.subheadline).foregroundColor(.white.opacity(0.85))
                Spacer()
                Text("\(Int(value.wrappedValue))")
                    .font(.subheadline.weight(.semibold).monospacedDigit())
                    .foregroundColor(Felt.gold)
            }
            Slider(value: value, in: range, step: step).tint(Felt.gold)
        }
    }

    private func card<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold)).tracking(1.5)
                .foregroundColor(.white.opacity(0.5))
            content()
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color.black.opacity(0.28))
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(.white.opacity(0.08), lineWidth: 1)))
    }
}
