// Headless correctness harness for the poker engine.
// Compiled with the engine sources via swiftc for macOS.

import Foundation

var failures = 0
var checks = 0

func check(_ cond: Bool, _ msg: String) {
    checks += 1
    if !cond { failures += 1; print("  ✗ FAIL: \(msg)") }
}

func approx(_ a: Double, _ b: Double, tol: Double, _ msg: String) {
    checks += 1
    if abs(a - b) > tol { failures += 1; print("  ✗ FAIL: \(msg) — got \(String(format: "%.2f", a)), expected ~\(b) (±\(tol))") }
    else { print("  ✓ \(msg): \(String(format: "%.2f", a))% (expected ~\(b)%)") }
}

func c(_ r: Rank, _ s: Suit) -> Card { Card(r, s) }

// ------------------------------------------------------------------
print("== Hand evaluator: category detection ==")

// Royal flush
check(HandEvaluator.evaluate([c(.ten,.hearts),c(.jack,.hearts),c(.queen,.hearts),c(.king,.hearts),c(.ace,.hearts)]).category == .straightFlush, "royal flush is a straight flush")
check(HandEvaluator.evaluate([c(.ten,.hearts),c(.jack,.hearts),c(.queen,.hearts),c(.king,.hearts),c(.ace,.hearts)]).describe == "Royal Flush", "royal flush describes correctly")

// Wheel straight flush (A-2-3-4-5)
let wheelSF = HandEvaluator.evaluate([c(.ace,.spades),c(.two,.spades),c(.three,.spades),c(.four,.spades),c(.five,.spades)])
check(wheelSF.category == .straightFlush && wheelSF.kickers[0] == 5, "wheel straight flush, five high")

// Four of a kind
check(HandEvaluator.evaluate([c(.nine,.hearts),c(.nine,.clubs),c(.nine,.spades),c(.nine,.diamonds),c(.king,.hearts)]).category == .fourOfAKind, "quads")

// Full house (with 7 cards, trip + two pairs picks best pair)
let fh = HandEvaluator.evaluate([c(.king,.hearts),c(.king,.clubs),c(.king,.spades),c(.three,.diamonds),c(.three,.hearts),c(.two,.clubs),c(.two,.spades)])
check(fh.category == .fullHouse && fh.kickers == [13,3], "full house Kings over Threes (best pair chosen)")

// Two trips → full house (higher trip full of lower)
let twoTrips = HandEvaluator.evaluate([c(.eight,.hearts),c(.eight,.clubs),c(.eight,.spades),c(.five,.diamonds),c(.five,.hearts),c(.five,.clubs),c(.two,.spades)])
check(twoTrips.category == .fullHouse && twoTrips.kickers == [8,5], "two trips make Eights full of Fives")

// Flush over straight
check(HandEvaluator.evaluate([c(.two,.hearts),c(.five,.hearts),c(.seven,.hearts),c(.nine,.hearts),c(.jack,.hearts)]).category == .flush, "flush")

// Straight using the wheel
let wheel = HandEvaluator.evaluate([c(.ace,.spades),c(.two,.hearts),c(.three,.clubs),c(.four,.diamonds),c(.five,.spades)])
check(wheel.category == .straight && wheel.kickers[0] == 5, "wheel straight is five-high")

// Ace-high straight (Broadway)
check(HandEvaluator.evaluate([c(.ten,.spades),c(.jack,.hearts),c(.queen,.clubs),c(.king,.diamonds),c(.ace,.spades)]).kickers[0] == 14, "broadway straight is ace-high")

// Best 5 of 7: two pair
let tp = HandEvaluator.evaluate([c(.ace,.hearts),c(.ace,.clubs),c(.king,.spades),c(.king,.diamonds),c(.five,.hearts),c(.three,.clubs),c(.two,.spades)])
check(tp.category == .twoPair && tp.kickers == [14,13,5], "two pair Aces & Kings, Five kicker")

// Three pair (7 cards) → two pair, kicker is the third pair's rank
let threePair = HandEvaluator.evaluate([c(.ace,.hearts),c(.ace,.clubs),c(.king,.spades),c(.king,.diamonds),c(.queen,.hearts),c(.queen,.clubs),c(.two,.spades)])
check(threePair.category == .twoPair && threePair.kickers == [14,13,12], "three pair collapses to top two pair + Q kicker")

print("== Hand comparisons ==")
let aces = HandEvaluator.evaluate([c(.ace,.hearts),c(.ace,.clubs),c(.king,.spades),c(.seven,.diamonds),c(.two,.hearts)])
let kings = HandEvaluator.evaluate([c(.king,.hearts),c(.king,.clubs),c(.ace,.spades),c(.seven,.diamonds),c(.two,.hearts)])
check(aces > kings, "pair of aces beats pair of kings")
let aKk = HandEvaluator.evaluate([c(.ace,.hearts),c(.ace,.clubs),c(.king,.spades),c(.queen,.diamonds),c(.two,.hearts)])
let aKj = HandEvaluator.evaluate([c(.ace,.diamonds),c(.ace,.spades),c(.king,.hearts),c(.jack,.diamonds),c(.two,.clubs)])
check(aKk > aKj, "kicker breaks tie (Q kicker beats J)")

// ------------------------------------------------------------------
print("== Monte-Carlo equity (seeded, 60k iters) ==")
let iters = 60_000

// AA vs 1 random ≈ 85%
var g1 = SeededGenerator(seed: 12345)
let aaVs1 = EquityCalculator.simulate(hero: [c(.ace,.spades),c(.ace,.hearts)], board: [], opponents: 1, iterations: iters, using: &g1)
approx(aaVs1.equityPercent, 85.2, tol: 1.5, "AA vs 1 opponent preflop")

// 72o vs 1 random ≈ 35%
var g2 = SeededGenerator(seed: 999)
let seven2 = EquityCalculator.simulate(hero: [c(.seven,.spades),c(.two,.hearts)], board: [], opponents: 1, iterations: iters, using: &g2)
approx(seven2.equityPercent, 34.6, tol: 2.0, "72o vs 1 opponent preflop")

// AKs vs 1 random ≈ 67%
var g3 = SeededGenerator(seed: 42)
let aks = EquityCalculator.simulate(hero: [c(.ace,.spades),c(.king,.spades)], board: [], opponents: 1, iterations: iters, using: &g3)
approx(aks.equityPercent, 67.0, tol: 2.0, "AKs vs 1 opponent preflop")

// AA vs 5 random ≈ 49%
var g4 = SeededGenerator(seed: 7)
let aaVs5 = EquityCalculator.simulate(hero: [c(.ace,.spades),c(.ace,.hearts)], board: [], opponents: 5, iterations: iters, using: &g4)
approx(aaVs5.equityPercent, 49.0, tol: 2.5, "AA vs 5 opponents preflop")

// Made nut flush on the board — should be ~100% vs 1
var g5 = SeededGenerator(seed: 3)
let nutFlush = EquityCalculator.simulate(hero: [c(.ace,.hearts),c(.king,.hearts)],
    board: [c(.two,.hearts),c(.seven,.hearts),c(.nine,.hearts),c(.three,.clubs)], opponents: 1, iterations: iters, using: &g5)
check(nutFlush.equityPercent > 92, "made ace-high flush is a heavy favorite (got \(String(format: "%.1f", nutFlush.equityPercent))%)")

// ------------------------------------------------------------------
print("== Draw detection ==")
// Flush draw on the flop: 4 hearts → 9 outs
let fd = DrawDetector.analyze(hero: [c(.ace,.hearts),c(.king,.hearts)], board: [c(.two,.hearts),c(.seven,.hearts),c(.nine,.clubs)])
check(fd.labels.contains("Flush draw"), "flush draw detected")
check(fd.outs == 9, "flush draw has 9 outs (got \(fd.outs))")

// Open-ended straight draw: 6-7 on 8-9-2 → outs include 5s and Ts
let oesd = DrawDetector.analyze(hero: [c(.six,.spades),c(.seven,.hearts)], board: [c(.eight,.clubs),c(.nine,.diamonds),c(.two,.spades)])
check(oesd.labels.contains("Open-ended straight draw"), "OESD detected")
check(oesd.outs == 8, "OESD has 8 outs (got \(oesd.outs))")

// Gutshot: 6-7 on 9-10-2 needs an 8 only → 4 outs
let gut = DrawDetector.analyze(hero: [c(.six,.spades),c(.seven,.hearts)], board: [c(.nine,.clubs),c(.ten,.diamonds),c(.two,.spades)])
check(gut.labels.contains("Gutshot straight draw"), "gutshot detected")
check(gut.outs == 4, "gutshot has 4 outs (got \(gut.outs))")

// ------------------------------------------------------------------
print("== Coach decisions ==")
// Facing a bet with terrible equity → fold
var gc1 = SeededGenerator(seed: 1)
let weakEq = EquityCalculator.simulate(hero: [c(.seven,.spades),c(.two,.diamonds)], board: [c(.ace,.hearts),c(.king,.clubs),c(.queen,.spades)], opponents: 1, iterations: 20000, using: &gc1)
let weakDraw = DrawDetector.analyze(hero: [c(.seven,.spades),c(.two,.diamonds)], board: [c(.ace,.hearts),c(.king,.clubs),c(.queen,.spades)])
let foldAdvice = Coach.advise(hero: [c(.seven,.spades),c(.two,.diamonds)], board: [c(.ace,.hearts),c(.king,.clubs),c(.queen,.spades)], opponents: 1, pot: 100, toCall: 75, equity: weakEq, draws: weakDraw)
check(foldAdvice.action == .fold, "coach folds 72o vs big bet on AKQ (got \(foldAdvice.action.rawValue))")

// Strong made hand checked to hero → bet for value
var gc2 = SeededGenerator(seed: 2)
let setEq = EquityCalculator.simulate(hero: [c(.nine,.spades),c(.nine,.diamonds)], board: [c(.nine,.hearts),c(.king,.clubs),c(.two,.spades)], opponents: 1, iterations: 20000, using: &gc2)
let setDraw = DrawDetector.analyze(hero: [c(.nine,.spades),c(.nine,.diamonds)], board: [c(.nine,.hearts),c(.king,.clubs),c(.two,.spades)])
let betAdvice = Coach.advise(hero: [c(.nine,.spades),c(.nine,.diamonds)], board: [c(.nine,.hearts),c(.king,.clubs),c(.two,.spades)], opponents: 1, pot: 100, toCall: 0, equity: setEq, draws: setDraw)
check(betAdvice.action == .bet || betAdvice.action == .raise, "coach bets a set when checked to (got \(betAdvice.action.rawValue))")

// ------------------------------------------------------------------
print("== Hand ranges (Chen) ==")
check(HandRange.premium.contains(c(.ace,.spades), c(.ace,.hearts)), "premium range includes AA")
check(!HandRange.premium.contains(c(.seven,.clubs), c(.two,.diamonds)), "premium range excludes 72o")
check(HandRange.tight.contains(c(.ace,.spades), c(.king,.spades)), "tight range includes AKs")
check(HandRange.anyTwo.contains(c(.seven,.clubs), c(.two,.diamonds)), "any-two includes everything")

var gr1 = SeededGenerator(seed: 11)
let aaAny = EquityCalculator.simulate(hero: [c(.ace,.spades),c(.ace,.hearts)], board: [], opponents: 1, range: .anyTwo, iterations: 50000, using: &gr1)
var gr2 = SeededGenerator(seed: 12)
let aaPrem = EquityCalculator.simulate(hero: [c(.ace,.spades),c(.ace,.hearts)], board: [], opponents: 1, range: .premium, iterations: 50000, using: &gr2)
check(aaPrem.equityPercent < aaAny.equityPercent,
      "AA equity drops vs a premium range (\(String(format: "%.1f", aaPrem.equityPercent))% < \(String(format: "%.1f", aaAny.equityPercent))%)")

print("== Exact enumeration ==")
let hM = [c(.ace,.hearts),c(.king,.hearts)]
let vM = [c(.two,.clubs),c(.two,.diamonds)]
let bM = [c(.queen,.hearts),c(.seven,.hearts),c(.five,.spades)]
let ex = EquityCalculator.exact(hero: hM, board: bM, villains: [vM])
check(ex.exact, "exact result is flagged exact")
var gmc = SeededGenerator(seed: 55)
let mc = EquityCalculator.simulate(hero: hM, board: bM, opponents: [.fixed(vM)], iterations: 40000, using: &gmc)
approx(mc.equityPercent, ex.equityPercent, tol: 1.5, "Monte-Carlo matches exact for a fixed matchup (exact \(String(format: "%.1f", ex.equityPercent))%)")

print("== Position-aware coach ==")
let eq60 = EquityResult(win: 0.60, tie: 0, lose: 0.40, equity: 0.60, iterations: 1)
let noDraw = DrawAnalysis(made: HandValue(category: .pair, kickers: [10,9,8,7]), outs: 0, outCards: [], labels: [])
let flopBoard = [c(.two,.hearts),c(.seven,.diamonds),c(.nine,.clubs)]
let midAdv = Coach.advise(hero: [c(.ace,.spades),c(.king,.spades)], board: flopBoard, opponents: 1, pot: 100, toCall: 0, equity: eq60, draws: noDraw, position: .middle)
let lateAdv = Coach.advise(hero: [c(.ace,.spades),c(.king,.spades)], board: flopBoard, opponents: 1, pot: 100, toCall: 0, equity: eq60, draws: noDraw, position: .late)
check(midAdv.action == .check, "middle position checks a 60% spot (got \(midAdv.action.rawValue))")
check(lateAdv.action == .bet, "late position bets the same 60% spot (got \(lateAdv.action.rawValue))")

print("== Showdown ==")
let sdBoard = [c(.two,.hearts),c(.seven,.hearts),c(.nine,.hearts),c(.ten,.spades),c(.jack,.clubs)]
let sd = Showdown.evaluate(hero: [c(.ace,.hearts),c(.king,.hearts)], board: sdBoard,
                           opponentHands: [[c(.eight,.diamonds),c(.queen,.clubs)]])
check(sd.heroWon && !sd.isChop, "hero's flush beats a straight at showdown")
check(sd.players[0].value.category == .flush, "hero shows a flush")
let chopBoard = [c(.ten,.spades),c(.jack,.spades),c(.queen,.hearts),c(.king,.diamonds),c(.ace,.clubs)]
let chop = Showdown.evaluate(hero: [c(.two,.hearts),c(.three,.diamonds)], board: chopBoard,
                             opponentHands: [[c(.four,.clubs),c(.five,.spades)]])
check(chop.isChop && chop.heroWon, "both play the board = chop")

// ------------------------------------------------------------------
print("\n\(checks - failures)/\(checks) checks passed.")
if failures > 0 { print("❌ \(failures) FAILURES"); exit(1) }
print("✅ ALL ENGINE CHECKS PASSED")
