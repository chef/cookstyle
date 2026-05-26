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

## Common Issues

| Symptom | Fix |
|---------|-----|
| `bundle install` fails | Check Ruby version, delete `Gemfile.lock` and retry |
| Coverage < 80 % | Add missing specs |
| `validate_config` fails | Add the missing cop entry to `config/cookstyle.yml` |
| Lint offenses | Run `bundle exec cookstyle -a` for autocorrect |
