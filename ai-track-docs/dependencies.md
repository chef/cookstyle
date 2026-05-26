# Dependency Policy & Notes

Recorded: 2026-05-26

---

## Runtime Dependency (gemspec)

| Gem | Constraint | Resolved | Notes |
|-----|-----------|----------|-------|
| `rubocop` | `= 1.86.1` (exact pin) | 1.86.1 | **Most critical dependency.** Cookstyle monkey-patches RuboCop internals and vendors cop configurations against a specific AST / config API surface. An exact pin is **required** — even a patch bump can change node types, config keys, or cop base classes and silently break vendored cops. |

### Why exact-pin RuboCop?

Cookstyle applies monkey patches to four RuboCop internals
(`Config`, `Base`, `Team`, `RegistryCop`) and calls
`gem 'rubocop', "= #{Cookstyle::RUBOCOP_VERSION}"` at load time.
A loose constraint (e.g. `~> 1.86`) would allow patch versions that
could ship incompatible changes to patched methods.

**Policy:** Keep the exact pin. Upgrade only by updating
`RUBOCOP_VERSION` in `lib/cookstyle/version.rb`, running the full
spec suite, and verifying `validate_config`.

---

## Transitive Runtime Dependencies (via RuboCop 1.86.1)

These are pulled in automatically. No action required unless a CVE
is filed against one of them.

| Gem | Constraint (from rubocop) | Resolved | Risk |
|-----|--------------------------|----------|------|
| `rubocop-ast` | `>= 1.49.0, < 2.0` | 1.49.1 | Medium — AST node API used by every cop |
| `parser` | `>= 3.3.0.2` | 3.3.11.1 | Low — stable, well-tested |
| `prism` | `~> 1.7` (via rubocop-ast) | 1.9.0 | Low — new parser backend |
| `json` | `~> 2.3` | 2.19.5 | Low — stdlib replacement |
| `language_server-protocol` | `~> 3.17.0.2` | 3.17.0.5 | Low |
| `lint_roller` | `~> 1.1.0` | 1.1.0 | Low |
| `parallel` | `>= 1.10` | 1.28.0 | Low |
| `rainbow` | `>= 2.2.2, < 4.0` | 3.1.1 | Low |
| `regexp_parser` | `>= 2.9.3, < 3.0` | 2.12.0 | Low |
| `ruby-progressbar` | `~> 1.7` | 1.13.0 | Low |
| `unicode-display_width` | `>= 2.4.0, < 4.0` | 3.2.0 | Low |

---

## Development / Test Dependencies (Gemfile only)

These are **not** shipped to users. Constraints can be looser.

| Gem | Constraint | Resolved | Recommendation |
|-----|-----------|----------|----------------|
| `rspec` | `>= 3.4` | 3.13.2 | OK — floor pin is sufficient; no need to tighten |
| `rake` | (any) | 13.4.2 | OK — stable |
| `yard` | (any) | 0.9.44 | OK — docs only |
| `appbundler` | (any) | 0.13.4 | OK — packaging only |
| `pry` | (any) | 0.16.0 | OK — debug only |
| `memory_profiler` | (any) | 1.1.0 | OK — profiling only |
| `stackprof` | (any) | 0.2.28 | OK — profiling only |

---

## Ruby Version

| Constraint | Current Dev | Notes |
|-----------|-------------|-------|
| `>= 2.7` (gemspec) | 3.1.7 | Ruby 2.7 reached EOL 2023-03. Consider raising to `>= 3.1` when the next major Cookstyle version ships. No change needed now. |

---

## Proposed Constraints (minimal, no major upgrades)

All current pins are appropriate. No changes recommended at this time.

| Item | Current | Proposed | Rationale |
|------|---------|----------|-----------|
| `rubocop` | `= 1.86.1` | **Keep exact pin** | Monkey patches require exact version match |
| `rubocop-ast` | (transitive) | No action | Locked by RuboCop's own constraint |
| `rspec` | `>= 3.4` | Keep as-is | Floor pin is fine for dev dependency |
| `ruby` | `>= 2.7` | Keep for now | Raise to `>= 3.1` in next major only |

### What to do when upgrading RuboCop

1. Update `RUBOCOP_VERSION` in `lib/cookstyle/version.rb`
2. `bundle update rubocop`
3. Review monkey patches in `lib/rubocop/monkey_patches/` against the new version's source
4. `bundle exec rake spec` — fix any broken cops
5. `bundle exec rake validate_config` — ensure all cops registered
6. Update this document with new resolved versions

---

## Security Monitoring

- Watch [RuboCop releases](https://github.com/rubocop/rubocop/releases) for security patches
- Run `bundle audit` periodically (add `bundler-audit` to Gemfile if not present)
- Transitive gems (`parser`, `json`, `regexp_parser`) are common CVE targets — check advisories on upgrade
