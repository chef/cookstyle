# Build & Test Quick Reference

## Prerequisites

- Ruby (see `.ruby-version` or Gemfile for version)
- Bundler (`gem install bundler`)

## Install Dependencies

```bash
bundle install
```

## Lint (Cookstyle on itself)

```bash
bundle exec rake style
# — or —
bundle exec cookstyle
```

## Run Tests

```bash
bundle exec rake spec          # all specs under spec/cop/
bundle exec rspec spec/rubocop/cop/chef/style/  # one department
```

## Coverage

```bash
bundle exec rake coverage
# Sets COVERAGE=true, then runs spec suite.
# Requirement: >80 % line coverage.
```

## Validate Cop Config

```bash
bundle exec rake validate_config
# Ensures every cop constant in RuboCop::Cop::Chef is listed in config/cookstyle.yml.
```

## Writing a New Cop

1. Create `lib/rubocop/cop/chef/<department>/<cop_name>.rb`.
2. Add an entry to `config/cookstyle.yml`.
3. Add an RSpec file at `spec/rubocop/cop/chef/<department>/<cop_name>_spec.rb`.
4. Add documentation in `docs/` and `docs-chef-io/assets/cookstyle/`.
5. Run `rake spec` and `rake validate_config`.

See `WRITING_RULES.md` for the full guide.

## Habitat Build (optional)

```bash
hab studio enter
build .
# Tests: habitat/tests/test.sh (Linux) / test.ps1 (Windows)
```

## Exact Build & Test Commands (copy-paste ready)

```bash
# 1. Install dependencies
bundle install

# 2. Lint the codebase (Cookstyle on itself)
bundle exec rake style

# 3. Run the full test suite
bundle exec rake spec

# 4. Run a single spec file
bundle exec rspec spec/cookstyle_spec.rb --format documentation

# 5. Run one department of cops
bundle exec rspec spec/rubocop/cop/chef/style/ --format documentation

# 6. Run tests with coverage (must be >80%)
bundle exec rake coverage

# 7. Validate cop config
bundle exec rake validate_config
```

## Deterministic Unit Test Added

A lightweight spec for the `Cookstyle` module was added at
`spec/cookstyle_spec.rb`. It verifies:

- `Cookstyle::VERSION` is a valid semver string
- `Cookstyle::RUBOCOP_VERSION` is a valid semver string
- `Cookstyle.config` returns a path ending in `config/default.yml`
- `Cookstyle.config` points to a file that exists on disk

Run it with:

```bash
bundle exec rspec spec/cookstyle_spec.rb --format documentation
```

## Common Issues

| Symptom | Fix |
|---------|-----|
| `bundle install` fails | Check Ruby version, delete `Gemfile.lock` and retry |
| Coverage < 80 % | Add missing specs |
| `validate_config` fails | Add the missing cop entry to `config/cookstyle.yml` |
| Lint offenses | Run `bundle exec cookstyle -a` for autocorrect |
