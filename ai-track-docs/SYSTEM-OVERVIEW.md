# Cookstyle — System Overview

## What Is Cookstyle?

Cookstyle is a **code-linting and autocorrection tool** for Chef Infra cookbooks and InSpec profiles.
It extends [RuboCop](https://rubocop.org) with 250+ Chef-specific cops organised into departments (Correctness, Deprecations, Modernize, Style, Sharing, Redundant Code, Effortless, Security).

**Current version:** see `VERSION` (8.7.0 at time of writing).

---

## Languages

| Language | Role | Key locations |
|----------|------|---------------|
| **Ruby** | Primary — cops, CLI, specs, Rake tasks | `lib/`, `spec/`, `bin/`, `tasks/`, `Rakefile` |
| **YAML** | Cop configuration | `config/cookstyle.yml`, `config/default.yml`, `config/chefstyle.yml` |
| **Shell** | Habitat packaging (Linux) | `habitat/plan.sh`, `habitat/tests/test.sh` |
| **PowerShell** | Habitat packaging (Windows) | `habitat/plan.ps1`, `habitat/tests/test.ps1` |
| **Go** | Docs-site module only | `docs-chef-io/go.mod` |
| **Markdown** | Documentation | `docs/`, `README.md`, `WRITING_RULES.md` |

---

## Entry Points

### CLI executables

| File | Purpose |
|------|---------|
| `bin/cookstyle` | Main CLI. Loads `lib/cookstyle.rb`, selects config (`cookstyle.yml` or `chefstyle.yml` via `--chefstyle`), then delegates to `RuboCop::CLI`. |
| `bin/cookstyle-profile` | Profiling wrapper. Accepts `--memory` for allocation profiling; otherwise runs StackProf CPU profile. |

### Loader chain

```
bin/cookstyle
  → lib/cookstyle.rb            # top-level require; loads monkey patches + cop tree
    → lib/rubocop/chef.rb       # requires every cop department
      → lib/rubocop/cop/chef/correctness/*.rb
      → lib/rubocop/cop/chef/deprecation/*.rb
      → …
    → lib/rubocop/monkey_patches/  # TargetChefVersion support
```

### Rake tasks (via `Rakefile`)

| Task | What it does |
|------|--------------|
| `rake style` | Runs Cookstyle on its own source (`bundle exec cookstyle`) |
| `rake spec` | RSpec — pattern `spec/cop/**/*.rb` |
| `rake coverage` | Sets `COVERAGE=true`, then runs `spec` |
| `rake validate_config` | Asserts every `RuboCop::Cop::Chef::*` constant appears in `config/cookstyle.yml` |
| `rake docs` | YARD documentation generation |
| `rake default` | Runs `style` + `spec` + `validate_config` |

Additional Rake files: `tasks/cops_documentation.rake`, `tasks/prof.rake`, `tasks/spellcheck.rake`.

---

## Key Concepts

| Term | Meaning |
|------|---------|
| **Cop** | A single lint rule. Lives under `lib/rubocop/cop/chef/<department>/`. |
| **Department** | A group of related cops (e.g. `Chef/Correctness`, `Chef/Style`). |
| **Autocorrect** | Many cops can rewrite offending code automatically via `extend AutoCorrector`. |
| **Config** | `config/cookstyle.yml` is the canonical cop registry. Every cop must be listed here. |

---

## Repository Layout

```
bin/
  cookstyle              # main CLI
  cookstyle-profile      # profiling CLI
config/
  cookstyle.yml          # canonical cop registry (safe to modify)
  default.yml            # base RuboCop defaults (do not edit)
  chefstyle.yml          # internal ChefStyle config (do not edit)
lib/
  cookstyle.rb           # top-level loader
  cookstyle/
    version.rb           # gem version constant
    chefstyle.rb         # ChefStyle mode loader
  rubocop/
    chef.rb              # requires all cop departments
    chef/
      autocorrect_helpers.rb
      cookbook_helpers.rb
    cop/
      chef/
        correctness/     # 41 cops
        deprecation/     # 79 cops
        effortless/      #  9 cops
        modernize/       # 76 cops
        redundant/       # 23 cops
        security/        #  1 cop
        sharing/         #  7 cops
        style/           # 16 cops
      chefstyle/         # ChefStyle-only cops
      inspec/            # InSpec cops
      target_chef_version.rb
    monkey_patches/      # patches RuboCop for TargetChefVersion
spec/                    # RSpec tests — mirrors lib/ 1-to-1
  spec_helper.rb
  shared/
    autocorrect_behavior.rb
  rubocop/cop/chef/      # one spec per cop
docs/                    # Markdown cop docs
docs-chef-io/            # YAML cop docs for docs.chef.io
tasks/                   # Rake task files
habitat/                 # Habitat packaging
```

---

## Test Approach

- **Framework:** RSpec (≥ 3.4), using RuboCop's built-in `ExpectOffense` helpers.
- **Key helpers:**
  - `expect_offense(<<~RUBY … RUBY)` — assert a cop flags the marked line.
  - `expect_no_offenses(<<~RUBY … RUBY)` — assert clean code.
  - `include_examples 'autocorrect', original, corrected` — shared example in `spec/shared/autocorrect_behavior.rb`.
  - `target_chef_version(version)` — defined in `spec/spec_helper.rb`; builds a config with `TargetChefVersion`.
- **Coverage gate:** >80 % mandatory. Run `bundle exec rake coverage`.
- **Spec-to-cop ratio by department:**

| Department | Cops | Specs | Match |
|------------|------|-------|-------|
| `correctness/` | 41 | 41 | 100 % |
| `deprecation/` | 79 | 79 | 100 % |
| `effortless/` | 9 | 9 | 100 % |
| `modernize/` | 76 | 76 | 100 % |
| `redundant/` | 23 | 23 | 100 % |
| `security/` | 1 | 1 | 100 % |
| `sharing/` | 7 | 7 | 100 % |
| `style/` | 16 | 11 | ~69 % |

---

## Build & Test (quick reference)

```bash
bundle install
bundle exec rake style            # lint cookstyle itself
bundle exec rake spec             # run tests
bundle exec rake coverage         # tests + coverage (must be >80 %)
bundle exec rake validate_config  # ensure every cop is in cookstyle.yml
```

---

## CI / Release

- **Buildkite** runs verify on every push.
- **Expeditor** bumps version, updates CHANGELOG, builds gem, triggers Habitat pipelines on merge.
- Release channels: `unstable`, `chef-dke-lts2024`.

---

## Upstream Dependencies

- RuboCop (linting engine)
- Chef Infra Client (target of cops)
- Habitat / Omnibus (packaging)

---

## Low-Risk Modules (safe to modify)

| # | Department | Path | Cops | Specs | Why low-risk |
|---|-----------|------|------|-------|--------------|
| 1 | **Security** | `lib/rubocop/cop/chef/security/` | 1 | 1 | Smallest department; single cop (`SshPrivateKey`). |
| 2 | **Sharing** | `lib/rubocop/cop/chef/sharing/` | 7 | 7 | Metadata/documentation checks only; no runtime concepts. |
| 3 | **Effortless** | `lib/rubocop/cop/chef/effortless/` | 9 | 9 | Cohesive domain (Effortless constraints); self-contained. |

All three have 100 % spec coverage, no cross-department dependencies, and use straightforward AST pattern matching.

### Recommended starting point: `Chef/Sharing`

**Path:** `lib/rubocop/cop/chef/sharing/` (specs: `spec/rubocop/cop/chef/sharing/`)

**Why it is the lowest risk:**

1. **Simple domain** — The 7 cops validate cookbook metadata and resource documentation strings (`DefaultMaintainerMetadata`, `EmptyMetadataField`, `InvalidLicenseString`, `InsecureCookbookUrl`, `IncludePropertyDescriptions`, `IncludeResourceDescriptions`, `IncludeResourceExamples`). The logic is string/pattern matching on `metadata.rb` fields and resource DSL blocks — not deep AST traversal.
2. **Fully tested** — Every cop has a matching spec. Tests use the standard `expect_offense` / `expect_no_offenses` pattern and are easy to extend.
3. **Zero blast radius** — These cops only inspect `metadata.rb` and resource DSL fields. They never interact with Chef runtime concepts (data bags, search, vault) or RuboCop internals (monkey patches, config negotiation). A regression here cannot break other departments.
4. **Clear extension surface** — Adding a new metadata check (e.g. validating `source_url` format, enforcing a `chef_version` constraint) follows the identical pattern as the existing cops with no new infrastructure.

---

## Assumptions & Verification

| Assumption | How to verify |
|------------|---------------|
| Cop counts per department are current | `ls lib/rubocop/cop/chef/<dept>/*.rb \| wc -l` |
| Spec counts match | `ls spec/rubocop/cop/chef/<dept>/*_spec.rb \| wc -l` |
| `config/cookstyle.yml` lists every cop | `bundle exec rake validate_config` |
| Coverage stays above 80 % | `bundle exec rake coverage` |
| No cross-department imports in Sharing cops | `grep -r "require.*cop/chef" lib/rubocop/cop/chef/sharing/` (expect no hits) |
