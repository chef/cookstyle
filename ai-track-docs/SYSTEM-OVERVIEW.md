# Cookstyle — System Overview

## What Is Cookstyle?

Cookstyle is a **code-linting and autocorrection tool** for Chef Infra cookbooks and InSpec profiles.
It extends [RuboCop](https://rubocop.org) with 250+ Chef-specific cops organised into departments (Correctness, Deprecations, Modernize, Style, Sharing, Redundant Code, Effortless, Security).

**Current version:** see `VERSION` (8.7.0 at time of writing).

## Key Concepts

| Term | Meaning |
|------|---------|
| **Cop** | A single lint rule. Lives under `lib/rubocop/cop/chef/<department>/`. |
| **Department** | A group of related cops (e.g. `Chef/Correctness`, `Chef/Style`). |
| **Autocorrect** | Many cops can rewrite offending code automatically. |
| **Config** | `config/cookstyle.yml` is the canonical cop registry. Every cop must be listed here. |

## Repository Layout (abbreviated)

```
bin/              # CLI entry-points (cookstyle, cookstyle-profile)
config/           # Cop configuration (cookstyle.yml, default.yml, chefstyle.yml)
lib/              # Source
  cookstyle.rb    # Top-level loader
  rubocop/
    cop/chef/     # Cops by department
    chef/         # Helpers, autocorrect utilities
    monkey_patches/
spec/             # RSpec tests (mirrors lib/)
docs/             # Markdown cop documentation
docs-chef-io/     # YAML cop docs consumed by docs.chef.io
tasks/            # Rake tasks (docs, profiling, spellcheck)
habitat/          # Habitat packaging (plan.sh / plan.ps1)
```

## Build & Test

```bash
bundle install
bundle exec rake style     # lint cookstyle itself
bundle exec rake spec      # run tests
bundle exec rake coverage  # tests + coverage (must be >80 %)
bundle exec rake validate_config  # ensure every cop is in cookstyle.yml
```

## CI / Release

- **Buildkite** runs verify on every push.
- **Expeditor** bumps version, updates CHANGELOG, builds gem, triggers Habitat pipelines on merge.
- Release channels: `unstable`, `chef-dke-lts2024`.

## Upstream Dependencies

- RuboCop (linting engine)
- Chef Infra Client (target of cops)
- Habitat / Omnibus (packaging)
