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

# ─── Token benchmark setup ───────────────────────────────────
# Each AI step is run with --output-format json so we can total
# the tokens consumed and use this demo as an eval benchmark.
RESULTS_DIR="${RESULTS_DIR:-./benchmark-results}"
mkdir -p "$RESULTS_DIR"
command -v jq >/dev/null 2>&1 || { echo "error: jq is required (brew install jq)"; exit 1; }

# run_ai_step <name> <claude-prompt>
# Runs claude in print/JSON mode, shows its final result text, and
# prints that step's token usage (saved to $RESULTS_DIR/<name>.json).
run_ai_step() {
  local name="$1" prompt="$2"
  local out="$RESULTS_DIR/${name}.json"

  echo "Running: claude -p '$prompt'"
  echo ""
  claude -p "$prompt" --output-format json --dangerously-skip-permissions >"$out"

  # Claude's final message, so the demo still shows the outcome.
  jq -r '.result // ""' "$out"

  if [ "$(jq -r '.is_error' "$out")" = "true" ]; then
    echo -e "${GREEN}warning: '$name' reported an error (api_error_status: $(jq -r '.api_error_status' "$out"))${NC}" >&2
  fi

  # modelUsage = cumulative per-model token counts for the whole run.
  echo ""
  echo -ne "${GREEN}${BOLD}"
  jq -r '
    [.modelUsage[]] as $m
    | { input:([$m[].inputTokens]|add//0), output:([$m[].outputTokens]|add//0),
        cc:([$m[].cacheCreationInputTokens]|add//0), cr:([$m[].cacheReadInputTokens]|add//0),
        cost:(.total_cost_usd//0) }
    | .total=(.input+.output+.cc+.cr)
    | "  ↳ '"$name"' tokens: input=\(.input) output=\(.output) cache_create=\(.cc) cache_read=\(.cr) total=\(.total)  cost=$\(.cost)"
  ' "$out"
  echo -ne "${NC}"
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
run_ai_step "plan" "/plan ./specification/index.md"
sleep 2

# ─── Step 4: Finish the plan ────────────────────────────
banner "Step 4: /implement-loop — Build it"
run_ai_step "finish" "/finish"
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

# ─── Benchmark total ─────────────────────────────────────────
banner "Benchmark: total tokens for this run"

jq -s '
  { input:        ([ .[] | .modelUsage[].inputTokens ]              | add // 0),
    output:       ([ .[] | .modelUsage[].outputTokens ]             | add // 0),
    cache_create: ([ .[] | .modelUsage[].cacheCreationInputTokens ] | add // 0),
    cache_read:   ([ .[] | .modelUsage[].cacheReadInputTokens ]     | add // 0),
    cost_usd:     ([ .[] | .total_cost_usd ]                        | add // 0) }
  | .total_tokens = (.input + .output + .cache_create + .cache_read)
' "$RESULTS_DIR"/plan.json "$RESULTS_DIR"/finish.json | tee "$RESULTS_DIR/summary.json"

echo ""
echo -e "${GREEN}${BOLD}Total tokens: $(jq -r '.total_tokens' "$RESULTS_DIR/summary.json")  (\$$(jq -r '.cost_usd' "$RESULTS_DIR/summary.json"))${NC}"
echo "Raw per-step JSON + summary.json in: $RESULTS_DIR"
echo ""
