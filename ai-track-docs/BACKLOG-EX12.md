# Backlog — Cookstyle Improvements

Generated: 2026-05-26
Source: automated repo analysis

---

## BACKLOG-1: Raise minimum Ruby version to >= 3.1

**Priority:** Medium
**Type:** Chore

The gemspec pins `required_ruby_version = '>= 2.7'`
([cookstyle.gemspec#L15](../cookstyle.gemspec)) but Ruby 2.7 reached EOL in
March 2023. CI already tests only Ruby 3.1 and 3.4
([.github/workflows/unit.yml#L14](../.github/workflows/unit.yml)).

**Acceptance Criteria:**
- [ ] `cookstyle.gemspec` updated to `required_ruby_version = '>= 3.1'`
- [ ] `.ruby-version` file added with `3.1` (enables rbenv/asdf auto-switch)
- [ ] CI matrix unchanged (already correct)
- [ ] `bundle exec rake spec` passes
- [ ] CHANGELOG entry added

---

## BACKLOG-2: Add bundler-audit to CI for dependency CVE scanning

**Priority:** High
**Type:** Security

No dependency vulnerability scanning exists in CI. The gap is documented in
[ai-track-docs/security-hygiene.md](security-hygiene.md) and
[ai-track-docs/dependencies.md](dependencies.md) but not yet implemented.

**Acceptance Criteria:**
- [ ] `bundler-audit` gem added to `:development` group in [Gemfile](../Gemfile)
- [ ] New workflow `.github/workflows/audit.yml` runs `bundle exec bundle-audit check --update` on push/PR
- [ ] Existing `Gemfile.lock` passes audit (fix any flagged CVEs)
- [ ] Workflow failure blocks merge via allchecks gate

---

## BACKLOG-3: Wire up code coverage in CI with enforcement

**Priority:** Medium
**Type:** Enhancement

The Rakefile defines a `coverage` task ([Rakefile#L18-L21](../Rakefile)) but no
CI workflow runs it. `simplecov` is not in the [Gemfile](../Gemfile) so
`COVERAGE=true` has no effect. The >80% coverage requirement in
[CONTRIBUTING.md](../CONTRIBUTING.md) is unverified.

**Acceptance Criteria:**
- [ ] `simplecov` gem added to `:development` group in Gemfile
- [ ] `spec/spec_helper.rb` conditionally requires SimpleCov when `ENV['COVERAGE']`
- [ ] CI workflow (`unit.yml`) adds a coverage job on one matrix entry (e.g. ubuntu + Ruby 3.4)
- [ ] Coverage report uploaded as artifact or to a reporting service
- [ ] Build fails if line coverage drops below 80%

---

## BACKLOG-4: Add missing specs for 4 uncovered cops

**Priority:** Medium
**Type:** Testing

Four cops lack corresponding spec files:

| Cop | Source | Missing spec |
|-----|--------|-------------|
| `Chef/Correctness/MetadataMalformedVersion` | `lib/rubocop/cop/chef/correctness/metadata_malformed_version.rb` | `spec/rubocop/cop/chef/correctness/metadata_malformed_version_spec.rb` |
| `Chef/Correctness/MetadataMissingVersion` | `lib/rubocop/cop/chef/correctness/metadata_missing_version.rb` | `spec/rubocop/cop/chef/correctness/metadata_missing_version_spec.rb` |
| `Chef/Deprecations/LegacyYumCookbookRecipes` | `lib/rubocop/cop/chef/deprecation/legacy_yum_cookbook_recipes.rb` | `spec/rubocop/cop/chef/deprecation/legacy_yum_cookbook_recipes_spec.rb` |
| `Chef/Deprecations/LogResourceNotifications` | `lib/rubocop/cop/chef/deprecation/log_resource_notifications.rb` | `spec/rubocop/cop/chef/deprecation/log_resource_notifications_spec.rb` |

**Acceptance Criteria:**
- [ ] Each missing spec file created with `expect_offense` and `expect_no_offenses` examples
- [ ] Autocorrect cops include `expect_correction` tests
- [ ] `bundle exec rake spec` passes with all new specs
- [ ] `bundle exec rake validate_config` passes
- [ ] Coverage does not decrease

---

## BACKLOG-5: Document test-local.sh in CONTRIBUTING.md

**Priority:** Low
**Type:** Documentation

`scripts/test-local.sh` mirrors the CI pipeline locally but is only
referenced in internal AI tracking docs. It appears nowhere in
[CONTRIBUTING.md](../CONTRIBUTING.md) or [README.md](../README.md),
so contributors won't discover it.

**Acceptance Criteria:**
- [ ] `CONTRIBUTING.md` "Testing" section updated to mention `./scripts/test-local.sh`
- [ ] Both full and `--quick` modes documented
- [ ] `README.md` "Development" section includes a one-liner reference
- [ ] No code changes required
