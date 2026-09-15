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

`rake` is not the whole of CI. CI also runs [linelint](.linelint.yml), which requires every file to end in exactly one newline, Markdown and YAML included. `rake style` only inspects Ruby files, so a `config/cookstyle.yml` entry or a docs file with no trailing newline passes locally and fails on the PR. `CHANGELOG.md` and `VERSION` are exempt.

## Adding or changing a cop

Follow [WRITING_RULES.md](WRITING_RULES.md). The parts most often gotten wrong:

- **Every cop needs an entry in `config/cookstyle.yml`.** `rake validate_config` fails otherwise.
- **Every cop needs both a positive and a negative spec example.** `expect_offense` proves it fires; `expect_no_offenses` proves it doesn't fire on code it shouldn't touch. For an autocorrecting cop, a false positive rewrites a working cookbook. `spec/negative_case_coverage_spec.rb` enforces this repo-wide, so a missing negative case fails as one list of file paths rather than as a failure in your own spec.
- **New cops use `severity: :refactor`.** This is deliberate — new rules must not fail existing builds.
- **Set `RESTRICT_ON_SEND` and `Include`/`Exclude`.** Without them the cop runs against every method call in every file.
- **Declare `minimum_target_chef_version`** if the corrected code needs a newer Chef Infra Client.
- **Don't add cops to `Chef/Effortless`.** The department is slated for removal. It is already exempt from the negative-case check and absent from the department table in WRITING_RULES.md.

A cop's name comes from its module nesting, not its file path — `rake validate_config` walks the constants under `RuboCop::Cop::Chef`. The directory is convention only, and it does not always match the department it holds, so copy the nesting from a neighboring cop rather than inferring it from the path:

| Directory | Department | Config file |
| --- | --- | --- |
| `lib/rubocop/cop/chef/deprecation/` | `Chef/Deprecations` | `config/cookstyle.yml` |
| `lib/rubocop/cop/chef/redundant/` | `Chef/RedundantCode` | `config/cookstyle.yml` |
| `lib/rubocop/cop/inspec/deprecation/` | `InSpec/Deprecations` | `config/cookstyle.yml` |
| `lib/rubocop/cop/chefstyle/ruby/` | `Chef/Ruby` | `config/chefstyle.yml` |

Every other directory under `lib/rubocop/cop/chef/` matches its department name. New cop files need no `require` — `lib/cookstyle.rb` globs the whole tree.

## Don't hand-edit generated files

- `docs-chef-io/assets/cookstyle/*.yml` — run `rake generate_cops_yml_documentation`
- The cop count in `README.md` — run `rake update_readme_cop_count`
- `CHANGELOG.md`, `RELEASE_NOTES.md`, `VERSION` — maintained by Expeditor

`rake generate_cops_yml_documentation` is not idempotent on current Ruby. Psych 5.3 stopped emitting a trailing space after an empty `examples:` or `version_added:` key, so the task rewrites about a dozen files generated before that change and unrelated to your cop. Stage the file for the cop you touched, then `git checkout -- docs-chef-io/` to drop the rest of the churn.

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

Applying those labels needs write access on `chef/cookstyle`. From a fork, `gh pr create --label ...` opens the PR and then fails with a permission error on `AddLabelsToLabelable`, leaving it unlabeled — the PR is created, so don't retry the command. Name the labels the change should carry in the PR description instead, so a maintainer can apply them.

Write commit messages and PR descriptions that explain why the change is needed and what was verified. Do not credit AI assistance in commit messages, PR descriptions, or code comments.

## Scope

Do what was asked. This is a widely deployed linter, so unrequested cop changes, severity changes, and config changes have a large blast radius. If you notice an unrelated problem, mention it rather than fixing it in the same change.
