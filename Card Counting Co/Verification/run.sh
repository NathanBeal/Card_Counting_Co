#!/bin/bash
# Runs the poker-engine correctness checks headlessly (no Xcode / simulator
# needed). Compiles the pure-Swift Engine sources together with main.swift and
# executes the assertions.
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
ENGINE="$DIR/../Card Counting Co/Engine"
OUT="$(mktemp -d)/enginecheck"

# Compile every Engine source (pure Swift, no UIKit) with the test harness.
swiftc -O -o "$OUT" "$ENGINE"/*.swift "$DIR/main.swift"

"$OUT"
