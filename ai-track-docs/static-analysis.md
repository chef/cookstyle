# Static Analysis — Cookstyle

Recorded: 2026-05-26

---

## Overview

Cookstyle is self-hosted — the repo's own cops lint its own code.
The active rule set is `config/chefstyle.yml` (internal Chef style).
CI enforces lint via the `lint.yml` workflow on every push and PR.

---

## How to Run Locally

```bash
# Lint all files
bundle exec cookstyle

# — or via Rake —
bundle exec rake style

# Lint specific files
bundle exec cookstyle lib/cookstyle.rb spec/cookstyle_spec.rb

# Auto-fix all correctable offenses
bundle exec cookstyle -a

# Auto-fix with unsafe corrections included
bundle exec cookstyle -A
```

---

## Lint Checks Enforced

| Cop | Category | What it catches |
|-----|----------|-----------------|
| `Style/ReturnNil` | Convention | `return nil` → prefer bare `return` |
| `Style/StderrPuts` | Convention | `$stderr.puts` → prefer `warn` |
| `Style/RegexpLiteral` | Convention | Regexps with slashes → use `%r{}` |
| `Chef/Style/CommentFormat` | Refactor | Non-standard copyright header spacing |

These are the cops that have flagged offenses in the current codebase.
The full enforced set is defined in `config/chefstyle.yml`.

---

## Offenses Fixed in This PR

| File | Offense | Fix |
|------|---------|-----|
| `lib/cookstyle.rb:94` | `Style/ReturnNil` | `return nil if …` → `return if …` |
| `lib/cookstyle.rb:118` | `Style/StderrPuts` | `$stderr.puts format(…)` → `warn format(…)` |
| `spec/cookstyle_spec.rb:48` | `Style/RegexpLiteral` | `/…\/…/` → `%r{…/…}` |
| `spec/cookstyle_spec.rb:58` | `Style/StderrPuts` | `$stderr.puts format(…)` → `warn format(…)` |

---

## Current Baseline

As of 2026-05-26: **11 pre-existing offenses** in files not recently
modified (all `Chef/Style/CommentFormat` header spacing in chefstyle
cop files and their specs). All files touched by this PR are lint-clean.

Before fixes: 15 offenses → After fixes: 11 offenses.

---

## CI Integration

| Workflow | File | What it runs |
|----------|------|--------------|
| **lint** | `.github/workflows/lint.yml` | `bundle exec cookstyle` + linelint newline check |

The lint workflow runs on every push to `main` and on every PR.
Failures show inline annotations via `rubocop-problem-matchers-action`.

---

## Local CI Mirror

The `scripts/test-local.sh` script runs lint as part of its full pipeline:

```bash
# Full run (includes lint + validate_config + specs)
./scripts/test-local.sh

# Quick run (specs only, skips lint)
./scripts/test-local.sh --quick
```
