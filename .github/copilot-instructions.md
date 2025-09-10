# GitHub Copilot Instructions for cookstyle

---

## 1. Repository Analysis & Structure

### Project Purpose
Cookstyle is a code linting tool for Chef Infra cookbooks and InSpec profiles, providing style, syntax, logic, and security checks with autocorrection. It is powered by RuboCop and tailored for Chef ecosystem development.

### Folder Structure Diagram

```
/ (root)
├── bin/                # Executable scripts (cookstyle, cookstyle-profile)
├── config/             # Linting configuration files (chefstyle.yml, cookstyle.yml, default.yml)
├── docs/               # Markdown documentation for cops and usage
├── docs-chef-io/       # Go module for documentation site integration
│   └── assets/cookstyle/ # YAML docs for individual cops
├── habitat/            # Habitat packaging and test scripts
│   └── tests/          # Habitat test scripts
├── lib/                # Main Ruby source code (cookstyle, rubocop, cops, helpers)
│   └── rubocop/
│       ├── chef/       # Chef-specific cops and helpers
│       ├── cop/        # Cop definitions
│       └── monkey_patches/ # RuboCop monkey patches
├── spec/               # RSpec unit tests (mirrors lib/ structure)
│   └── shared/         # Shared test helpers
├── tasks/              # Rake tasks for docs, profiling, spellcheck
├── .expeditor/         # Expeditor build automation config
├── .github/            # GitHub workflows, CODEOWNERS, and Copilot instructions
├── CHANGELOG.md        # Changelog
├── CODE_OF_CONDUCT.md  # Code of conduct
├── CONTRIBUTING.md     # Contribution guide
├── DEVELOPER_GUIDE.md  # Developer guide for maintainers
├── Gemfile             # Ruby gem dependencies
├── LICENSE             # Apache 2.0 license
├── Rakefile            # Rake build/test tasks
├── README.md           # Project overview and usage
├── RELEASE_NOTES.md    # Release notes
├── VERSION             # Current version
├── WRITING_RULES.md    # Guide for writing new cops/rules
```

### Languages, Frameworks, and Technologies
- **Ruby** (primary, for linting engine, cops, and CLI)
- **Go** (for docs-chef-io integration)
- **RSpec** (unit testing)
- **Rake** (build/test tasks)
- **Habitat** (packaging)
- **Expeditor** (build/release automation)

### Modification Guidelines
- **Safe to Modify:**
  - `lib/`, `spec/`, `docs/`, `docs-chef-io/assets/cookstyle/`, `tasks/`, `bin/`, `config/cookstyle.yml`
- **Prohibited/Generated:**
  - `config/chefstyle.yml` (internal, do not edit unless core Chef dev)
  - `config/default.yml` (do not edit unless updating RuboCop engine)
  - `docs-chef-io/go.mod` (managed by docs site tooling)
  - Any files in `vendor/` or `files/` (excluded by config)
- **Never Modify:**
  - LICENSE, CODE_OF_CONDUCT.md, unless updating legal/compliance
  - .expeditor/config.yml, unless updating build automation

### Code Generation Patterns
- All cops must be defined in `config/cookstyle.yml` and have documentation in `docs/` and `docs-chef-io/assets/cookstyle/`.
- Do not modify files in `config/chefstyle.yml` or `config/default.yml` unless you are a core maintainer.

---

## 2. Development Workflow Integration

### Jira Integration (atlassian-mcp-server)
- When a Jira ID is provided, fetch issue details using the MCP server.
- Read the story, analyze requirements, and plan implementation.
- **Workflow Phases:**
  - **Phase 1: Initial Setup & Analysis**
    - Fetch Jira details, analyze repo, plan implementation.
    - Prompt: "Jira story <ID> loaded. Analysis complete. Ready to plan implementation. Proceed?"
  - **Phase 2: Implementation Phase**
    - Implement code, update docs, follow repo structure.
    - Prompt: "Implementation complete. Ready for testing phase. Proceed?"
  - **Phase 3: Testing Phase**
    - Create/extend unit tests, run tests, validate coverage.
    - Prompt: "Testing complete. Ready for PR creation. Proceed?"
  - **Phase 4: Pull Request Creation**
    - Use GH CLI for all git operations, create PR, add labels.
    - Prompt: "PR created. Ready for review. Proceed?"
- **Approval Gates:**
  - After each phase, summarize work, list next steps, and ask for confirmation before proceeding.

---

## 3. Testing Requirements (**Critical - Hard Requirement**)
- **MANDATORY:** All code changes must include comprehensive unit tests.
- **Test Coverage:** >80% coverage is a **hard, non-negotiable requirement**. PRs below this threshold will be rejected.
- **Framework:** Use RSpec for Ruby code. Place tests in `spec/` mirroring the `lib/` structure.
- **Test Structure Example:**
  ```ruby
  # spec/rubocop/cop/chef/my_cop_spec.rb
  require 'spec_helper'
  describe RuboCop::Cop::Chef::MyCop do
    it 'registers an offense for bad code' do
      expect_offense(<<~RUBY)
        ...
      RUBY
    end
    it 'does not register an offense for good code' do
      expect_no_offenses(<<~RUBY)
        ...
      RUBY
    end
  end
  ```
- **Coverage Verification:**
  - Run: `bundle exec rake coverage`
  - Ensure output shows >80% coverage.
- **Test Both:**
  - Positive and negative scenarios
  - Edge cases and error conditions
  - Use mocks for external dependencies
  - Ensure tests are independent and order-agnostic
- **Test Command:**
  - `bundle exec rake spec`
  - `bundle exec rake coverage`

---

## 4. Pull Request Creation Process
- **Branch Name:** Use Jira ID (e.g., `PROJ-123`)
- **Git Operations (GH CLI):**
  ```bash
  git checkout -b <JIRA_ID>
  git add .
  git commit --signoff -m "<JIRA_ID>: <description>"
  git push origin <JIRA_ID>
  gh pr create --title "<JIRA_ID>: <summary>" --body '<html><b>Summary:</b> ...<br><b>Jira:</b> <a href="https://jira.example.com/browse/<JIRA_ID>"><JIRA_ID></a><br><b>Changes:</b> ...<br><b>Testing:</b> ...<br><b>Files Modified:</b> ...</html>' --label '<label1>' --label '<label2>'
  ```
- **PR Description:** Must be HTML-formatted and include:
  - Summary of changes
  - Jira ticket link
  - List of changes
  - Testing performed and coverage
  - Files modified
  - Screenshots/examples if applicable

---

## 5. DCO (Developer Certificate of Origin) Compliance
- **ALL commits MUST use `--signoff`**:
  - `git commit --signoff -m "..."`
  - `git commit -s -m "..."`
- **Amend if missing:**
  - `git commit --amend --signoff --no-edit`
- **Builds will fail without DCO signoff.**
- **All commit examples must include `--signoff`.**

---

## 6. Build System Integration Analysis
- **Expeditor:**
  - Config: `.expeditor/config.yml`
  - **Skip Labels:**
    - `Expeditor: Skip All`, `Expeditor: Skip Version Bump`, `Expeditor: Skip Changelog`, `Expeditor: Skip Habitat`, `Expeditor: Skip Omnibus`
  - **When to Use:**
    - Docs/test-only: `Skip All` or `Skip Version Bump`
    - Changelog-only: `Skip Changelog`
    - Habitat/Omnibus: skip as needed
  - **Build Channels:** `unstable`, `chef-dke-lts2024`
  - **Promotion:** On PR merge, version bump, changelog update, gem build, pipeline triggers
- **Rake:**
  - `rake style` (lint)
  - `rake spec` (tests)
  - `rake coverage` (coverage)
  - `rake validate_config` (cop config validation)
  - `rake docs` (YARD docs)
- **Habitat:**
  - `habitat/plan.sh` and `plan.ps1` for packaging
  - `habitat/tests/` for test scripts
- **CI/CD:**
  - Buildkite, Expeditor, Habitat pipelines

---

## 7. Label Management System
- **Actual Labels:**
  - `Type: Bug`, `Type: Enhancement`, `Type: Regression`, `Aspect: Documentation`, `Aspect: Testing`, `Aspect: Security`, `Aspect: Performance`, `Aspect: Portability`, `Aspect: Stability`, `Aspect: Integration`, `Aspect: Packaging`, `Expeditor: Skip All`, `Expeditor: Skip Version Bump`, `Expeditor: Skip Changelog`, `Expeditor: Skip Habitat`, `Expeditor: Skip Omnibus`, `Priority: Critical/Medium/Low`, `Status: Incomplete`, `Platform: ...`
- **Label Decision Matrix:**
  - **Docs:** `Aspect: Documentation`, `Expeditor: Skip All`
  - **Feature:** `Type: Enhancement`, `Aspect: ...`
  - **Bug:** `Type: Bug`, `Aspect: ...`
  - **Test-only:** `Aspect: Testing`, `Expeditor: Skip Version Bump`
  - **Security:** `Aspect: Security`, `Priority: Critical`
- **Always use repository-specific labels.**

---

## 8. Prompt-Based Execution Protocol
- **After each major step:** Summarize work completed
- **Before next step:** State what will be done next
- **Ask for confirmation:** "Do you want me to continue with the next step?"
- **List remaining steps**
- **Wait for approval before proceeding**
- **Example:**
  > "Phase 1 complete: Jira story analyzed and implementation plan created. Next: begin implementation. Remaining: Implementation, Testing, PR. Do you want me to continue?"

---

## 9. Repository-Specific Guidelines
- **Build:** Use Rake tasks (`rake style`, `rake spec`, `rake coverage`)
- **Dependencies:** Use Bundler (`bundle install`)
- **Habitat:** Use `plan.sh`/`plan.ps1` for packaging
- **Prohibited Modifications:** See section 1
- **Platform:** macOS, Linux, Windows (Habitat)
- **Integration:** Chef ecosystem, RuboCop, Expeditor, Habitat

---

## 10. Code Quality & Standards
- **Style:** Chefstyle, RuboCop, Cookstyle
- **Lint:** `rake style`, `cookstyle` CLI
- **Security:** Address all CVEs, use secure dependencies
- **License:** Apache 2.0 (see LICENSE)
- **Performance:** Use efficient algorithms, avoid regressions
- **Review:** CODEOWNERS: @chef/chef-infra-owners, @chef/chef-infra-approvers, @chef/chef-infra-reviewers

---

## 11. Security and Compliance Requirements
- **CVE Awareness:** Monitor dependencies
- **FIPS Compliance:** If required, ensure all code is FIPS-compliant
- **License Headers:** Apache 2.0
- **Security Scanning:** Use CI/CD pipeline tools
- **Authentication:** Use GH CLI, no profile-based auth

---

## 12. Build & Development Environment
- **Setup:**
  - `bundle install`
  - `bundle exec rake style`
  - `bundle exec rake spec`
  - `bundle exec rake coverage`
- **Habitat:**
  - `hab studio enter`
  - `build .`
- **Troubleshooting:**
  - Bundler errors: check Gemfile.lock
  - Coverage <80%: add more tests
  - Lint errors: run `cookstyle` and fix offenses

---

## 13. Integration & Dependencies
- **Ecosystem:** Chef Infra, RuboCop, Habitat, Expeditor
- **External Services:** Jira (via MCP), Slack (Expeditor notifications)
- **API:** None directly
- **Database:** None
- **MCP Server:** atlassian-mcp-server for Jira integration

---

## 14. Release & CI/CD Awareness
- **Pipelines:** Buildkite, Expeditor, Habitat
- **Release Channels:** unstable, chef-dke-lts2024
- **Automation:** On PR merge, version bump, changelog, gem build, pipeline triggers
- **Notifications:** Slack #chef-ws-notify

---

## 15. Code Ownership & Review Process
- **CODEOWNERS:**
  - All files: @chef/chef-infra-owners, @chef/chef-infra-approvers, @chef/chef-infra-reviewers
- **Review:** At least one owner/approver must review PRs
- **Special Requirements:** None

---

## 16. Important Development Notes
- **All work is performed locally**
- **Ask for clarification if requirements are unclear**
- **Never modify prohibited files**
- **Troubleshooting:** See section 12
- **Build/Test Commands:** See section 12
- **Performance:** Avoid regressions, optimize for large codebases

---

## 17. Example Workflow Execution

### Example: Feature Implementation

> **User:** "Implement PROJ-123: Add new cop for Chef/Style/ExampleCop"
>
> **Copilot:**
> 1. "Phase 1: Loaded Jira PROJ-123. Analyzing requirements and planning implementation. Do you want me to continue?"
> 2. (User confirms)
> 3. "Phase 2: Implementing new cop in lib/rubocop/cop/chef/style/example_cop.rb, updating config/cookstyle.yml, and adding docs. Do you want me to continue?"
> 4. (User confirms)
> 5. "Phase 3: Creating spec/rubocop/cop/chef/style/example_cop_spec.rb and running tests. Ensuring >80% coverage. Do you want me to continue?"
> 6. (User confirms)
> 7. "Phase 4: Creating PR with branch PROJ-123, DCO signoff, and labels. Do you want me to continue?"
> 8. (User confirms)
> 9. "Workflow complete. PR ready for review."

---

## 18. Technology-Specific Guidelines

### Ruby
- **Bundler:** Use `bundle install` for dependencies
- **RSpec:** Place tests in `spec/` mirroring `lib/`
- **Chefstyle:** Lint with `cookstyle` or `rake style`
- **Gem Management:** Use `Gemfile` and `cookstyle.gemspec`

### Go
- **docs-chef-io/go.mod**: Managed by documentation tooling
- **No Go code changes unless working on docs site integration**

### Habitat
- **Packaging:** Use `habitat/plan.sh` and `plan.ps1`
- **Testing:** Use scripts in `habitat/tests/`

---

## 19. Advanced Configuration Management
- **Config Files:** `config/cookstyle.yml`, `config/chefstyle.yml`, `config/default.yml`
- **Env Vars:** As required by Rake, Bundler, Habitat
- **Secrets:** None in repo; use environment variables for any secrets
- **Database/Service Config:** Not applicable

---

## Validation Checklist
- [x] Repository structure diagram
- [x] DCO signoff requirements in all commit examples
- [x] >80% test coverage requirement mentioned multiple times
- [x] Actual repository labels (not generic ones)
- [x] Build system integration (Expeditor, Rake, Habitat)
- [x] Prompt-based workflow examples
- [x] Technology-specific testing patterns
- [x] Complete Git workflow with proper commands
- [x] Security and compliance requirements
- [x] Troubleshooting section
- [x] Example interaction patterns

---

*For any questions, consult the README, DEVELOPER_GUIDE.md, or reach out to the CODEOWNERS team.*
