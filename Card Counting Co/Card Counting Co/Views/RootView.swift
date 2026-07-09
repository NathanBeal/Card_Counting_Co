//
//  RootView.swift
//  Outs
//
//  The trainer screen. Secondary controls (opponents, range, position, pot/bet)
//  live in a Settings sheet and reference screens live behind toolbar buttons,
//  so the table itself stays uncluttered.
//

import SwiftUI

struct RootView: View {
    @StateObject private var vm = TrainerViewModel()
    @State private var editingSlot: CardSlot?
    @State private var showSettings = false
    @State private var showRankings = false
    @State private var showStats = false

    var body: some View {
        ZStack {
            Felt.background
            ScrollView {
                VStack(spacing: 16) {
                    topBar
                    OpponentsRow(vm: vm) { editingSlot = $0 }
                    BoardRow(slots: vm.boardSlots,
                             tappable: vm.mode == .build && !vm.isHandOver,
                             onTap: { editingSlot = .board($0) })
                    heroSection
                    readout
                    actionButtons
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 16)
                .frame(maxWidth: 560)
                .frame(maxWidth: .infinity)
            }
        }
        .preferredColorScheme(.dark)
        .sheet(item: $editingSlot) { CardPickerView(vm: vm, slot: $0) }
        .sheet(isPresented: $showSettings) { SettingsSheet(vm: vm) }
        .sheet(isPresented: $showRankings) { RankingsSheet() }
        .sheet(isPresented: $showStats) { StatsSheet(vm: vm) }
    }

    // MARK: Top bar

    private var topBar: some View {
        VStack(spacing: 10) {
            HStack {
                Text("OUTS")
                    .font(.system(size: 22, weight: .black, design: .rounded))
                    .tracking(3)
                    .foregroundColor(Felt.gold)
                Spacer()
                if vm.mode == .quiz {
                    toolbarButton("chart.bar.fill") { showStats = true }
                }
                toolbarButton("info.circle") { showRankings = true }
                toolbarButton("slider.horizontal.3") { showSettings = true }
            }
            Picker("Session", selection: $vm.mode) {
                ForEach(SessionMode.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            Text("\(vm.street.name)  •  \(vm.opponents) opp  •  range \(vm.range.shortLabel)  •  \(vm.position.rawValue)")
                .font(.caption2)
                .foregroundColor(.white.opacity(0.55))
        }
    }

    private func toolbarButton(_ symbol: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white.opacity(0.85))
                .frame(width: 34, height: 34)
                .background(Circle().fill(.white.opacity(0.08)))
        }
    }

    // MARK: Hero

    private var heroSection: some View {
        VStack(spacing: 8) {
            HStack(spacing: 10) {
                ForEach(0..<2, id: \.self) { i in
                    SlotButton(card: vm.heroSlots[i], width: 80,
                               tappable: vm.mode == .build && !vm.isHandOver) {
                        editingSlot = .hero(i)
                    }
                    .overlay(heroRing)
                }
            }
            heroCaption
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: vm.heroSlots)
    }

    @ViewBuilder private var heroRing: some View {
        if vm.isHandOver, let sd = vm.showdown {
            RoundedRectangle(cornerRadius: 80 * 0.11, style: .continuous)
                .stroke(sd.heroWon ? Felt.gold : .clear, lineWidth: 3)
        }
    }

    @ViewBuilder private var heroCaption: some View {
        if vm.board.count >= 3, let made = vm.advice?.draws.made {
            Text("You have: \(made.describe)")
                .font(.subheadline.weight(.semibold)).foregroundColor(.white)
        } else {
            Text(vm.mode == .build ? "Your hand — tap to choose" : "Your hand")
                .font(.caption).foregroundColor(.white.opacity(0.6))
        }
    }

    // MARK: Readout

    @ViewBuilder private var readout: some View {
        if vm.isHandOver {
            ShowdownPanel(result: vm.showdown)
        } else if vm.mode == .quiz {
            if vm.isRevealed {
                ScorePanel(vm: vm)
                EquityPanel(equity: vm.equity, isCalculating: vm.isCalculating)
                AdvicePanel(advice: vm.advice)
            } else {
                GuessPanel(vm: vm)
            }
        } else if vm.canSimulate {
            EquityPanel(equity: vm.equity, isCalculating: vm.isCalculating)
            AdvicePanel(advice: vm.advice)
        } else if let hint = vm.manualHint {
            HintPanel(text: hint)
        }
    }

    // MARK: Buttons

    @ViewBuilder private var actionButtons: some View {
        HStack(spacing: 12) {
            if vm.isHandOver {
                newHandButton(primary: true, title: vm.mode == .build ? "Clear Table" : "New Hand")
            } else {
                switch vm.mode {
                case .build:
                    if vm.canShowdown { showdownButton }
                    newHandButton(primary: !vm.canShowdown, title: "Clear Table")
                case .play, .quiz:
                    if vm.canShowdown {
                        showdownButton
                        newHandButton(primary: false, title: "New Hand")
                    } else if vm.canAdvance {
                        advanceButton
                        newHandButton(primary: false, title: "New Hand")
                    } else {
                        newHandButton(primary: false, title: "New Hand")
                    }
                }
            }
        }
    }

    private var advanceButton: some View {
        Button(action: { Haptics.tap(); withAnimation { vm.advanceStreet() } }) {
            primaryLabel(vm.advanceTitle, enabled: true)
        }
    }

    private var showdownButton: some View {
        Button(action: { Haptics.thud(); withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) { vm.runShowdown() } }) {
            primaryLabel("Showdown", enabled: true)
        }
    }

    private func newHandButton(primary: Bool, title: String) -> some View {
        Button(action: { Haptics.tap(); withAnimation { vm.newHand() } }) {
            if primary { primaryLabel(title, enabled: true) } else { outlineLabel(title) }
        }
    }

    private func primaryLabel(_ title: String, enabled: Bool) -> some View {
        Text(title).font(.headline)
            .frame(maxWidth: .infinity).padding(.vertical, 14)
            .background(Capsule().fill(enabled ? Felt.gold : Color.gray.opacity(0.35)))
            .foregroundColor(enabled ? Felt.blackSuit : .white.opacity(0.5))
    }

    private func outlineLabel(_ title: String) -> some View {
        Text(title).font(.headline)
            .frame(maxWidth: .infinity).padding(.vertical, 14)
            .background(Capsule().stroke(.white.opacity(0.4), lineWidth: 1.5))
            .foregroundColor(.white)
    }
}

// MARK: - Reusable slot (card or tappable placeholder)

struct SlotButton: View {
    let card: Card?
    let width: CGFloat
    let tappable: Bool
    let action: () -> Void

    var body: some View {
        Group {
            if let card {
                PlayingCardView(card: card, width: width)
            } else {
                CardSlotView(width: width)
                    .overlay(
                        tappable
                        ? Image(systemName: "plus")
                            .font(.system(size: width * 0.3, weight: .bold))
                            .foregroundColor(.white.opacity(0.35))
                        : nil
                    )
            }
        }
        .contentShape(Rectangle())
        .onTapGesture { if tappable { action() } }
    }
}

// MARK: - Hint

struct HintPanel: View {
    let text: String
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "hand.tap.fill").foregroundColor(Felt.gold)
            Text(text).font(.subheadline).foregroundColor(.white.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
        .padding(16).frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 18, style: .continuous)
            .fill(Color.black.opacity(0.28))
            .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Felt.gold.opacity(0.3), lineWidth: 1)))
    }
}

// MARK: - Opponents

private struct OpponentsRow: View {
    @ObservedObject var vm: TrainerViewModel
    let onTapVillain: (CardSlot) -> Void

    private var cardW: CGFloat { vm.opponents > 5 ? 18 : 24 }

    var body: some View {
        HStack(spacing: 12) {
            ForEach(Array(0..<vm.opponents), id: \.self) { i in
                VStack(spacing: 3) {
                    HStack(spacing: 3) {
                        opponentCard(opp: i, card: 0)
                        opponentCard(opp: i, card: 1)
                    }
                    Text("P\(i + 1)")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(isWinner(i) ? Felt.gold : .white.opacity(0.5))
                }
            }
        }
        .frame(minHeight: 54)
        .animation(.easeInOut, value: vm.opponents)
        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: vm.isHandOver)
    }

    @ViewBuilder private func opponentCard(opp: Int, card: Int) -> some View {
        if vm.isHandOver, opp < vm.opponentHands.count, card < vm.opponentHands[opp].count {
            PlayingCardView(card: vm.opponentHands[opp][card], width: cardW)
                .overlay(RoundedRectangle(cornerRadius: cardW * 0.11, style: .continuous)
                    .stroke(isWinner(opp) ? Felt.gold : .clear, lineWidth: 2))
        } else if vm.mode == .build, !vm.isHandOver {
            SlotButton(card: vm.villainCards[safe: opp]?[card] ?? nil, width: cardW, tappable: true) {
                onTapVillain(.villain(opp: opp, card: card))
            }
        } else {
            PlayingCardView(card: Card(.ace, .spades), width: cardW, faceUp: false)
        }
    }

    private func isWinner(_ opp: Int) -> Bool {
        guard let sd = vm.showdown else { return false }
        return sd.players.first { $0.id == opp + 1 }?.isWinner ?? false
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

// MARK: - Board

private struct BoardRow: View {
    let slots: [Card?]
    let tappable: Bool
    let onTap: (Int) -> Void

    var body: some View {
        VStack(spacing: 6) {
            Text("BOARD")
                .font(.system(size: 10, weight: .bold)).tracking(2)
                .foregroundColor(.white.opacity(0.45))
            GeometryReader { geo in
                let w = min(62, (geo.size.width - 4 * 8) / 5)
                HStack(spacing: 8) {
                    ForEach(0..<5, id: \.self) { i in
                        SlotButton(card: slots[i], width: w, tappable: tappable) { onTap(i) }
                            .transition(.asymmetric(
                                insertion: .move(edge: .top).combined(with: .opacity),
                                removal: .opacity))
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 62 * 1.4)
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color.black.opacity(0.16))
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Felt.gold.opacity(0.18), lineWidth: 1)))
        .animation(.spring(response: 0.45, dampingFraction: 0.8), value: slots)
    }
}
