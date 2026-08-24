# AGENTS.md

Instructions for AI coding agents working in this repository. Human contributors want [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md) and [WRITING_RULES.md](WRITING_RULES.md), which this file points at rather than duplicating.

## What this project is

Cookstyle is RuboCop with a vendored configuration and a set of Chef Infra and InSpec specific cops. Read [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md) for the architecture before making structural changes.

## Verify before you claim

```bash
bundle exec rake
```

That runs lint, the full spec suite, and config validation in a few seconds. Run it and read the output before reporting work as done. Individual pieces: `rake spec`, `rake style`, `rake validate_config`.

This project does not measure test coverage — SimpleCov is not a dependency and no coverage report is produced. Do not report coverage percentages or treat a coverage threshold as a gate.

## Adding or changing a cop

Follow [WRITING_RULES.md](WRITING_RULES.md). The parts most often gotten wrong:

- **Every cop needs an entry in `config/cookstyle.yml`.** `rake validate_config` fails otherwise.
- **Every cop needs both a positive and a negative spec example.** `expect_offense` proves it fires; `expect_no_offenses` proves it doesn't fire on code it shouldn't touch. For an autocorrecting cop, a false positive rewrites a working cookbook.
- **New cops use `severity: :refactor`.** This is deliberate — new rules must not fail existing builds.
- **Set `RESTRICT_ON_SEND` and `Include`/`Exclude`.** Without them the cop runs against every method call in every file.
- **Declare `minimum_target_chef_version`** if the corrected code needs a newer Chef Infra Client.

## Don't hand-edit generated files

- `docs-chef-io/assets/cookstyle/*.yml` — run `rake generate_cops_yml_documentation`
- The cop count in `README.md` — run `rake update_readme_cop_count`
- `CHANGELOG.md`, `RELEASE_NOTES.md`, `VERSION` — maintained by Expeditor

## Don't change without a specific reason to

- `config/chefstyle.yml` and `config/default.yml`
- `.expeditor/` release automation
- `LICENSE`, `NOTICE`, `CODE_OF_CONDUCT.md`
- `lib/rubocop/monkey_patches/` — these patch RuboCop internals and are pinned to an exact RuboCop version

## Commits and pull requests

**Every commit needs a DCO signoff or the build fails:**

```bash
git commit --signoff -m "Your message"
```

Branch from `main`, never commit to it directly. Label the PR — see the table in [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md#pull-requests) — since labels drive the changelog and release automation.

Write commit messages and PR descriptions that explain why the change is needed and what was verified. Do not credit AI assistance in commit messages, PR descriptions, or code comments.

## Scope

Do what was asked. This is a widely deployed linter, so unrequested cop changes, severity changes, and config changes have a large blast radius. If you notice an unrelated problem, mention it rather than fixing it in the same change.
