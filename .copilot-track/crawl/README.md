# Copilot Crawl — Tracking AI-Assisted Work

This directory tracks incremental, AI-assisted changes made via **chain-PRs** (a sequence of small, dependent pull requests that together deliver a feature or refactor).

## What Are Chain-PRs?

A **chain-PR** is a pull request that builds on the previous one in a series:

```
PR #1  (base: main)   — scaffolding / interfaces
PR #2  (base: PR #1)  — core implementation
PR #3  (base: PR #2)  — tests + docs
```

Each PR is small, reviewable, and independently CI-green.
When merged in order, the full feature lands on `main`.

## Evidence in PRs

Every chain-PR should include **evidence of correctness**:

- **Test results** — paste or link CI output (`bundle exec rake spec`).
- **Coverage delta** — note coverage before/after (must stay >80 %).
- **Lint clean** — confirm `bundle exec rake style` passes.
- **Config validation** — confirm `bundle exec rake validate_config` passes (for cop changes).
- **Screenshots / logs** — where applicable (e.g. new cop offense output).

## Prompt Usage

AI prompts used to generate or review code are stored here for reproducibility.

### Conventions

1. **One file per chain** — e.g. `crawl/chain-001-add-cop.md`.
2. **Include the prompt** — the exact instruction given to the AI.
3. **Include the outcome** — summary of what was generated or changed.
4. **Tag with PR numbers** — so reviewers can cross-reference.

### Example Entry

```markdown
# Chain 001 — Add Chef/Style/ExampleCop

## Prompt
> Create a new cop that detects X and autocorrects to Y…

## Outcome
- Created `lib/rubocop/cop/chef/style/example_cop.rb`
- Added config entry in `config/cookstyle.yml`
- Added spec with 12 examples, 0 failures
- Coverage: 94 %

## PRs
- PR #101 (scaffolding)
- PR #102 (implementation + tests)
```

## Directory Structure

```
.copilot-track/
  crawl/
    README.md          ← this file
    chain-NNN-*.md     ← one file per chain-PR sequence
```
