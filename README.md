# Outs — a Texas Hold'em odds trainer

Deal or build a hand, reveal the flop / turn / river, and at every street see
your **real win probability** and a coached **fold / check / call / raise**
recommendation — with the reasoning behind it. At the end of a hand, run a
**showdown**: opponents' cards flip up and the winner is decided.

Originally "Card Counting Co." — a 2019 SpriteKit app that drove everything
through hard-coded pixel coordinates + `UserDefaults` globals, shipped 52 card
PNGs, and looked its odds up from static tables. This is a ground-up SwiftUI
rewrite that draws every card in code and computes odds live. (It was renamed
because "card counting" is a *blackjack* term; this is a poker tool.)

---

## Three session modes

Chosen from the segmented control at the top:

- **Play** — a simulated hand. Opponents hold hidden cards drawn from the
  selected range. **Deal Flop/Turn/River** runs the board; at the river,
  **Showdown** flips everyone's cards and names the winner.
- **Build** — you construct the spot. Tap any slot — your two cards, the board,
  **or an opponent's cards** — to pick exact cards (duplicates are greyed out).
  With a full board, **Showdown** resolves it; unset opponents are dealt from the
  range.
- **Quiz** — a random spot with odds hidden. Estimate your win % on the slider,
  pick **Fold / Check-Call / Bet-Raise**, then **Reveal**. You're scored out of
  100 (up to 60 for the estimate, 40 for matching the coach) with a **persistent
  all-time record** and streaks (tap the chart icon).

## Features

- **Live equity** vs. 1–8 opponents (Monte-Carlo), or **exact enumeration**
  when opponents are known hands and ≤ 2 board cards remain.
- **Opponent ranges** (Any two → Premium top 6%) via the Chen formula, so equity
  reflects that real players fold trash — not just random cards.
- **Position-aware coaching** (early / middle / late / blinds nudges the play).
- **Outs shown as real cards** under the advice, not just a number.
- **Custom pot & bet** sliders for genuine pot-odds practice.
- **Hand-rankings reference** (info icon) and **quiz stats** (chart icon) in
  sheets, so the table itself stays uncluttered.
- Programmatic cards (no PNGs), VoiceOver labels, and haptics.

Secondary controls (opponents, range, position, pot, bet) live behind the
**sliders** toolbar icon.

---

## Project layout

```
Card Counting Co/
├─ Card Counting Co..xcodeproj      ← open this in Xcode (app is titled "Outs")
├─ Card Counting Co/
│  ├─ App/         CardCountingApp · TrainerViewModel · Theme (+ haptics)
│  ├─ Engine/      pure Swift, no UIKit — fully unit-tested
│  │              Card · Deck · HandEvaluator · Equity · Draws · Coach ·
│  │              Range (Chen + ranges) · Showdown
│  ├─ Views/       PlayingCardView · EquityPanel · AdvicePanel (+ outs) ·
│  │              CardPickerView · TestPanels (quiz) · ShowdownPanel ·
│  │              SettingsSheet · RankingsSheet · StatsSheet · RootView
│  └─ Assets.xcassets   app icon + accent color (no card images)
└─ Verification/   headless engine checks (see below)
```

## Requirements & running

- Xcode 15+ (objectVersion 56, iOS deployment target **16.0**), iOS 16+ device/sim.
- Open `Card Counting Co/Card Counting Co..xcodeproj`, press **Run** (⌘R).
- Signing is pre-set (`7UJ2JMZ83G`, bundle id `com.NathanBealStudios.CCC`);
  change the Team under *Signing & Capabilities* to run on your own device.

## How the coaching works

1. **Equity** — `EquityCalculator` samples thousands of runouts (or enumerates
   exactly) with opponents drawn from their range → your true win/tie/lose share.
2. **Outs & draws** — `DrawDetector` names your draws and lists the cards that
   improve you.
3. **Pot odds** — the bet you face sets the price: calling X into pot P needs a
   win rate of X / (P + X).
4. **Decision** — `Coach` weighs equity against that price, value thresholds, and
   your position, then recommends a move and explains why.

## Verifying the engine (no Xcode needed)

```bash
cd "Card Counting Co/Verification"
./run.sh
```

Checks the evaluator against known hands, Monte-Carlo equity against published
odds (AA vs 1 ≈ 85%, AKs ≈ 67%), outs counting (flush = 9, OESD = 8, gutshot =
4), ranges (AA equity drops vs a premium range), exact-vs-sampled agreement,
position logic, and showdown outcomes. Current status: **38/38 checks pass.**

---

## Archive

Old / duplicate material lives in `_ARCHIVE/` (nothing deleted; the original
SpriteKit code is also in git history at `bcd91d0 First Push`). Safe to delete
once you're happy with the rewrite.

## Possible next steps

- Weight opponents by a real 169-hand equity ranking rather than the Chen
  approximation.
- Save/replay interesting hands; share a spot.
