#!/usr/bin/env bash
set -euo pipefail

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m'

banner() {
  echo ""
  echo -e "${CYAN}${BOLD}━━━ $1 ━━━${NC}"
  echo ""
  sleep 1
}

# ─── Setup ───────────────────────────────────────────────────
banner "SwissArmyHammer (sah) Demo — Calcutron"

echo -e "${GREEN}This demo follows the README to build a Rust CLI calculator${NC}"
echo -e "${GREEN}from a plain-English specification using sah + Claude Code.${NC}"
sleep 2

# ─── Step 1: sah init & doctor ───────────────────────────────
banner "Step 1: Initialize sah"
echo '$ sah init'
sah init
sleep 1

banner "Step 2: Run diagnostics"
echo '$ sah doctor'
sah doctor || true
sleep 1

# ─── Step 3: Plan from specification ─────────────────────────
banner "Step 3: /plan — Create a plan from the specification"
echo "Running: claude -p '/plan ./specification/index.md'"
echo ""
claude -p '/plan ./specification/index.md' --dangerously-skip-permissions
sleep 2

# ─── Step 4: First implement loop ────────────────────────────
banner "Step 4: /implement-loop — Build it"
echo "Running: claude -p '/implement-loop'"
echo ""
claude -p '/implement-loop' --dangerously-skip-permissions
sleep 2

# ─── Step 5: Review ──────────────────────────────────────────
banner "Step 5: /review — Check the code"
echo "Running: claude -p '/review'"
echo ""
claude -p '/review' --dangerously-skip-permissions
sleep 2

# ─── Step 6: Second implement loop ───────────────────────────
banner "Step 6: /implement-loop — Address review feedback"
echo "Running: claude -p '/implement-loop'"
echo ""
claude -p '/implement-loop' --dangerously-skip-permissions
sleep 2

# ─── Step 7: Test loop ───────────────────────────────────────
banner "Step 7: /test-loop — Make sure all tests pass"
echo "Running: claude -p '/test-loop'"
echo ""
claude -p '/test-loop' --dangerously-skip-permissions
sleep 2

# ─── Done ─────────────────────────────────────────────────────
banner "Done! Let's see what we built"
echo "Files created:"
find . -name '*.rs' -o -name 'Cargo.toml' | head -20
echo ""
echo "Trying the calculator:"
echo '$ cargo run "1 + 4"'
cargo run -- '1 + 4'
sleep 2

echo ""
echo -e "${GREEN}${BOLD}You are now the proud owner of a calculator!${NC}"
echo ""
