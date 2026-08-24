# Writing Cookstyle Rules

This guide covers writing a new cop (a "rule") for Cookstyle. For repository layout, tooling, and the release process, see [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md).

A cop is a small class that walks the Ruby AST of a cookbook file and reports offenses. Cookstyle cops are ordinary [RuboCop](https://docs.rubocop.org/rubocop/development.html) cops that live in the `Chef` and `InSpec` namespaces and ship with a vendored configuration.

## Before you start

Open an issue using the [new cop request template](.github/ISSUE_TEMPLATE/NEW_COP_REQUEST.md) first. A cop that fires on real cookbooks in the wild is a support burden for everyone who runs Cookstyle in CI, so it's worth agreeing on the rule before writing it.

Two questions decide most of the design:

- **Which department does it belong to?** See the table below.
- **Does it require a minimum Chef Infra Client version?** If the corrected code only runs on Chef Infra Client 15 and up, the cop must declare that so users on older clients aren't handed a broken cookbook. See [Version gating](#version-gating).

## Departments

| Department | Purpose |
| --- | --- |
| `Chef/Correctness` | Code that is outright wrong or won't do what the author intended |
| `Chef/Deprecations` | Code that is deprecated or removed in a current Chef Infra Client |
| `Chef/Modernize` | Code that works but can be simplified using newer Chef Infra functionality |
| `Chef/RedundantCode` | Code that can be removed with no behavior change, regardless of Chef Infra release |
| `Chef/Security` | Potential security problems, such as secrets committed to a cookbook |
| `Chef/Sharing` | Missing metadata and documentation needed to share a cookbook with others |
| `Chef/Style` | Style and formatting preferences |
| `InSpec/Deprecations` | Deprecations in Chef InSpec profiles |

`config/cookstyle.yml` is the authoritative list.

## The five files

Adding a cop touches five things. The `validate_config` rake task enforces the second one; the rest are convention.

1. `lib/rubocop/cop/chef/<department>/<cop_name>.rb` — the cop
2. `config/cookstyle.yml` — the cop's configuration entry
3. `spec/rubocop/cop/chef/<department>/<cop_name>_spec.rb` — the spec
4. `docs-chef-io/assets/cookstyle/cops_chef_<department>_<copname>.yml` — generated, don't hand-write
5. `README.md` cop count — generated, don't hand-write

Run `bundle exec rake generate_cops_yml_documentation update_readme_cop_count` to produce 4 and 5 from your YARD comments. Expeditor also runs this on merge.

## Anatomy of a cop

Here is `Chef/Correctness/CookbookUsesNodeSave`, about as small as a cop gets. The Apache license header at the top of every file is required and enforced by `Chef/Style/CommentFormat`; copy it from a neighboring cop.

```ruby
module RuboCop
  module Cop
    module Chef
      module Correctness
        # Don't use node.save to save partial node data to the Chef Infra Server mid-run
        # unless it's a requirement of cookbook design that can't be avoided.
        #
        # @example
        #
        #   # bad
        #   node.save
        #
        class CookbookUsesNodeSave < Base
          MSG = "Don't use node.save to save partial node data to the Chef Infra Server mid-run..."
          RESTRICT_ON_SEND = [:save].freeze

          def_node_matcher :node_save?, <<-PATTERN
            (send (send nil? :node) :save)
          PATTERN

          def on_send(node)
            node_save?(node) do
              add_offense(node, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
```

Points worth knowing:

**Subclass `Base`.** The legacy `RuboCop::Cop::Cop` API is gone from this codebase; every cop here subclasses `Base`.

**The YARD comment above the class is the public documentation.** It is extracted verbatim to docs.chef.io by `rake generate_cops_yml_documentation`. The `@example` block must contain valid Ruby — `rake documentation_syntax_check` parses it — and should show `# bad` and, where a fix exists, `# good`.

**`MSG` is what the user sees.** Write it as advice, not as a description of the check. It also appears in the spec's `expect_offense` annotation, so keep it stable.

**`RESTRICT_ON_SEND` is a performance gate, not a filter for correctness.** RuboCop only calls `on_send` for the method names listed, across every file in the run. Omitting it means your cop is invoked for every method call in every cookbook. Always set it when your cop keys off a `send` node.

**Use `def_node_matcher` rather than hand-walking the AST.** Node patterns are faster, and far easier to read six months later. `bundle exec ruby-parse -e 'node.save'` prints the AST for any snippet, which is the quickest way to write one.

**New cops use `severity: :refactor`.** This is the stability promise from the README: new rules alert but don't fail anyone's build. Cookstyle's binary passes `--fail-level C`, so `:refactor` offenses print without changing the exit code. A cop is only promoted to a higher severity during a major release.

### Helpers

Three mixins in `lib/rubocop/chef/` cover the common cookbook shapes:

- `RuboCop::Chef::CookbookHelpers` — `match_property_in_resource?` finds a property inside a resource block; `method_arg_ast_to_string` renders an argument back to source. This is the one you'll reach for most.
- `RuboCop::Chef::PlatformHelpers` — lists of valid platform and platform family values.
- `RuboCop::Chef::AutocorrectHelpers` — `expression_including_heredocs` returns a range that covers a node plus any heredoc bodies hanging off it, which plain `node.loc.expression` does not.

RuboCop's own `RangeHelp` is also widely used here, particularly `range_with_surrounding_space` when removing a line.

## Autocorrection

Add `extend AutoCorrector` and pass a block to `add_offense`:

```ruby
class UnnecessaryDependsChef14 < Base
  extend AutoCorrector
  include RangeHelp

  MSG = "Don't depend on cookbooks made obsolete by Chef Infra Client 14.0+..."
  RESTRICT_ON_SEND = [:depends].freeze

  def_node_matcher :legacy_depends?, <<-PATTERN
    (send nil? :depends (str {"build-essential" "chef_handler" "dmg"}) ... )
  PATTERN

  def on_send(node)
    legacy_depends?(node) do
      add_offense(node, severity: :refactor) do |corrector|
        corrector.remove(range_with_surrounding_space(range: node.loc.expression, side: :left))
      end
    end
  end
end
```

Autocorrection rewrites people's cookbooks unattended, so the bar is higher than for detection:

- A correction must be **safe under repetition**. RuboCop applies corrections in loops; if a second pass changes the file again, the cop will be reported as an infinite loop.
- When you can't produce a correct fix for every case the cop matches, **narrow the cop** rather than emitting a fix that's right most of the time.
- Removing a line usually needs `range_with_surrounding_space`, otherwise you leave a blank line behind.

## Version gating

If the corrected code requires a newer Chef Infra Client than the user runs, gate the cop:

```ruby
class LibarchiveFileResource < Base
  extend TargetChefVersion
  extend AutoCorrector

  minimum_target_chef_version '15.0'

  # MSG, RESTRICT_ON_SEND, matchers, and on_send as usual
end
```

With `TargetChefVersion: 14.0` in their `.rubocop.yml`, the cop won't run at all — no offense and no autocorrect. This is what lets people step a fleet from 15 to 18 one version at a time, and it's the reason a `Modernize` cop that removes a `depends` for a resource that shipped in Chef Infra 14 must declare `minimum_target_chef_version '14.0'`.

The default is unrestricted, so a cop with no declaration runs for everyone.

## Writing the spec

Specs mirror the cop path under `spec/`, carry the same license header, and pass `:config`:

```ruby
require 'spec_helper'

describe RuboCop::Cop::Chef::Correctness::CookbookUsesNodeSave, :config do
  it 'registers an offense when a cookbook uses node.save' do
    expect_offense(<<~RUBY)
      node.save
      ^^^^^^^^^ Don't use node.save to save partial node data to the Chef Infra Server mid-run...
    RUBY
  end

  it "doesn't register an offense when a cookbook uses another node method" do
    expect_no_offenses(<<~RUBY)
      node.environment
    RUBY
  end
end
```

**Every cop needs at least one `expect_no_offenses` example.** The positive case proves the cop fires; only the negative case proves it doesn't fire on code it shouldn't touch. For an autocorrecting cop, a false positive silently rewrites a working cookbook, which is the most expensive bug this project can ship. Cover the near-misses — the method with a similar name, the resource with a similar property, the string that starts the same way.

Other helpers available:

- `expect_correction` — assert the autocorrected output, after an `expect_offense`.
- `expect_no_corrections` — assert an offense is reported but nothing is rewritten.
- `target_chef_version(version)` — a `spec_helper.rb` helper that builds a config for testing version gating, used in a `let(:config)` block.
- `allow_invalid_ruby` — wraps a block so `expect_offense` won't raise on input that isn't valid Ruby, needed for cops that inspect non-Ruby files such as `Berksfile` or `.delivery/config.json`.

Run a single spec with `bundle exec rspec spec/rubocop/cop/chef/correctness/node_save_spec.rb`.

## The config entry

Every cop needs an entry in `config/cookstyle.yml`, in its department's section:

```yaml
Chef/Correctness/CookbookUsesNodeSave:
  Description: Don't use node.save to save partial node data to the Chef Infra Server mid-run.
  StyleGuide: 'chef_correctness_cookbookusesnodesave'
  Enabled: true
  VersionAdded: '5.1.0'
  Exclude:
    - '**/metadata.rb'
```

- `StyleGuide` is the docs.chef.io anchor: the full cop name downcased with `/` replaced by `_`.
- `VersionAdded` is the next Cookstyle release. Check `VERSION` and round up to the next minor.
- `Include`/`Exclude` restrict which files the cop runs against. **Set these.** A cop with neither runs against every file in a cookbook, which is both slow and a source of false positives — a `metadata.rb` cop has no business inspecting recipes.

`bundle exec rake validate_config` fails if a cop exists in `lib/` without a config entry.

## Before opening a PR

```bash
bundle exec rake spec            # the full suite, about a second
bundle exec rake style           # Cookstyle against itself
bundle exec rake validate_config # every cop is configured
```

Then commit with a DCO signoff — `git commit --signoff` — or the build will fail. See [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md#pull-requests) for labels and the release process.
