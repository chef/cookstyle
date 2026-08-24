# Contributing to a Progress Chef Workstation Project

Thank you for your interest in contributing to this project! It is part of the larger Progress Chef Workstation project. Contribution guidelines can be found at [Contributing to Progress Chef Workstation](https://chef.github.io/chef-oss-practices/projects/workstation/contributing/).

## Contributing to Cookstyle specifically

- **[WRITING_RULES.md](WRITING_RULES.md)** — how to write a new cop: anatomy, autocorrection, version gating, specs, and the config entry.
- **[DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md)** — repository layout, rake tasks, testing, PR labels, and the release process.
- **[AGENTS.md](AGENTS.md)** — instructions for AI coding agents.

Requesting a new cop rather than writing one? Open an issue with the [new cop request template](.github/ISSUE_TEMPLATE/NEW_COP_REQUEST.md).

### Quick start

```bash
bundle install
bundle exec rake        # lint, specs, and config validation
```

All commits need a [DCO](https://developercertificate.org/) signoff or the build will fail:

```bash
git commit --signoff -m "Your message"
```
