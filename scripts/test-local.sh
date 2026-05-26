#!/usr/bin/env bash
# scripts/test-local.sh — Run the same checks that CI runs, locally.
# Usage: ./scripts/test-local.sh [--quick]
#   --quick  Skip lint and validate_config; run specs only.
set -euo pipefail

cd "$(dirname "$0")/.."

RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
RESET='\033[0m'

step() { printf "\n${BOLD}==> %s${RESET}\n" "$1"; }
pass() { printf "${GREEN}✓ %s${RESET}\n" "$1"; }
fail() { printf "${RED}✗ %s${RESET}\n" "$1"; exit 1; }

# --- Dependency check ---
step "Checking dependencies"
command -v bundle >/dev/null 2>&1 || { fail "bundler not found — gem install bundler"; }
bundle check --dry-run >/dev/null 2>&1 || { step "Installing gems"; bundle install; }
pass "Dependencies OK"

QUICK=false
[[ "${1:-}" == "--quick" ]] && QUICK=true

# --- Lint (matches CI lint.yml) ---
if [[ "$QUICK" == false ]]; then
  step "Lint (cookstyle on itself)"
  bundle exec cookstyle && pass "Lint clean" || fail "Lint failed"

  step "Validate cop config"
  bundle exec rake validate_config && pass "Config valid" || fail "validate_config failed"
fi

# --- Specs (matches CI unit.yml) ---
step "Running specs (rake spec)"
bundle exec rake spec && pass "All specs passed" || fail "Specs failed"

# --- Summary ---
printf "\n${GREEN}${BOLD}All checks passed.${RESET}\n"
