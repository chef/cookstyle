## Cookstyle 8.5.0

- Upgrade RuboCop to 1.80.2

## Cookstyle 8.4.0

- Upgrade RuboCop to 1.79.2
- Add new Chef/Correctness/EmptyResourceGuard cop

## Cookstyle 8.3.0

- Upgrade RuboCop to 1.79.1

## Cookstyle 8.2.1

- Upgrade RuboCop to 1.77.0
- Enable the following new cops:
  - Style/RedundantArrayFlatten
  - Lint/UselessOr
  - Lint/UselessDefaultValueArgument

## Cookstyle 8.1.4

- Upgrade RuboCop to 1.75.8 with bug fixes
- Fix incorrect links to the styleguide

## Cookstyle 8.1.3

- Upgrade RuboCop to 1.75.6 with bug fixes

## Cookstyle 8.1.2

- Upgrade RuboCop to 1.75.5 with bug fixes

## Cookstyle 8.1.1

- Upgrade RuboCop to 1.75.3 with bug fixes
- Remove extra gem dependencies that are no longer needed

## Cookstyle 8.0

### RuboCop 1.75.2

The RuboCop engine that powers Cookstyle has been updated to 1.75.2 with a HUGE number of under the hood improvements and autocorrection bug fixes.

### Updated default Ruby release

Cookstyle now defaults to Ruby 2.6, enabling new language features, while still helping users on legacy Chef Infra Client releases to upgrade their cookbooks.

### Newly enabled cops in Cookstyle

- Bundler/DuplicatedGroup
- Layout/LineContinuationSpacing
- Lint/DuplicateMagicComment
- Lint/DuplicateMatchPattern
- Lint/DuplicateSetElement
- Lint/HashNewWithKeywordArgumentsAsDefault
- Lint/MixedCaseRange:
- Lint/RedundantTypeConversion
- Lint/RequireRangeParentheses
- Lint/UnescapedBracketInRegexp
- Lint/UselessDefined
- Lint/UselessNumericOperation
- Style/ArrayFirstLast
- Style/ArrayIntersect
- Style/CombinableDefined
- Style/ComparableBetween
- Style/ConcatArrayLiterals
- Style/DigChain
- Style/DirEmpty
- Style/ExactRegexpMatch
- Style/FileEmpty
- Style/HashFetchChain
- Style/MagicCommentFormat
- Style/MapCompactWithConditionalBlock
- Style/MapIntoArray
- Style/MapToSet
- Style/MinMaxComparison
- Style/NestedFileDirname
- Style/RedundantArrayConstructor:
- Style/RedundantCurrentDirectoryInPath:
- Style/RedundantEach
- Style/RedundantFilterChain:
- Style/RedundantFormat
- Style/RedundantRegexpArgument
- Style/RedundantStringEscape
- Style/SendWithLiteralMethodName
- Style/YAMLFileRead

## Cookstyle 7.14

### RuboCop 1.17

The RuboCop engine that powers Cookstyle has been updated to 1.17.0. This new release improves autocorrection and resolves a large number of detection errors.

### InSpec Cops

Cookstyle now includes Chef InSpec specific Cops in the `InSpec/Deprecations` department. These new Chef InSpec cops help with the migration from InSpec `attributes` to `inputs`. We plan to add additional deprecation and correctness cops for InSpec in the future. If you have any ideas for InSpec cops you'd like to see added, please [request a new cop](https://github.com/chef/cookstyle/issues/new?assignees=&labels=Status%3A+Untriaged%2C+New+Cop+Proposal&template=NEW_COP_REQUEST.md).

#### InSpec/Deprecations/AttributeDefault

The `Chef/Deprecations/AttributeDefault` cop detects Chef InSpec profiles that pass the `default` option to `attribute` or `input` helpers instead of the newer `value` option.

`Enabled by default`: True

`Autocorrects`: False

#### InSpec/Deprecations/AttributeHelper

The `Chef/Deprecations/AttributeHelper` cop detects Chef InSpec profiles that use the deprecated `attribute` helper instead of the `input` helper.

`Enabled by default`: True

`Autocorrects`: False

## Cookstyle 7.6

## RuboCop 1.9.0

The RuboCop engine that powers Cookstyle has been updated to 1.9.0. This new release improves autocorrection and resolves a large number of detection errors.

### 1 New Ruby Cops

#### Lint/DeprecatedConstants

The `Lint/DeprecatedConstants` cop detects legacy constant values `TRUE`, `FALSE`, and `NIL` that were deprecated in Ruby 2.4 (Chef Infra Client 13).

## Cookstyle 7.5

## RuboCop 1.7.0

The RuboCop engine that powers Cookstyle has been updated to 1.7.0. This new release improves autocorrection and resolves several detection errors.

### Other Improvements

- The `Chef/RedundantCode/UnnecessaryNameProperty` has been improved to detect additional cases where an unnecessary name property is defined in a resource.

## Cookstyle 7.4

## RuboCop 1.6.1

The RuboCop engine that powers Cookstyle has been updated to 1.6.1. This new release enables autocorrection in several existing cops, improves messages when using incorrect department names in configuration files, and resolves several detection errors.

## Cookstyle 7.3

## RuboCop 1.5.0

RuboCop has been updated to 1.5.0, which includes bug fixes and improvements for many of RuboCop's built in Ruby cops.

### 2 New Chef Infra Cops

#### Chef/Deprecations/ChefSugarHelpers

The `Chef/Deprecations/ChefSugarHelpers` cop detects cookbooks that use helpers from the deprecated `chef-sugar` project that have not been moved into the Chef Infra Client itself. Chef Sugar functionality was mostly merged into Chef Infra Client, but we do not plan to move some helpers with limited or dated value.

##### Legacy Helpers

- vagrant_key?
- vagrant_domain?
- vagrant_user?
- require_chef_gem
- best_ip_for(node)
- nexus?
- ios_xr?
- ruby_20?
- ruby_19?
- includes_recipe?('foo::bar')
- wrlinux?
- dev_null
- nexentacore_platform?
- opensolaris_platform?
- nexentacore?
- opensolaris?

#### Chef/Deprecations/DeprecatedYumRepositoryActions

The `Chef/Deprecations/DeprecatedYumRepositoryActions` cop detects legacy `yum_repository` actions replaced with the release of Chef Infra Client 12.14 and the yum cookbook 3.0.

##### Legacy Actions

- :add -> :create
- :delete -> :remove

### Other Improvements

- The `Lint/SendWithMixinArgument` cop has been disabled as the correction necessary to resolve the warning is not clear.
- The `Chef/Modernize/RespondToProvides` now checks custom resources for `.respond_to?(:provides)`.
- The `Chef/Modernize/ActionMethodInResource` cop has been updated to skip HWRPs where it would cause errors in some releases of Chef Infra Client.
- Cookstyle now skips additional files when executing cops in order to speed up Cookstyle scan times.
- Fixed a failure running `Chef/Style/CommentSentenceSpacing`.
- The `Chef/Deprecations/DeprecatedChefSpecPlatform` cop has been updated to detect ChefSpec tests using macOS 10.13 and Debian 8 Fauxhai data, which is now deprecated.

## Cookstyle 7.2

### RuboCop 1.3.1

RuboCop has been updated to 1.3.1, which includes bug fixes and improvements for many of RuboCop's built in Ruby cops.

## Cookstyle 7.1

### RuboCop 1.2.0

RuboCop has been updated to 1.2.0, which includes bug fixes and improvements for many of RuboCop's built in Ruby cops.

### 2 New Chef Infra Cops

#### Chef/Deprecations/FoodcriticTesting

The `Chef/Deprecations/FoodcriticTesting` cop detects cookbooks with a Gemfile that requires Foodcritic or any code, such as a Rakefile/Guardfile, that requires the Foodcritic gem. Foodcritic is no longer supported and has been significantly eclipsed in functionality by Cookstyle. Any existing Rakefile or Guardfile tests for Foodcritic should be updated to use Cookstyle instead.

`Enabled by default`: True

`Autocorrects`: False

#### Chef/Deprecations/LibrarianChefSpec

The `Chef/Deprecations/LibrarianChefSpec` cop detects ChefSpec tests that require the legacy `chefspec/librarian` library. Librarian Chef is no longer supported and users should migrate to Berkshelf or Policyfiles.

`Enabled by default`: True

`Autocorrects`: True

### 1 New Ruby Cop

The `Style/CollectionCompact` cop detects code that removes `nil` values from Hashes or Arrays using a Ruby block when this can be done with the `compact` method instead.

`Examples:`

Overly complex nil removals:

```ruby
array.reject { |e| e.nil? }
array.select { |e| !e.nil? }
```

Simpler nil removal:

```ruby
array.compact
```

### Other Improvements

- The `Chef/Modernize/UseMultipackageInstalls` cop no longer fails if the `when` condition uses a Regex instead of a String.
- The `Chef/Modernize/UseMultipackageInstalls` cop detects overly complex arrays of package resources if the `when` condition contains code other than the package resources.

## Cookstyle 7.0

### New Cop Naming Format

Cookstyle 7.0 upgrades to the RuboCop 1.0 engine. This new release of RuboCop has enabled us to improve the naming scheme for Cookstyle cops. Previously all Cookstyle cops started with `Chef` and then included the description of what the department actually did such as `ChefDeprecations`, which was for deprecation cops. Cop names are now three parts instead of two so `ChefDeprecations/SomeCop` becomes `Chef/Deprecations/SomeCop`. Why the change? Using this format makes it much easier to enable just the Chef specific cops in Cookstyle without having to list each individual department. Now you can run `cookstyle --only Chef` to see just Chef Infra related cops without the additional few hundred Ruby specific cops provided by RuboCop. Cookstyle will automatically migrate any comments to the new department names, but anything in your .rubocop.yml will need to be updated manually.

#### New Name Mapping

- ChefCorrectness -> Chef/Correctness
- ChefDeprecations -> Chef/Deprecations
- ChefEffortless -> Chef/Effortless
- ChefModernize -> Chef/Modernize
- RedundantCode -> Chef/RedundantCode
- ChefSharing -> Chef/Sharing
- ChefStyle -> Chef/Style

## Cookstyle 6.21

### 2 New Chef Infra Cops

#### ChefCorrectness/OctalModeAsString

The `ChefCorrectness/OctalModeAsString` cop detects `mode` properties that incorrectly use a string to represent an octal value. We highly recommend using strings which contain a base 10 mode value, but even if you want to use octal values, they can't be passed as strings.

`Enabled by default`: True

`Autocorrects`: False

#### ChefDeprecations/UseYamlDump

The `ChefDeprecations/UseYamlDump` cop detects cookbooks that use the `.to_yaml` method. Chef Infra Client 16.5 introduced performance enhancements to Ruby library loading and due to the underlying implementation of Ruby's `.to_yaml` method, it does not automatically load the `yaml` library. We recommend using `YAML.dump()` instead, which is functionally equivalent, and also properly loads the `yaml` library.

`Enabled by default`: True

`Autocorrects`: True

## Cookstyle 6.20

### RuboCop 0.93.0

RuboCop has been updated to 0.93.0, which includes a large number of bug fixes and performance improvements when scanning large repositories.

### 1 New Ruby Cop

#### Lint/RedundantSafeNavigation

The `Lint/RedundantSafeNavigation` cop detects redundant save navigation operators in order to simplify code. For example `attrs&.respond_to?(:[])` can be simplified to just `attrs.respond_to?(:[])` because `respond_to?` will not error even if attrs is not defined.

`Enabled by default`: True

`Autocorrects`: True

## Cookstyle 6.19

### RuboCop 0.92.0

RuboCop has been updated to 0.92.0, which includes a large number of bug fixes to the built-in RuboCop cops that Cookstyle uses.

### 2 New Chef Infra Cops

#### ChefEffortless/ChefVaultUsed

The `ChefEffortless/ChefVaultUsed` cop detects cookbooks that use the Chef Vault helpers to access Chef Vault encrypted data bag secrets. Chef Vault is not compatible with the Chef Infra Effortless pattern and users will need to migrate to a different secrets storage system.

`Enabled by default`: False

`Autocorrects`: False

#### ChefEffortless/DependsChefVault

The `ChefEffortless/DependsChefVault` cop detects cookbooks that depend on the `chef-vault` cookbook. Chef Vault is not compatible with the Chef Infra Effortless pattern and users will need to migrate to a different secrets storage system.

`Enabled by default`: False

`Autocorrects`: False

### Other Improvements

- The performance of the `ChefStyle/CommentFormat` and `ChefCorrectness/IncorrectLibraryInjection` cops have been greatly improved.
- The `ChefModernize/RespondToInMetadata` cop now detects additional methods of gating metadata for legacy Chef Infra Client releases.

## Cookstyle 6.18

### RuboCop 0.91.0

RuboCop has been updated to 0.91.0, which includes a large number of bug fixes to the built-in RuboCop cops that Cookstyle uses as well as significant performance improvements.

### 2 New Chef Infra Cops

#### ChefCorrectness/LazyInResourceGuard

The `ChefCorrectness/LazyInResourceGuard` cop detects resources that use `only_if/not_if` conditionals where the Ruby code block is wrapped in `lazy {}`. All resource conditionals are always lazily evaluated (evaluated at runtime) so there is no need to wrap them in lazy and doing so results in failures.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefCorrectness/PropertyWithoutType

The `ChefCorrectness/PropertyWithoutType` cop detects properties or attributes in resources that don't declare their type such as Array, String, or Hash. Not including a type limits the built-in validation performed by the Chef Infra Client for all user inputs, and can cause difficult to troubleshoot failures.

`Enabled by default`: True

`Autocorrects`: No

### 12 New Ruby Cops

Several new built-in RuboCop cops have been enabled to help simplify Ruby code within Chef Infra cookbooks. We've chosen to enable these cops as they simplify cookbook code and they all support autocorrection.

#### Lint/RedundantRequireStatement

The `Lint/RedundantRequireStatement` cop detects code requiring several built-in Ruby libraries that are required out of the box by Ruby.

#### Style/Strip

The `Style/Strip` cop detects code that calls `'abc'.lstrip.rstrip` when `'abc'.strip` can be used instead.

#### Style/StderrPuts

The `Style/StderrPuts` cop detects code that calls `$stderr.puts('hello')` when `warn('hello')` can be used instead.

#### Style/Sample

The `Style/Sample` detects code that uses the `shuffle` method to sample data from an array when `sample` can be used instead.

#### Style/ReturnNil

The `Style/ReturnNil` cop detects methods that use `return nil` when `return` can be used instead as `nil` is implied.

#### Style/RedundantSortBy

The `Style/RedundantSortBy` cop detects code that calls `sort_by` with a block in ways that can be simplified to use just `sort` instead, without the need for a block.

#### Style/RedundantSort

The `Style/RedundantSort` cop detects code that calls `sort` in order to determine the minimum or maximum values when the `min` or `max` methods could be used instead.

#### Style/RedundantFileExtensionInRequire

The `Style/RedundantFileExtensionInRequire` cop detects code that requires libraries with their complete filenames when the `.rb` extension is not necessary.

#### Style/RedundantCondition

The `Style/RedundantCondition` cop detects complex ternary operators that can be reduced to simpler `x || y` type expressions.

#### Style/Encoding

The `Style/Encoding` cop detects `.rb` files that start with a `UTF-8` Ruby encoding comment. These comments are no longer necessary as Ruby now defaults to `UTF-8` as of Ruby 2.0 (Chef Infra Client 12).

#### Style/Dir

The `Style/Dir` cop detects code with complex methods of detecting the current file path, which can be simplified by using the built in `__dir__` method in Ruby.

#### Style/ExpandPathArguments

The `Style/ExpandPathArguments` cop detects code with overly complex `File.expand_path` usage that can be simplified.

### Other Improvements

- The `ChefModernize/RespondToCompileTime` cop has seen significant performance optimizations that will result in faster overall Cookstyle runtimes.

## Cookstyle 6.17

### 4 New Cops

#### ChefDeprecations/ChefShellout

The `ChefDeprecations/ChefShellout` cop detects the use of the `Chef::ShellOut` class, which was removed in Chef Infra Client 13. It will autocorrect all occurrences to instead use `Mixlib::ShellOut`, which is a drop-in replacement.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/ExecutePathProperty

The `ChefDeprecations/ExecutePathProperty` cop detects `execute` resources that use the `path` property, which was removed in Chef Infra Client 13. To set a path for use when executing, you should instead set the `PATH` via the `environment` property.

`Enabled by default`: True

`Autocorrects`: No

#### ChefDeprecations/ExecuteRelativeCreatesWithoutCwd

The `ChefDeprecations/ExecuteRelativeCreatesWithoutCwd` cop detects the usage of the `execute` resource with a relative path in the `creates` property and with no `cwd` property present. This condition will fail in Chef Infra Client 13 or later, and it never would have actually worked, so it was always failing code. You should either provide an absolute path to the `creates` property, or use a relative path with `creates` and specify the working directory with `cwd`.

`Enabled by default`: True

`Autocorrects`: No

#### ChefDeprecations/WindowsPackageInstallerTypeString

The `ChefDeprecations/WindowsPackageInstallerTypeString` cop detects the usage of the `windows_package` resource with a `installer_type` property value that is a String. In Chef Infra Client 13 or later, this property value must be a Symbol.

`Enabled by default`: True

`Autocorrects`: Yes

### Other Improvements

- The `ChefDeprecations/DeprecatedPlatformMethods` cop now detects the usage of `Chef::Platform.set`, which was removed in Chef Infra Client 13.
- Several minor performance and memory usage improvements were made to speed up Cookstyle scans.
- An error was resolved that would occur when using Cookstyle with the `rubocop-ast` gem, version 0.4.0 or later.

## Cookstyle 6.16

### RuboCop 0.90.0

RuboCop has been updated to 0.90.0, which includes a large number of improvements to the built-in RuboCop cops that Cookstyle uses.

### Autocorrection Performance Improvements

All Cookstyle Cops have been refactored to use a more performant plugin format added in a recent release of RuboCop. With this change many cops no longer have to detect issues twice in order to autocorrect, which allows for faster autocorrection with less memory usage.

### CookbooksDependsOnSelf is now a ChefDeprecations Cop

The `ChefCorrectness/CookbooksDependsOnSelf` cop has been moved to `ChefDeprecations/CookbooksDependsOnSelf` as a cookbook that depends on itself will fail with Chef Infra Client 13 or later.

## Cookstyle 6.15

### RuboCop 0.89.1

RuboCop has been updated to 0.89.1 which offers significant performance and autocorrection improvements to many Ruby cops that Cookstyle utilizes.

### New Ruby Cops Enabled

We have enabled many new built-in RuboCop cops that we believe are also useful in correcting Chef Infra cookbooks:

#### Lint/BinaryOperatorWithIdenticalOperands

The `Lint/BinaryOperatorWithIdenticalOperands` cop detects conditionals with duplicate checks. For example, `b == 0 && b == 0` which can be simplified to just `b == 0`

#### Lint/DuplicateElsifCondition

The `Lint/BinaryOperatorWithIdenticalOperands` cop detects conditions with duplicate `elsif` checks that can be removed.

#### Lint/DuplicateRescueException

The `Lint/BinaryOperatorWithIdenticalOperands` cop detects duplicate `rescue` statements in code that can be removed.

#### Lint/OutOfRangeRegexpRef

The `Lint/OutOfRangeRegexpRef` detects the use of regex captures that are outside of the range of possible capture groups within a regex statement. For example, `/(foo)bar/ =~ 'foobar'` has a single capture so `$2` is not a valid capture and will always return `nil`.

#### Style/ArrayCoercion

The `Style/ArrayCoercion` cop ensures a consistent method of coercing data types into Arrays. For example, this will autocorrect `foo = "some_string"; [foo]` into `foo = "some_string"; Array(foo)` and `[*paths]` into `Array(paths)` to make it more clear what is being done.

#### Style/BisectedAttrAccessor

The `Style/BisectedAttrAccessor` cop will detect classes that include both an `attr_reader` and `attr_writer` and combine them into a single `attr_accessor`.

#### Style/RedundantAssignment

The `Style/RedundantAssignment` cop detects methods that assign a value to a variable immediately before returning the variable. This assignment is not necessary and increases memory usage. Instead just return the value directly.

#### Style/SingleArgumentDig

The `Style/SingleArgumentDig` cop detects code that uses `.dig` to fetch a value from a Hash just one level deep. For example, this cop will autocorrect `{ key: 'value' }.dig(:key)` to just `{ key: 'value' }[:key]`

## Cookstyle 6.14

### 2 New Cops

#### ChefCorrectness/MacosUserdefaultsInvalidType

The `macos_userdefaults` resource prior to Chef Infra Client 16.3 would silently continue if invalid types were passed resulting in unexpected behavior. Valid values are `array`, `bool`, `dict`, `float`, `int`, and `string`. The `ChefCorrectness/MacosUserdefaultsInvalidType` will detect invalid types and autocorrect several common mistakes such as using `integer` instead of `int`.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/MacosUserdefaultsGlobalProperty

The `ChefDeprecations/MacosUserdefaultsGlobalProperty` cop detects the usage of the `global` property in the macos_userdefaults resource which was deprecated in Chef Infra Client 16.3. You can now omit the `domain` property to set global default values instead.

`Enabled by default`: True

`Autocorrects`: Yes

### Other Improvements

- `ChefCorrectness/InvalidPlatformFamilyHelper` will now autocorrect offenses.
- `ChefEffortless/CookbookUsesEnvironmments` has been renamed `ChefEffortless/CookbookUsesEnvironments`. Sticky MacBook keyboards are not fun.
- `ChefStyle/FileMode` now detects the `files_mode` property in `remote_directory` resources.
- Many styleguide links have been fixed to properly point to the docs in the Cookstyle repo.

## Cookstyle 6.13

### 5 New Cops

#### ChefCorrectness/InvalidDefaultAction

The `ChefCorrectness/InvalidDefaultAction` cop detects resources that set the `default_action` to a value that is not a Symbol, Array, or variable.

`Enabled by default`: True

`Autocorrects`: Yes

`Examples:`

Invalid default_action:

```ruby
default_action 'create'
```

#### ChefCorrectness/SupportsMustBeFloat

The `ChefCorrectness/SupportsMustBeFloat` cop detects `supports` metadata in the `metadata.rb` that specifies a platform version as an Integer and not a Float. Integer platform values will cause errors when the cookbook is uploaded to a Chef Infra Server.

`Enabled by default`: True

`Autocorrects`: Yes

`Examples:`

Supports using an Integer value for a platform version:

```ruby
supports 'redhat', '< 8'
```

#### ChefModernize/ActionMethodInResource

The `ChefModernize/ActionMethodInResource` detects resources that define resource actions as methods instead of using the custom resource language's `action :my_action` syntax.

`Enabled by default`: True

`Autocorrects`: Yes

`Examples:`

Resource using a method to define an action:

```ruby
def action_create
  # :create action code here
end
```

Autocorrected action:

```ruby
action :create do
  # :create action code here
end
```

#### ChefModernize/CronDFileOrTemplate

The `ChefModernize/CronDFileOrTemplate` cop detects cookbooks that use `cookbook_file`, `template`, or `file` resources to create cron jobs in `/etc/cron.d` instead of using the `cron_d` resource included in Chef Infra Client 14 and later.

`Enabled by default`: True

`Autocorrects`: No

`Examples:`

Using template to create a cron.d file:

```ruby
template '/etc/cron.d/backup' do
  source 'cron_backup_job.erb'
  owner 'root'
  group 'root'
  mode '644'
end
```

Using cron_d to create the same cron job:

```ruby
cron_d 'backup' do
  minute '1'
  hour '1'
  mailto 'sysadmins@example.com'
  command '/usr/local/bin/backup_script.sh'
end
```

#### ChefRedundantCode/DoubleCompileTime

The `ChefRedundantCode/DoubleCompileTime` cop detects resources that are set to run at compile time by using both the `compile_time` property and the `run_action` method, which do the same thing.

`Enabled by default`: True

`Autocorrects`: Yes

`Examples:`

Resource compile_time and run_action:

```ruby
chef_gem 'deep_merge' do
  action :nothing
  compile_time true
end.run_action(:install)
```

Autocorrected resource:

```ruby
chef_gem 'deep_merge' do
  action :install
  compile_time true
end
```

## Cookstyle 6.12

### 3 New Cops

#### ChefDeprecations/ChefDKGenerators

The `ChefDeprecations/ChefDKGenerators` cop detects custom cookbook generators for the `chef` CLI that utilize the legacy `ChefDK` classes and not `ChefCLI` classes.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/ChefHandlerRecipe

The `ChefDeprecations/ChefHandlerRecipe` cop detects cookbooks that include the deprecated `chef-handler::default` recipe. This recipe is empty and does not need to be included, and the `chef_handler` resource was merged directly into Chef Infra Client in 14.0.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/UseAutomaticResourceName

The `ChefDeprecations/UseAutomaticResourceName` cop detects resources that use the legacy `use_automatic_resource_name`, which was removed in Chef Infra Client 16.

`Enabled by default`: True

`Autocorrects`: No

### RuboCop 0.88

RuboCop has been updated to 0.88, which offers significant performance improvements to many Ruby cops that Cookstyle utilizes.

### Other Improvements

- `ChefModernize/ExecuteAptUpdate` has been updated to detect additional methods of executing `apt-get update`.

## Cookstyle 6.11

### 2 New Cops

#### ChefModernize/ConditionalUsingTest

The `ChefModernize/ConditionalUsingTest` cop detects resources that have an `only_if` or `not_if` conditional which uses `test -e /some/file` or `test -f /some/file` to determine if a file exists. Using the test command in a conditional requires shelling out and is slower and more resource intensive than using Ruby's built-in `File.exist?('/some/file')` helper.

`Enabled by default`: True

`Autocorrects`: Yes

`Examples:`

Conditional using test:

```ruby
execute 'apt-get update' do
  only_if 'test -f /usr/bin/apt'
end
```

Using File.exist instead:

```ruby
execute 'apt-get update' do
  only_if { ::File.exist?('/usr/bin/apt') }
end
```

#### ChefStyle/IncludeRecipeWithParentheses

The `ChefStyle/IncludeRecipeWithParentheses` cop detects unnecessary parentheses used with the `include_recipe` helper.

`Enabled by default`: True

`Autocorrects`: Yes

`Examples:`

Parentheses with include_recipe:

```ruby
include_recipe('my_recipe')
```

Bare include_recipe:

```ruby
include_recipe 'my_recipe'
```

### RuboCop 0.87.1

RuboCop has been updated to 0.87.1 which greatly expands the autocorrection capabilities of RuboCop and resolves many bugs in existing cops.

### Other Improvements

- The `ChefModernize/NodeInitPackage` cop has been improved to detect additional methods of testing a node for systemd support.
- The `ChefCorrectness/IncorrectLibraryInjection` cop has been improved to detect additional incorrect methods of injecting libraries helpers.

## Cookstyle 6.10

### 3 New Cops

#### ChefSharing/IncludeResourceExamples

The `ChefSharing/IncludeResourceExamples` cop detects resources that don't include examples. The `chef-resource-inspector` command displays resource examples and those examples can be used to automatically generate documentation.

`Enabled by default`: False

`Autocorrects`: No

#### ChefRedundantCode/MultiplePlatformChecks

The `ChefRedundantCode/MultiplePlatformChecks` cop detects usage of multiple `platform?` or `platform_family?` helpers that can be simplified by passing multiple values to a single helper.

`Enabled by default`: True

`Autocorrects`: Yes

`Examples:`

Conditional using multiple platform? helpers:

```ruby
if platform?('ubuntu') || platform?('centos')
  ...
end
```

Simplified conditional using a single platform? helper:

```ruby
if platform?('ubuntu', 'centos')
  ...
end
```

#### ChefRedundantCode/OhaiAttributeToString

The `ChefRedundantCode/OhaiAttributeToString` cop detects cookbooks that use `.to_s` on node attributes from Ohai that are already String type.

`Enabled by default`: True

`Autocorrects`: Yes

### Other Improvements

- RuboCop's built-in `Migration/DepartmentName` cop now suggests running cookstyle, not rubocop, to resolve cop naming deprecations.

## Cookstyle 6.9

### RuboCop 0.86

RuboCop has been updated to 0.86, which includes several bug fixes to prevent false positives and includes new autocorrection capabilities.

## Cookstyle 6.8

### Improvements for Chef Infra Client 16.2

Chef Infra Client 16.2 contains additional changes to how resource names are specified in order to avoid edge cases in resource naming. When setting the name of a custom resource `provides` should now be used instead of `resource_name`. If writing cookbooks that support Chef Infra Client < 16 you'll want to use both `provides` and `resource_name` to support all releases.

To support these changes we've made several updates to existing cops. The `ChefDeprecations/ResourceUsesOnlyResourceName` cop has been updated to add `provides` in addition to `resource_name` instead of replacing `resource_name` with `provides`. This change ensures cookbooks continue to function on Chef Infra Client less than 16. The `ChefDeprecations/ResourceWithoutNameOrProvides` cop has also been renamed to `ChefDeprecations/HWRPWithoutProvides` and improves detection of resources without `provides`. Both cops now better validate the contents of existing `provides` calls.

### RuboCop 0.85.1

RuboCop has been updated to 0.85.1, which includes several bug fixes to prevent false positives and improve autocorrection.

## Cookstyle 6.7

### Two New Cops

#### ChefDeprecations/ResourceUsesOnlyResourceName

The `ChefDeprecations/ResourceUsesOnlyResourceName` cop detects custom resources / LWRPs that define a `resource_name` without also using `provides`. Starting with Chef Infra Client 16, using `resource_name` without also using `provides` will result in resource failures. Use `provides` to change the name of the resource instead and omit `resource_name` entirely if it matches the name Chef Infra Client automatically assigns based on COOKBOOKNAME_FILENAME.

`Enabled by default`: True

`Autocorrects`: Yes

#### Lint/DeprecatedOpenSSLConstant

The `Lint/DeprecatedOpenSSLConstant` cop detects an upcoming deprecation in Ruby 3.0 that impacts the usage of OpenSSL constants. This deprecation is incredibly uncommon in Chef Infra cookbooks, but we wanted to make sure that any occurrences were corrected before Ruby 3.0 ships next year.

`Enabled by default`: True

`Autocorrects`: Yes

### RuboCop 0.85

The RuboCop engine that powers Cookstyle has been upgraded from 0.83 to 0.85. This new release resolves several issues that impacted detection and correction of code in cookbooks.

### Other Improvements

- The `Naming/AccessorMethodName` cop has been disabled. This cop did not significantly improve cookbook code and could not be autocorrected.
- The `ChefModernize/IncludingMixinShelloutInResources` cop now detects and corrects occurrences in legacy HWRP resources.

## Cookstyle 6.6

### 4 New Cops

#### ChefCorrectness/LazyEvalNodeAttributeDefaults

The `ChefCorrectness/LazyEvalNodeAttributeDefaults` cop detects custom resource properties using node attribute default values without wrapping those attributes with the `lazy` method. The `lazy` helper method ensures that node data is available at the time of resource execution.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefCorrectness/OpenSSLPasswordHelpers

The `ChefCorrectness/OpenSSLPasswordHelpers` cop detects the usage of the legacy `Opscode::OpenSSL::Password` class from the openssl cookbook. This class included a `secure_password` helper method that would generate a random password for use when a data bag or attribute was not present. The practice of generating passwords to be stored on the node is bad security practice as it exposes the password to anyone that can view the nodes, and deleting a node deletes the password. Passwords should be retrieved from a secure source for use in cookbooks.

`Enabled by default`: True

`Autocorrects`: No

#### ChefCorrectness/InvalidPlatformFamilyInCase

The `ChefCorrectness/InvalidPlatformFamilyInCase` cop detects cookbooks that use `case node['platform_family']` with an incorrect platform family name.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefCorrectness/InvalidPlatformInCase

The `ChefCorrectness/InvalidPlatformInCase` cop detects cookbooks that use `case node['platform']` with an incorrect platform name.

`Enabled by default`: True

`Autocorrects`: Yes

### Other Improvements

- The `ChefModernize/UseMultipackageInstalls` has been updated to detect additional forms of creating multiple package resources from an Array of package names.
- The `ChefDeprecations/IncludingXMLRubyRecipe` autocorrect has been updated to remove any inline conditionals.
- Added `oracle` as an invalid platform family for cops validating platform families.
- All cops now include links to documentation that can be enabled by running Cookstyle with the `--display-style-guide` command line flag.

## Cookstyle 6.5

### 2 New Cops

#### ChefModernize/ShellOutHelper

The `ChefModernize/ShellOutHelper` cop detects cookbooks that use `Mixlib::ShellOut.new('foo').run_command` instead of the `shell_out('foo')` helper included in Chef Infra Client 12.11 and later.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/Ruby27KeywordArgumentWarnings

The `ChefDeprecations/Ruby27KeywordArgumentWarnings` cop detects cookbooks that use the `shell_out` helper with shellout options within hash braces. Using braces in this helper will result in Ruby 2.7 deprecation warnings when running on Chef Infra Client 16 and later.

**With braces:**

```ruby
shell_out!('hostnamectl status', { returns: [0, 1] })
```

**Without braces:**

```ruby
shell_out!('hostnamectl status', returns: [0, 1])
```

`Enabled by default`: True

`Autocorrects`: Yes

### Other Improvements

- The `ChefDeprecations/DeprecatedChefSpecPlatform` cop has been updated to detect and correct additional legacy platform releases in ChefSpecs.

## Cookstyle 6.4

### RuboCop 0.83

The RuboCop engine that powers Cookstyle has been upgraded from 0.82 to 0.83. This new release resolves several issues that impacted detection and correction of code in cookbooks. The release also includes expanded autocorrection functionality, making it easier to fix your codebase without manual work.

### Other Improvements

- ChefModernize/FoodcriticComments is now enabled by default.
- ChefDeprecations/UserDeprecatedSupportsProperty now autocorrects invalid supports property values containing methods instead of hash keys.
- Files in `vendor` and `files` directories will now be ignored even if running Cookstyle against a larger repository of cookbooks.

## Cookstyle 6.3

### 2 New Cops

#### ChefModernize/RespondToCompileTime

The `ChefModernize/RespondToCompileTime` cop detects gating usage of the `compile_time` property in the `chef_gem` resource with `if respond_to?(:compile_time)`. The `compile_time` property was added in Chef Infra Client 12.1 and can safely be used without checking first.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/DeprecatedShelloutMethods

The `ChefDeprecations/DeprecatedShelloutMethods` cop detects deprecated `shell_out` helper methods that were removed in Chef Infra Client 15. These helpers were not widely used and were never publicly documented, but they are still occasionally found in cookbooks.

`Enabled by default`: True

`Autocorrects`: No

### RuboCop 0.82

The RuboCop engine that powers Cookstyle has been updated from 0.81.0 to 0.82.0. This update includes several important bug fixes that impacted cookbooks.

### Other Changes

- The `ChefModernize/RespondToProvides` cop now detects additional ways of gating the usage of the `provides` method in resources.
- The `TargetRubyVersion` configuration has been set back to Ruby 2.4 as support for Ruby 2.3 has been removed from RuboCop.

## Cookstyle 6.2

### 2 New Cops

#### ChefRedundantCode/UseCreateIfMissing

The `ChefRedundantCode/UseCreateIfMissing` cop detects file, cookbook_file, template, and remote_file resources that contain a not_if conditional check used to check that the file they manage is already present on disk. These complex conditionals can be removed by changing the action from `:create` to `:create_if_missing`.

Overly complex conditional check:

```ruby
file '/etc/some/config' do
  content 'value = true'
  not_if { ::File.exist?('/etc/some/config') }
end
```

:create_if_missing action usage:

```ruby
file '/etc/some/config' do
  content 'value = true'
  action :create_if_missing
end
```

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefStyle/NegatingOnlyIf

The `ChefStyle/NegatingOnlyIf` cop detects resources that use an only_if to run Ruby code that is then negated using Ruby's logical NOT operator (!). This conditional will be autocorrected to use not_if without the operator instead.

only_if with negated ruby:

```ruby
package 'legacy-sysv-deps' do
  only_if { !is_something_true? }
end
```

not_if without the negated ruby:

```ruby
package 'legacy-sysv-deps' do
  not_if { is_something_true? }
end
```

`Enabled by default`: True

`Autocorrects`: Yes

### RuboCop 0.81

The RuboCop engine that powers Cookstyle has been updated from 0.80.1 to 0.81.0 which includes a large number of fixes for bugs encountered during cookbook testing. This release also includes support for new Ruby syntax, introduced in Ruby 2.7, which will ship in Chef Infra Client 16.

### Other Changes

- The `ChefCorrectness/IncorrectLibraryInjection` no longer incorrectly autocorrects libraries that send to the `Chef::DSL::Resource` class.
- `TargetChefVersion` support in the .rubocop.yml config has been added to five of the `ChefDeprecation` cops. This will make it easier to move from legacy versions of Chef Infra Client without jumping right to the latest releases.
- `ChefModernize/WhyRunSupportedTrue` now detects a common typo form of the whyrun_supported? method

## Cookstyle 6.1

### 5 New Cops

#### ChefModernize/NodeRolesInclude

The `ChefModernize/NodeRolesInclude` cop detects cookbooks that use `node['roles'].include?('foo')` to see if a particular role has been applied to a node. Use the simpler `node.role?('foo')` helper instead.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/PowershellCookbookHelpers

The `ChefDeprecations/PowershellCookbookHelpers` cop detects cookbooks that use the deprecated `Powershell::VersionHelper.powershell_version?` helper from the `powershell` cookbook. Chef Infra Client provides information on the installed PowerShell release at `node['powershell']['version']` and Chef Infra Client 15.8 and later includes a new `powershell_version` method which should be used when possible.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefCorrectness/ConditionalRubyShellout

The `ChefCorrectness/ConditionalRubyShellout` cop detects resources that use unnecessary Ruby code in `not_if` and `only_if` conditionals to shellout when a string can be used to avoid additional complexity.

Shelling out with ruby:

```ruby
cookbook_file '/logs/foo/error.log' do
  only_if { system('wget https://www.bar.com/foobar.txt -O /dev/null') }
end
```

Shelling out without Ruby:

```ruby
cookbook_file '/logs/foo/error.log' do
  only_if 'wget https://www.bar.com/foobar.txt -O /dev/null'
end
```

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefSharing/IncludePropertyDescriptions

The `ChefSharing/IncludePropertyDescriptions` cop detects resource properties that don't include a description value. The `chef-resource-inspector` command displays the description value in resource properties and that description can be used to automatically generate documentation.

`Enabled by default`: False

`Autocorrects`: No

#### ChefSharing/IncludeResourceDescriptions

The `ChefSharing/IncludeResourceDescriptions` cop detects resources that don't include a description. The `chef-resource-inspector` command displays the description value in resources and that description can be used to automatically generate documentation.

`Enabled by default`: False

`Autocorrects`: No

### Other Changes

- `ChefModernize/PowershellInstallWindowsFeature` now correctly identifies the required Chef Infra Client release as 14.0 and later.
- The `WindowsVersionHelper` cop has been moved to the `ChefDeprecations` department and now includes autocorrection for each of the helpers it identifies.

## Cookstyle 6.0

### RuboCop 0.80.1 Engine

The RuboCop engine that powers Cookstyle has been updated from 0.75.1 to 0.80.1. This new engine includes hundreds of bug fixes and new features that will allow us to write even more advanced Cookstyle rules in the future. This release also renames many of RuboCop's built-in cops so if you have a complex rubocop.yml file that disables or enables rules, you may see warnings instructing you to update your config.

### ChefDeprecation Cops At Warning Level

All ChefDeprecation department cops now alert at `Warning` level instead of `Refactor`. This means that these cops will now result in Cookstyle exiting with a -1 exit code, which will cause failures in CI tests. ChefDeprecation cops are important to resolve and we believe this will the use of the latest Chef Infra coding standards.

### 9 New Cops

#### ChefDeprecations/DeprecatedWindowsVersionCheck

The `ChefDeprecations/DeprecatedWindowsVersionCheck` cop detects cookbooks that use the legacy `older_than_win_2012_or_8?` helper method. Chef Infra Client no longer supports Windows releases before 8 / 2012. Those releases are end of life so this check can be removed from cookbooks.

#### ChefDeprecations/ChefWindowsPlatformHelper

The `ChefDeprecations/ChefWindowsPlatformHelper` cop detects cookbooks that use the deprecated helper `Chef::Platform.windows?` to see if a system is running on Windows instead of using `platform?('windows')` or the new `windows?` helper.

#### ChefDeprecations/LogResourceNotifications

The `ChefDeprecations/LogResourceNotifications` cop detects notifications in the `log` resource. Beginning in Chef Infra Client 16, the log resource will no longer trigger an update, so these notifications will never fire. This will create problems for users who concatenate notifications from multiple resources into a single log resource so that those notifications only fire a single time. For example, many resource updates in your cookbook may require a service to restart, but a user may only want to trigger that service to restart once. Chef Infra Client 15.8 and later ships with a `notify_group` resource specifically for aggregating notifications in this way. This resource should be used instead.

##### Aggregating Notifications with a log resource

```ruby
template '/etc/foo' do
  source 'bar.erb'
  notifies :write, 'log[Aggregate notifications using a single log resource]', :immediately
end

log 'Aggregate notifications using a single log resource' do
  notifies :restart, 'service[foo]', :delayed
end
```

##### Aggregating Notifications with a notify_group resource

```ruby
template '/etc/foo' do
  source 'bar.erb'
  notifies :run, 'notify_group[Aggregate notifications using a single notify_group resource]', :immediately
end

notify_group 'Aggregate notifications using a single notify_group resource' do
  notifies :restart, 'service[foo]', :delayed
end
```

#### ChefDeprecations/ResourceWithoutNameOrProvides

The `ChefDeprecations/ResourceWithoutNameOrProvides` cop checks for legacy HWRP-style resources that do not set either `resource_name` or `provides`. These attributes are required by Chef Infra Client 16 and later.

#### ChefCorrectness/ChefApplicationFatal

The `ChefCorrectness/ChefApplicationFatal` cop detects cookbooks that use `Chef::Application.fatal!` to raise a failure during a Chef Infra Client run. When an error needs to be presented to a user, `raise` should be used instead as it provides the full stack trace to make debugging significantly easier.

#### ChefCorrectness/PowershellScriptDeleteFile

The `ChefCorrectness/PowershellScriptDeleteFile` cop detects using a `powershell_script` resource to delete a file. This should be accomplished by using the `file` resource with the `:delete` action instead. The `file` resource offers a simpler syntax and full idempotency.

#### ChefModernize/UseMultipackageInstalls

The `ChefModernize/UseMultipackageInstalls` cop detects cookbooks that use Ruby loops to install multiple packages using multiple package resources. When using a package provider that supports multi-package installs you can pass an array of packages to install to a single package resource. Passing multiple packages to a single package resource greatly simplifies the log output and is significantly faster. Multi-package installs are available for package installs using apt, dnf, yum, snap, dpkg, deb, and Chocolatey package management systems.

#### ChefModernize/ProvidesFromInitialize

The `ChefModernize/ProvidesFromInitialize` cop detects legacy HWRP-style resources that set the `provides` name in an `initialize` method instead of using the `provides` method in the resource DSL.

#### ChefModernize/DatabagHelpers

The `ChefModernize/DatabagHelpers` cop detects cookbooks that load data bags with `Chef::DataBagItem.load` or `Chef::EncryptedDataBagItem.load` instead of the simpler `data_bag_item` helper.

### Other Changes

- `ChefStyle/UnnecessaryOSCheck` is now enabled by default. This was disabled by mistake previously.
- `Lint/SendWithMixinArgument` is now enabled by default. This code simplifies how libraries are included in recipes and resources.
- `Naming/PredicateName` is no longer enabled by default. The naming of methods and names doesn't impact the execution of the code, and without autocorrection any warnings required significant effort to resolve.
- `Style/MultilineWhenThen` is now enabled by default. This cop simplifies case statements.
- `Style/HashEachMethod` is now enabled by default. This cop detects and autocorrects overly complex code against hashes that can be simplified.
- `ChefRedundant/UnnecessaryNameProperty` now detects unnecessary :Name attributes as well as properties.
- `ChefModernize/DefaultActionFromInitialize` has been improved to detect more forms of default actions set in initializers.
- `ChefCorrectness/DnfPackageAllowDowngrades` now supports autocorrection.
- `ChefModernize/WindowsRegistryUAC` now detects additional registry key forms used to set UAC settings.
- `ChefModernize/PowerShellGuardInterpreter` now also detects if the PowerShell guard is set in `batch` resources

## Cookstyle 5.22

### 4 New Cops

#### ChefModernize/NodeInitPackage

The `ChefModernize/NodeInitPackage` cop detects cookbooks that detect the `systemd` init system by parsing the content of `/proc/1/comm`. Chef Infra Client 12.0 and later include a `node['init_package']` attribute, which should be used instead.

#### ChefDeprecations/WindowsFeatureServermanagercmd

The `ChefDeprecations/WindowsFeatureServermanagercmd` cop detects `windows_feature` resources that set the `install_method` property to `:servermanagercmd`. The [windows_feature](https://docs.chef.io/resources/windows_feature/) resource no longer supports the legacy `Server Manager` command in Windows. Use `:windows_feature_dism` or `:windows_feature_powershell` instead.

#### ChefModernize/WindowsRegistryUAC

The `ChefModernize/WindowsRegistryUAC` resource detects the usage of the `registry_key` resource to set values in the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System` key in order to control UAC behavior in Windows. Chef Infra Client 15.0+ ships with a [windows_uac](https://docs.chef.io/resources/windows_uac/) resource that should be used instead.

#### ChefModernize/UseRequireRelative

The `ChefModernize/UseRequireRelative` cop detects cookbooks that use overly complex `require` statements with `File.expand_path` and `__FILE__`. These can be simplified by using `require_relative` instead.

### Other fixes and changes

- Updated `ChefStyle/TrueClassFalseClassResourceProperties` to no longer detect `TrueClass`/`FalseClass` in resource attributes where these are required.
- Updated `ChefModernize/ExecuteAptUpdate` to detect additional execute resources running `apt-get update` as well as resources notifying one of these execute resources.
- Disabled RuboCop's `Naming/MethodName` and `Naming/VariableName` cops since these can't be autocorrected and don't impact Chef Infra Client.

## Cookstyle 5.21

### 4 New Cops

#### ChefStyle/UnnecessaryOSCheck

The `ChefStyle/UnnecessaryOSCheck` cop checks cookbooks that use `node['os']` to check the operating system of a node, when they could instead use the `platform_family?()` helper. All values of `os` from Ohai match one-to-one with `platform_family` values, except for `linux` which has no single equivalent `platform_family`.

#### ChefModernize/SimplifyAptPpaSetup

The `ChefModernize/SimplifyAptPpaSetup` cop detects `apt_repository` resources that setup Ubuntu PPAs by using their full URL. For example, `http://ppa.launchpad.net/webupd8team/atom/ubuntu` can be simplified to just `ppa:webupd8team/atom`.

#### ChefRedundantCode/StringPropertyWithNilDefault

The `ChefRedundantCode/StringPropertyWithNilDefault` cop detects String type resource properties that set their default value to `nil`. All String type properties default to `nil` so this does not need to be set.

#### ChefRedundantCode/PropertySplatRegex

The `ChefRedundantCode/PropertySplatRegex` cop detects String type resource properties that validate their input with a regex of `/.*/`. This regex will match on any String value and is not necessary.

### Other fixes and changes

- `ChefDeprecations/IncludingYumDNFCompatRecipe` will now remove any inline conditionals around the `include_recipe` statement during autocorrection so that it does not leave behind invalid Ruby.
- `ChefDeprecations/WindowsTaskChangeAction` will no longer fail when the action value is not a String type value.
- `ChefSharing/InvalidLicenseString` will not autocorrect `apache v2` to `Apache-2.0`.
- `Layout/EndAlignment` and `Layout/DefEndAlignment` now have autocorrection enabled to eliminate the need for manually fixing indentation in cookbooks.
- `ChefStyle/UsePlatformHelpers` now detects and autocorrects `node['platform'].eql?()` usage.
- `Style/ModuleFunction` cop has been disabled because this caused library helpers to fail to load.
- All metadata cops now properly autocorrect legacy metadata that included HEREDOCs.
- The `TargetRubyVersion` is now set to 2.3 to match the version of Ruby that shipped in Chef Infra Client 12. This config value is used to enable/disable cops and autocorrection that may break Ruby code in these older Chef Infra Client releases. If you are on a later release of Chef Infra Client, you can set this value to Ruby 2.6 to enable additional cops and autocorrection.

## Cookstyle 5.20

### 1 New Cop

#### ChefDeprecations/DeprecatedChefSpecPlatform

The `ChefDeprecations/DeprecatedChefSpecPlatform` cop detects platforms in ChefSpec tests that have been deprecated in the Fauxhai / ChefSpec projects. Specifying deprecated platforms will create errors in ChefSpec because the mock Ohai data cannot be loaded to emulate a full Chef Infra Client run.

Platforms are deprecated from the Fauxhai project from time to time to prevent the Fauxhai package size from becoming too large. To avoid specifying deprecated platforms, use the newer platform matching functionality in ChefSpec. Previously you needed to specify the exact platform release when writing specs, but now ChefSpec will load the latest version if you skip the version number, or you can provide the major release and let ChefSpec do the rest.

`Examples`

ChefSpec calling a deprecated release of Debian 8:

```ruby
let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'debian', version: '8.2') }
```

ChefSpec calling the latest minor version of Debian 8 instead:

```ruby
let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'debian', version: '8') }
```

ChefSpec calling using the latest major.minor version of Debian instead:

```ruby
let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'debian') }
```

### Other fixes and changes

- The `ChefModernize/ExecuteSysctl` cop will now detect `execute` resources that call sysctl using the full path to the binary.
- The `ChefModernize/LibarchiveFileResource` resource will now replace the `libarchive_file` resource with Chef Infra Client's built-in `archive_file` resource.
- The `ChefStyle/UnnecessaryPlatformCaseStatement` cop will no longer attempt to autocorrect empty case statements.

## Cookstyle 5.19

### 2 New Cops

#### ChefRedundantCode/GroupingMetadata

The `ChefRedundantCode/GroupingMetadata` cop removes the legacy `grouping` metadata from the metadata.rb file. This metadata was never consumed by any Chef Infra services and does not need to be defined.

#### ChefStyle/OverlyComplexSupportsDependsMetadata

The `ChefStyle/OverlyComplexSupportsDependsMetadata` cop cleans up overly complex methods of declaring `supports` or `depends` metadata via an array. This rule will detect and correct the array or each form of declaring this metadata when there are fewer than three items.

**Overly complex metadata:**

```ruby
%w(windows apt).each do |cb|
  depends cb
end
```

**Simpler form:**

```ruby
depends 'apt'
depends 'windows'
```

### Other fixes and changes

- Various cops that remove legacy code no longer leave behind empty lines when autocorrecting.
- `ChefRedundantCode/LongDescriptionMetadata` now properly autocorrects when `long_description` uses a here document (heredoc).
- `ChefDeprecations/UserDeprecatedSupportsProperty` no longer fails to autocorrect when the supports hash uses Ruby 1.8 hash rocket syntax.
- `ChefStyle/FileMode` now autocorrects file modes using single quotes instead of double quotes.
- `ChefSharing/InvalidLicenseString` now autocorrects `UNLICENSED` to `all rights reserved`.
- `ChefModernize/AllowedActionsFromInitialize` no longer alerts when appending into an existing `@allowed_actions` variable.

## Cookstyle 5.18

### 2 New Cops

#### ChefModernize/ResourceForcingCompileTime

The `ChefModernize/ResourceForcingCompileTime` cop detects `hostname`, `build_essential`, `chef_gem`, and `ohai_hint` resources that are being set to run at compile-time by forcing an action on the resource block. These resources include `compile-time` properties which should be set to force the resources to run at compile-time.

#### ChefModernize/ExecuteSysctl

The `ChefModernize/ExecuteSysctl` detects the usage of `execute` to load sysctl values. Chef Infra Client 14.0+ includes the `sysctl` resource which should be used to idempotently add or remove sysctl values without the need for chaining `file` and ``execute`` resources.

### Other fixes and changes

- The `vendor` and `files` directories in cookbooks are now better excluded when running cookstyle against a mono-repo or other collection of multiple cookbooks.
- The `ChefRedundantCode/PropertyWithRequiredAndDefault` and `ChefStyle/TrueClassFalseClassResourceProperties` cops now check resource attributes in addition to properties.
- The `ChefRedundantCode/PropertyWithRequiredAndDefault` cop now supports autocorrection by removing unnecessary default values from the property.

## Cookstyle 5.17

### 3 New Cops

#### ChefModernize/DslIncludeInResource

The `ChefModernize/DslIncludeInResource` cop detects resources and providers that include either the `Chef::DSL::Recipe` or `Chef::DSL::IncludeRecipe` classes. Starting with Chef Infra Client 12.4+ this is done automatically for each resource and provider.

#### ChefRedundantCode/AptRepositoryNotifiesAptUpdate

The `ChefRedundantCode/AptRepositoryNotifiesAptUpdate` cop detects `apt_repository` resources that notify an `execute` resource to run `apt-get update`. Updating apt cache is performed automatically when the `apt_repository` makes any updates to the repository config and doesn't need to be performed again afterward.

#### ChefRedundantCode/AptRepositoryDistributionDefault

The `ChefRedundantCode/AptRepositoryDistributionDefault` cop detects `apt_repository` resources that set the `distribution` property to `node['lsb']['codename']` which is the default and does not need to be set in cookbook code.

### Other fixes and changes

- The `ChefModernize/IncludingMixinShelloutInResources` cop now also detects resources that require `chef/mixin/powershell_out` or include `Chef::Mixin::PowershellOut` as these are both performed by default in Chef Infra Client 12.4+
- The `ChefCorrectness/InvalidPlatformMetadata` now analyzes `support` metadata that is defined with an array and a loop in `metadata.rb`

## Cookstyle 5.16

### New TargetChefVersion Configuration

Cookstyle now includes a new top-level configuration option `TargetChefVersion`. This new configuration option works similarly to RuboCop's `TargetRubyVersion` config option and allows you to specify a Chef Infra version that you want to target in your Cookstyle analysis. This prevents Cookstyle from autocorrecting cookbook code in a way that would make your cookbook incompatible with your desired Chef Infra Client version. It also makes it easier to perform staged upgrades of the Chef Infra Client by allowing you to step the `TargetChefVersion` one major version at a time.

Example .rubocop.yml config specifying a TargetChefVersion of 14.0:

```yaml
AllCops:
  TargetChefVersion: 14.0
```

### 14 New Cops

#### ChefStyle/UnnecessaryPlatformCaseStatement

The `ChefStyle/UnnecessaryPlatformCaseStatement` cop detects a case statement against the value `node['platform']` or `node['platform_family']` that includes just a single when condition. Instead of using a case statement in this scenario the simpler `platform?` or `platform_family?` helpers should be used. Additionally, if this cop detects a when condition that has just a single line, it will autocorrect the case statement to be an inline conditional. See the examples below for a sample:

`Enabled by default`: True

`Autocorrects`: Yes

***Single condition case statement:***

```ruby
case node['platform']
when 'ubuntu'
  log "We're on Ubuntu"
  apt_update
end
```

Autocorrected code:

```ruby
include_recipe 'yum' if platform_family?('rhel)
end
```

***Single condition case statement with a single line:***

```ruby
if platform?('ubuntu')
  log "We're on Ubuntu"
  apt_update
end
```

Autocorrected code:

```ruby
include_recipe 'yum' if platform_family?('rhel)
end
```

#### ChefStyle/ImmediateNotificationTiming

The `ChefStyle/ImmediateNotificationTiming` cop detects the usage of the `:immediate` notification timing instead of `:immediately`. The two values result in the same notification, but `:immediately` is the documented form and should be used for consistency.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefStyle/TrueClassFalseClassResourceProperties

The `ChefStyle/TrueClassFalseClassResourceProperties` cop detects resources that set the allowed types to TrueClass and FalseClass instead of the simpler true and false. TrueClass and FalseClass are technically the correct value as they are Ruby types, but we believe using true and false here is significantly simpler for those reading and writing resources.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefCorrectness/InvalidNotificationTiming

The `ChefCorrectness/InvalidNotificationTiming` cop will detect a resource that notifies with timing other than `:before`, `:immediate`, `:immediately`, or ``:delayed``.

`Enabled by default`: True

`Autocorrects`: No

#### ChefCorrectness/MalformedPlatformValueForPlatformHelper

The `ChefCorrectness/MalformedPlatformValueForPlatformHelper` detects incorrect usage of the `value_for_platform()` helper. The `value_for_platform()` helper requires that additional information is passed that is not required by the `value_for_platform_family()` helper. These two formats are often confused. The `value_for_platform()` helper takes a hash of platforms where each platform has a hash of potential platform values or a `default` key. This cop detects if a hash of platforms is passed incorrectly or if a hash of platform versions or a default value is not included.

`Enabled by default`: True

`Autocorrects`: No

***Helper usage without the platform version hash***

```ruby
value_for_platform(
  %w(redhat oracle) => 'baz'
)
```

***Helper usage with the platform version hash***

```ruby
value_for_platform(
  %w(redhat oracle) => {
    '5' => 'foo',
    '6' => 'bar',
    'default' => 'baz',
  }
)
```

#### ChefCorrectness/DnfPackageAllowDowngrades

The `ChefCorrectness/DnfPackageAllowDowngrades` cop detects the usage of the `dnf_package` resource with the unsupported `allow_downgrades` property set.

`Enabled by default`: True

`Autocorrects`: No

#### ChefDeprecations/RubyBlockCreateAction

The `ChefRedundantCode/RubyBlockCreateAction` cop detects `ruby_block` resources that use the legacy `:create` action instead of the newer `:run` action.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/DeprecatedPlatformMethods

The `ChefDeprecations/DeprecatedPlatformMethods` cop detects the usage of the legacy `Chef::Platform` methods `provider_for_resource`, `find_provider`, and `find_provider_for_node`, which were removed in Chef Infra Client 13.

`Enabled by default`: True

`Autocorrects`: No

***Legacy Chef::Platform methods***

```ruby
resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
provider = Chef::Platform.provider_for_resource(resource, :create)

resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
provider = Chef::Platform.find_provider("ubuntu", "16.04", resource)

resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
provider = Chef::Platform.find_provider_for_node(node, resource)
```

#### ChefRedundantCode/SensitivePropertyInResource

The `ChefRedundantCode/SensitivePropertyInResource` cop detects resources that default a `sensitive` property with a default value of `false`. Chef Infra defines this same property/default combination on all resources, so this code is not necessary.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefRedundantCode/UnnecessaryDesiredState

The `ChefRedundantCode/UnnecessaryDesiredState` cop detects resources that set `desired_state: true` on a property. `desired_state: true` is the default for all properties and does not need to be specified.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefModernize/FoodcriticComments

The `ChefModernize/FoodcriticComments` cop will remove any # ~FCXXX code comments in your cookbook. These comments were used to disable Foodcritic rules from alerting and are no longer necessary if you rely on Cookstyle for all cookbook linting. This cop is currently disabled by default, but will be enabled by default at a future date.

`Enabled by default`: False

`Autocorrects`: Yes

#### ChefModernize/ExecuteScExe

The `ChefModernize/ExecuteScExe` resource detects cookbooks that use the `execute` resource to run `sc.exe` to manage Windows services. Since Chef Infra Client 14.0, the `windows_service` resource has included the `:create`, `:delete`, and `:configure` actions for idempotently managing services.

`Enabled by default`: False

`Autocorrects`: No

#### ChefModernize/WindowsScResource

The `ChefModernize/ExecuteScExe` resource detects cookbooks that use the `sc_windows` resource from the `sc` cookbook to manage Windows services. Since Chef Infra Client 14.0, the `windows_service` resource has included the `:create`, `:delete`, and `:configure` actions that manage services without the need for additional dependencies.

`Enabled by default`: False

`Autocorrects`: No

#### ChefModernize/ExecuteSleep

The `ChefModernize/ExecuteSleep` cop detects cookbooks that use either `execute` or `bash` resources to run the sleep command. Chef Infra Client 15.5 and later include the `chef_sleep` resource which should be used to sleep during the Chef Infra Client run without the need for shelling out.

`Enabled by default`: False

`Autocorrects`: No

### Other fixes and changes

- The list of files that Cookstyle checks for offenses has been updated to improve the time it takes to scan a large repository.
- The `ChefCorrectness/NotifiesActionNotSymbol`, `ChefCorrectness/ScopedFileExist`, and `ChefDeprecations/LegacyNotifySyntax` cops will now also check subscriptions in resources.
- The `match_property_in_resource?` helper now accepts an array of properties to return from a resource.
- The `ChefDeprecations/NamePropertyWithDefaultValue` cop now autocorrects offenses by removing the unused `default` value.
- All existing cops that checked properties within resources have been updated to also check `attributes` in LWRP style resources.
- The `ChefStyle/UsePlatformHelpers` cop now detects and autocorrects platform checks in the form of `%w(rhel suse).include?(node['platform_family'])` or `%w(ubuntu amazon).include?(node['platform'])`

## Cookstyle 5.15

### New ChefSharing and ChefRedundantCode Departments

Cookstyle 5.15 adds two new Chef cop departments and moves a large number of existing cops into more appropriate departments. Our goal is to have clearly defined cop departments that can be enabled or disabled to detect particular conditions in your cookbooks. Cops in the new ChefSharing department are focused around sharing cookbooks internally or on the public Supermarket. This includes things like ensuring proper license strings and complete metadata. Cops in the ChefRedundantCode category detect and correct unnecessary cookbook code. Anything detected by ChefRedundantCode cops can be removed regardless of the Chef Infra Client release you run in your infrastructure, so these are always safe to run.

With the addition of these new departments, we've moved many cops out of the ChefCorrectness department. Going forward only cops that detect code that may fail a Chef Infra Client run or cause it to behave incorrectly will be included in this category. We hope that ChefCorrectness along with ChefDeprecations are used in most cookbook CI pipelines.

#### Moved Cops

- ChefModernize/CustomResourceWithAllowedActions -> ChefRedundantCode/CustomResourceWithAllowedActions
- ChefCorrectness/InsecureCookbookURL -> ChefSharing/InsecureCookbookURL
- ChefCorrectness/InvalidLicenseString -> ChefSharing/InvalidLicenseString
- ChefCorrectness/DefaultMetadataMaintainer -> ChefSharing/DefaultMetadataMaintainer
- ChefCorrectness/EmptyMetadataField -> ChefSharing/EmptyMetadataField
- ChefCorrectness/PropertyWithRequiredAndDefault -> ChefRedundantCode/PropertyWithRequiredAndDefault
- ChefCorrectness/NamePropertyIsRequired -> ChefRedundantCode/NamePropertyIsRequired
- ChefCorrectness/UnnecessaryNameProperty -> ChefRedundantCode/UnnecessaryNameProperty
- ChefCorrectness/ResourceWithNothingAction -> ChefRedundantCode/ResourceWithNothingAction
- ChefCorrectness/IncludingOhaiDefaultRecipe -> ChefModernize/IncludingOhaiDefaultRecipe
- ChefCorrectness/PropertyWithNameAttribute -> ChefModernize/ PropertyWithNameAttribute
- ChefDeprecations/RecipeMetadata -> ChefRedundantCode/RecipeMetadata
- ChefDeprecations/LongDescriptionMetadata  -> ChefRedundantCode/LongDescriptionMetadata
- ChefDeprecations/AttributeMetadata -> ChefRedundantCode/AttributeMetadata
- ChefDeprecations/ReplacesMetadata -> ChefRedundantCode/ReplacesMetadata
- ChefDeprecations/ProvidesMetadata -> ChefRedundantCode/ProvidesMetadata
- ChefDeprecations/SuggestsMetadata -> ChefRedundantCode/SuggestsMetadata
- ChefDeprecations/ConflictsMetadata -> ChefRedundantCode/ConflictsMetadata

### 6 New Chef Cops

#### ChefModernize/AllowedActionsFromInitialize

The `ChefModernize/AllowedActionsFromInitialize` cop detects cookbooks that set either `@allowed_actions` or `@actions` variables in the initialize method of legacy `HWRP` style resources. This cop updates those resources to use the `allowed_actions` method instead.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefCorrectness/InvalidPlatformHelper

The `ChefCorrectness/InvalidPlatformHelper` cop detects invalid platforms passed to the `platform?` helper.

`Enabled by default`: True

`Autocorrects`: No

#### ChefCorrectness/InvalidPlatformFamilyHelper

The `ChefCorrectness/InvalidPlatformFamilyHelper` cop detects invalid platform families passed to the `platform_family?` helper.

`Enabled by default`: True

`Autocorrects`: No

#### ChefCorrectness/ScopedFileExist

The `ChefCorrectness/ScopedFileExist` cop detects when using `File.exist?` in a resource conditional instead of `::File.exist?`.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefCorrectness/InvalidPlatformValueForPlatformFamilyHelper

The `ChefCorrectness/InvalidPlatformValueForPlatformFamilyHelper` cop detects when invalid platform families are passed to the `value_for_platform_family` helper.

`Enabled by default`: True

`Autocorrects`: No

#### ChefCorrectness/InvalidPlatformValueForPlatformHelper

The `ChefCorrectness/InvalidPlatformValueForPlatformHelper` cop detects when invalid platforms are passed to the `value_for_platform` helper.

`Enabled by default`: True

`Autocorrects`: No

### Other fixes and changes

- ChefModernize/LegacyBerksfileSource now detects the usage of `site :opscode` in a `Berksfile`
- ChefModernize/DefaultActionFromInitialize now detects `@default_action` in the `initialize` method
- ChefCorrectness/InvalidPlatformMetadata now detects additional invalid platforms
- ChefRedundant/CustomResourceWithAllowedActions no longer incorrectly removes `actions` or `allowed_actions` calls from legacy LWRP style resources

## Cookstyle 5.14

### 2 New Chef Cops

#### ChefModernize/ChefGemNokogiri

The `ChefModernize/ChefGemNokogiri` cop detects cookbooks that use `chef_gem` to install `nokogiri` into the Chef Infra Client's Ruby installation. The nokogiri gem is built into Chef Infra Client 12 and later so this is no longer necessary.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/ChefRewind

The `ChefDeprecations/ChefRewind` cop detects the usage of the deprecated `chef-rewind` gem and updates code to instead use the built-in `edit_resource` and `delete_resource` methods.

`Enabled by default`: True

`Autocorrects`: Yes

### Other fixes and changes

- The `ChefDeprecations/UsesRunCommandHelper` cop has been improved to detect more cases of legacy run_command usage.
- The `ChefModernize/UnnecessaryMixlibShelloutRequire` cop has been improved to better describe when this change was made in Chef Infra Client.

## Cookstyle 5.13

### 3 New Chef Cops

#### ChefDeprecations/LegacyNotifySyntax

The `ChefDeprecations/LegacyNotifySyntax` cop detects the legacy notification syntax in resources. The newer notification method supports notifying resources that occur later in the recipe and should be used instead.

Legacy notification syntax:

```ruby
notifies :restart, resources(service: 'apache')
```

New notification syntax:

```ruby
notifies :restart, 'service[apache]'
```

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/NodeSetWithoutLevel

The `ChefDeprecations/NodeSetWithoutLevel` cop detects recipes and resources that set node attributes without specifying the precedence level required by Chef Infra Client 11 and later.

Setting node attributes without a precedence level:

```ruby
node['foo']['bar'] = 1
node['foo']['bar'] << 1
node['foo']['bar'] += 1
node['foo']['bar'] -= 1
```

Setting node attributes with a precedence level of override:

```ruby
node.override['foo']['bar'] = 1
node.override['foo']['bar'] << 1
node.override['foo']['bar'] += 1
node.override['foo']['bar'] -= 1
```

`Enabled by default`: True

`Autocorrects`: No

#### ChefModernize/EmptyResourceInitializeMethod

The `ChefModernize/EmptyResourceInitializeMethod` cop detects empty `initialize` methods in resources and providers. These methods are usually leftover from refactoring older HWRP-style resources into simpler custom resources and they can be removed.

`Enabled by default`: True

`Autocorrects`: Yes

### Other fixes and changes

- The JSON output formatter now exposes offenses that could be auto-corrected with a new `correctable` field in the hash.
- The `ChefModernize/DefaultActionFromInitialize` cop will no longer insert a `default_action` into the resource if one already exists.

## Cookstyle 5.12

### 8 New Chef Cops

### ChefModernize/UnnecessaryMixlibShelloutRequire

The `ChefModernize/UnnecessaryMixlibShelloutRequire` cop detects providers or resources that include `require 'mixlib/shellout`. Chef Infra Client automatically includes the mixlib-shellout library so this require statement can be removed.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/Cheffile

The `ChefDeprecations/Cheffile` cop will detect a `Cheffile` in cookbooks. `librarian-chef` uses this file to solve dependencies, but the librarian-chef project is no longer maintained. Users should handle dependency solving with Chef Infra Policyfiles or a Berkshelf Berksfile.

`Enabled by default`: True

`Autocorrects`: No

#### ChefEffortless/Berksfile

The `ChefEffortless/Berksfile` cop is an optional cop for detecting the use of Berkshelf's Berksfiles for cookbook dependency solving. This will help users identify cookbooks that still need to be migrated to Policyfiles before moving to the Effortless pattern.

`Enabled by default`: False

`Autocorrects`: No

#### ChefDeprecations/NodeDeepFetch

The `ChefDeprecations/NodeDeepFetch` cop detects the `node.deep_fetch` method which been deprecated in Chef-Sugar. Chef Infra Client's built-in `node.read` API should be used instead.

`Enabled by default`: True

`Autocorrects`: No

#### ChefModernize/IfProvidesDefaultAction

The `ChefModernize/IfProvidesDefaultAction` cop detects the usage of legacy `if defined?(default_action)` Chef Infra resources. The `default_action` method was added to chef-client in 0.10.8, so it is no longer necessary to conditionally call that method using `if defined?`.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefStyle/DefaultCopyrightComments

The `ChefStyle/DefaultCopyrightComments` cop detects cookbook copyright comment headers that still include the default NAME / ORGANIZATION information that `chef generate cookbook` creates. These headers should be updated with the names of the actual author or organization responsible for the cookbook.

`Enabled by default`: True

`Autocorrects`: No

#### ChefModernize/ZipfileResource

The `ChefModernize/ZipfileResource` cop detects the usage of the zipfile resource from the zipfile cookbook. Use the archive_file resource built into Chef Infra Client 15+ instead.

`Enabled by default`: True

`Autocorrects`: No

#### ChefCorrectness/ResourceWithNothingAction

The `ChefCorrectness/ResourceWithNothingAction` cop detects a resource or provider that defines its own :nothing action. There is no need to define a :nothing action in your resource as Chef Infra Client provides the :nothing action by default for every resource.

`Enabled by default`: True

`Autocorrects`: Yes

### Cookstyle Comments in Code

You can now use `cookstyle` specific comments in your cookbook code to enable or disable cops instead of the standard `rubocop` comments. We think that it will be easier to understand the cops that you intend to control if you use `cookstyle` comments. You can continue to use the existing `rubocop` comments, if you prefer them, since both types of comments will be honored by Cookstyle.

RuboCop comment to disable a cop:

```ruby
'node.normal[:foo] # rubocop: disable ChefCorrectness/Bar'
```

Cookstyle comment to disable a cop:

```ruby
'node.normal[:foo] # cookstyle: disable ChefCorrectness/Bar'
```

### Other fixes and changes

- `ChefStyle/UsePlatformHelpers` now detects and autocorrects the use of `!=` with `node['platform']` and `node['platform_family']`. For example, `node['platform'] != 'ubuntu'` will autocorrect to `!platform?('ubuntu)`
- `ChefModernize/RespondToInMetadata` now detects and autocorrects the usage of `if respond_to?(:chef_version)` in `metadata.rb` and also detects if statements are defined in additional ways.
- `ChefDeprecations/UsesRunCommandHelper` now detects the usage of the `run_command_with_systems_locale` helper method.

## Cookstyle 5.11

### 6 New Chef Cops

#### ChefDeprecations/SearchUsesPositionalParameters

The `SearchUsesPositionalParameters` cop will detect if the `search` helper is used with unnamed parameters. In chef-client 12+ the third and later parameters in the search helper must be named hash values. This cop will also search for and remove the legacy `sort` field as that functionality was removed in chef-client 12.

Legacy positional parameter usage in search:

```ruby
search(:node, '*:*', 0, 1000)
```

Modern named parameter usage in search:

```ruby
search(:node, '*:*', start: 0, rows: 1000)
```

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/PartialSearchHelperUsage

The `PartialSearchHelperUsage` cop detects the `partial_search` helper that was introduced in Chef Client 11.x. This helper was replaced in Chef Client 12 with a built-in partial search and should be replaced with filtering using Chef Infra Client's built-in `search` helper.

Legacy partial_search helper usage:

```ruby
partial_search(:node, 'role:web',
               keys: { 'name' => [ 'name' ],
                       'ip' => [ 'ipaddress' ],
                       'kernel_version' => %w(kernel version),
                     })
```

Modern search usage with filtering:

```ruby
search(:node, 'role:web',
       filter_result: { 'name' => [ 'name' ],
                        'ip' => [ 'ipaddress' ],
                        'kernel_version' => %w(kernel version),
                      })
```

`Enabled by default`: True

`Autocorrects`: No

#### ChefDeprecations/PartialSearchClassUsage

The `PartialSearchClassUsage` cop detects the legacy `partial_search` helper by using the Chef::PartialSearch class. Similar to the `PartialSearchHelperUsage` cop, this functionality should also be replaced with filtering using Chef Infra Client's built-in `search` helper.

Legacy Chef::PartialSearch class usage:

```ruby
Chef::PartialSearch.new.search(:node, 'role:web',
     keys: { 'name' => [ 'name' ],
             'ip' => [ 'ipaddress' ],
             'kernel_version' => %w(kernel version),
           })
```

Modern search usage with filtering:

```ruby
search(:node, 'role:web',
       filter_result: { 'name' => [ 'name' ],
                        'ip' => [ 'ipaddress' ],
                        'kernel_version' => %w(kernel version),
                      })
```

`Enabled by default`: True

`Autocorrects`: No

#### ChefDeprecations/PoiseArchiveUsage

The `PoiseArchiveUsage` cop detects the `poise_archive` resource in cookbooks. Chef Infra Client 15+ ships with the built-in `archive_file` resource which should be used instead.

`Enabled by default`: True

`Autocorrects`: No

#### ChefModernize/Definitions

The `Definitions` cop detects cookbooks that include Definitions. We highly recommend replacing legacy Definitions with Custom Resources. Definitions are not *currently* deprecated, but we do plan to deprecate this functionality in the future. See [Converting Definitions to Custom Resources](https://docs.chef.io/definitions/) for more information on the benefits of Custom Resources and how to convert legacy Definitions.

`Enabled by default`: True

`Autocorrects`: No

#### ChefEffortless/SearchForEnvironmentsOrRoles

The `SearchForEnvironmentsOrRoles` cop is an optional cop for users who are migrating to Policyfiles or the Effortless pattern. This cop detects searches that find nodes based on their roles and environments. Policyfiles replace roles and environments so these node searches will need to be updated as part of a migration.

`Enabled by default`: False

`Autocorrects`: No

### Other fixes and changes

- The RuboCop engine that powers Cookstyle has been upgraded from 0.72 to 0.75.1. This update includes more than 50 bug fixes that may result in new warnings during your Cookstyle runs. We have also enabled a new `Migration/DepartmentName` cop that will detect and update the names of disabled cops in cookbook code. This will prevent cop name deprecation warnings when you run Cookstyle.
- The `ChefModernize/RespondToInMetadata` cop will now detect the usage of `if defined?(foo)` in metadata.rb as well.

## Cookstyle 5.10

### 11 New Chef Cops

#### ChefDeprecations/VerifyPropertyUsesFileExpansion

The `VerifyPropertyUsesFileExpansion` cop detects resources using the `verify` property to validate file content with the legacy `file` variable instead of the `path` variable required in Chef Infra Client 13 and later.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/ResourceInheritsFromCompatResource

The `ResourceInheritsFromCompatResource` cop detects legacy Heavy Weight Resource Providers (HWRPs) that inherit from the CompatResource class, which shipped in the legacy `compat_resource` cookbook. Ideally, these resources are rewritten as standard Custom Resources, but at a minimum they should inherit from the proper class: `Chef::Resource`.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/EOLAuditModeUsage

The `EOLAuditModeUsage` cookbook detects the usage of the beta Audit Mode feature that was removed in Chef Infra Client 15.0. Users should instead use Chef InSpec with the `audit` cookbook, which offers a far more robust framework for system auditing.

`Enabled by default`: True

`Autocorrects`: No

#### Add ChefDeprecations/LegacyYumRepositoryProperties

The `LegacyYumRepositoryProperties` cop detects the usage of legacy properties in the `yum_repository` resource. These properties were renamed in the `yum` cookbook 3.0 and shipped in Chef Infra Client 12.14, which included the `yum_repository` resource.

These properties will be updated:

- url -> baseurl
- keyurl -> gpgkey
- mirrorexpire -> mirror_expire

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefCorrectness/IncorrectLibraryInjection

The `IncorrectLibraryInjection` cop detects libraries that inject their helpers into Recipe/Resource/Provider classes directly instead of using the `Chef::DSL::Recipe` or `Chef::DSL::Resource` classes.

These calls will be updated:

- ::Chef::Recipe.send(:include, MyCookbook::Helpers) -> ::Chef::DSL::Recipe.send(:include, MyCookbook::Helpers)
- ::Chef::Provider.send(:include, MyCookbook::Helpers) -> ::Chef::DSL::Recipe.send(:include, MyCookbook::Helpers)
- ::Chef::Resource.send(:include, MyCookbook::Helpers) -> ::Chef::DSL::Resource.send(:include, MyCookbook::Helpers)

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefCorrectness/NotifiesActionNotSymbol

The `NotifiesActionNotSymbol` cop detects resources that notify another resource to converge an action, but specify the action as a string instead of a symbol.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefEffortless/CookbookUsesEnvironments

`CookbookUsesEnvironments` is a disabled by default cop that helps users migrating to the Chef Infra Effortless pattern by detecting cookbooks that use Chef Infra Environments.

`Enabled by default`: False

`Autocorrects`: No

#### ChefEffortless/CookbookUsesPolicygroups

`CookbookUsesPolicygroups` is a disabled by default cop that helps users migrating to the Chef Infra Effortless pattern by detecting cookbooks that use Chef Infra Policy Groups.

`Enabled by default`: False

`Autocorrects`: No

#### ChefEffortless/CookbookUsesRoles

`CookbookUsesRoles` is disabled by default cop that helps users migrating to the Chef Infra Effortless pattern by detecting cookbooks that use Chef Infra Roles.

`Enabled by default`: False

`Autocorrects`: No

#### ChefModernize/DefaultActionFromInitialize

The `DefaultActionFromInitialize` cop detects HWRPs that define a resource's default actions by setting the `@actions` variable within the `initialize` method instead of using the `default_action` method.

`Enabled by default`: Yes

`Autocorrects`: Yes

#### ChefModernize/ResourceNameFromInitialize

The `ResourceNameFromInitialize` cop detects HWRPs that define a resource's name by setting the `@resource_name` variable within the `initialize` method instead of using the `resource_name` method.

`Enabled by default`: Yes

`Autocorrects`: Yes

### Other fixes and changes

- The `ChefModernize/CustomResourceWithAllowedActions` cop now detects unnecessary `allowed_actions` in legacy HWRPs.
- The `ChefDeprecations/CookbookDependsOnPoise` cop now detects the `poise-service` cookbook in addition to the `poise` cookbook.

## Cookstyle 5.9

### 3 New Chef Cops

#### ChefModernize/PowerShellGuardInterpreter

The `PowerShellGuardInterpreter` cop detects `powershell_script` resources that set the `guard_interpreter` property to `:powershell_script`. In Chef Infra Client 13 and later, `:powershell_script` is the default and does not need to be set.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/UsesRunCommandHelper

The `UsesRunCommandHelper` cop detects recipes and resources that use the legacy `run_command` helper, which was removed in Chef Infra Client 13. Users should instead use the `shell_out` or `shell_out!` helpers, which use the `mixlib-shellout` Ruby gem under the hood.

`Enabled by default`: True

`Autocorrects`: No

#### ChefDeprecations/ChefHandlerUsesSupports

The `ChefHandlerUsesSupports` cop detects `handler` resources that use the `supports` property instead of the newer `type` property. The `supports` property was removed in the chef_handler cookbook version 3.0 (June 2017) and Chef Infra Client 14.0.

`Enabled by default`: True

`Autocorrects`: Yes

### Other fixes and changes

- The `ChefModernize/UnnecessaryDependsChef14` cop will now detect cookbook dependencies that include a version constraint.

## Cookstyle 5.8

### 5 New Chef Cops

#### ChefCorrectness/InvalidVersionMetadata

The `InvalidVersionMetadata` cop detects cookbook metadata that specifies invalid cookbook versions. Chef Infra cookbook versions must be in the `x.y.z` format.

`Enabled by default`: True

`Autocorrects`: No

#### ChefStyle/SimplifyPlatformMajorVersionCheck

The `SimplifyPlatformMajorVersionCheck` cop detects overly complex code for determining the major version of a platform using the `node['platform_version']` attribute. The cop will detect the following methods for selecting the major version from `node['platform_version']`:

```ruby
node['platform_version'].split('.').first
node['platform_version'].split('.')[0]
node['platform_version'].split('.').first.to_i
node['platform_version'].split('.')[0].to_i
```

These will be autocorrected to `node['platform_version'].to_i`.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/ChefSpecCoverageReport

The `ChefSpecCoverageReport` cop detects the usage of deprecated ChefSpec Coverage report functionality in your specs. This feature has been removed from ChefSpec as coverage reports encourage cookbook authors to write ineffective specs. Instead authors should focus on testing logic instead of achieving 100% code coverage.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/ChefSpecLegacyRunner

The `ChefSpecLegacyRunner` cop detects usage of the legacy `ChefSpec::Runner` class in ChefSpec unit tests. ChefSpec 4.1 (Oct 2014) and later require the use of either the `ChefSpec::ServerRunner` or `ChefSpec::SoloRunner` class.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefCorrectness/UnnecessaryNameProperty

The `UnnecessaryNameProperty` cop detects resources that define a property with the name of :Name. All Chef Infra resources automatically receive a property of :Name so there's no need to define this.

`Enabled by default`: True

`Autocorrects`: Yes

### Other fixes and changes

- `ChefDeprecations/UserDeprecatedSupportsProperty` now supports autocorrect
- `ChefDeprecations/UseInlineResourcesDefined` now detects `use_inline_resources if respond_to?(:use_inline_resources)`
- `CustomResourceWithAllowedActions` now detects unnecessary actions in LWRPs as well
- The docs at [https://github.com/chef/cookstyle/blob/main/docs/cops.md](https://github.com/chef/cookstyle/blob/main/docs/cops.md) are now auto-generated on each pull request merge

## Cookstyle 5.7

### 5 New Chef Cops

#### ChefDeprecations/ResourceOverridesProvidesMethod

The `ChefDeprecations/ResourceOverridesProvidesMethod` cop detects overriding the `provides?` method in a resource's provider. This will cause failures in Chef Infra Client 13 and later. Instead use `provides :SOME_PROVIDER_NAME` to register the provider.

`Enabled by default`: True

`Autocorrects`: No

#### ChefDeprecations/ResourceUsesDslNameMethod

The `ChefDeprecations/ResourceUsesDslNameMethod` cop detects resources that use the `dsl_name` method instead of `resource_name`. This will cause failures in Chef Infra Client 13 and later.

`Enabled by default`: True

`Autocorrects`: No

#### ChefDeprecations/ResourceUsesUpdatedMethod

The `ChefDeprecations/ResourceUsesUpdatedMethod` cop detects resources that update resource convergence state by setting `updated = true` (or false). This will cause failures in Chef Infra Client 13 and later.

`Enabled by default`: False (high likelihood of false positives)

`Autocorrects`: No

#### ChefDeprecations/NamePropertyWithDefaultValue

The `ChefDeprecations/NamePropertyWithDefaultValue` cop detects resource properties that are marked as a name_property while also having a default value. This will fail in Chef Infra Client 13 or later.

`Enabled by default`: True

`Autocorrects`: No

#### ChefDeprecations/ResourceUsesProviderBaseMethod

The `ChefDeprecations/ResourceUsesProviderBaseMethod` cop detects the provider_base method being in a resource to specify the provider module to use. Instead, the provider should call `provides` to register itself, or the resource should call `provider` to specify the provider to use. This will cause failures in Chef Infra Client 13 and later.

`Enabled by default`: True

`Autocorrects`: No

## Cookstyle 5.6

### 12 New Chef Cops

#### ChefDeprecations/WindowsTaskChangeAction

The `ChefDeprecations/WindowsTaskChangeAction` cop detects the `windows_task` resource used with the legacy `:change` action. When the `windows_task` resource was moved into Chef Infra Client 13, the `:change` action was merged into the `:create` action. Most users set the `:change` action in conjunction with `:create`, and `:change` can now be removed.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/RecipeMetadata

The `ChefDeprecations/RecipeMetadata` cop detects the usage of the `recipe` method in metadata.rb. This method was never used by Chef Infra and it has been deprecated. User-facing documentation, such as recipe descriptions, should instead be placed in the cookbook's README.md file.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefStyle/UsePlatformHelpers

The `ChefStyle/UsePlatformHelpers` cop detects the usage of `node['platform] == 'foo'` or `node['platform_family] == 'bar'` and instead suggests using `platform?('foo')` or `platform_family?('bar')`. These platform helpers help simplify platform check logic, especially when checking for multiple platforms as they accept more than one platform: `platform?('foo', 'bar')`

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefModernize/CronManageResource

The `ChefModernize/CronManageResource` cop detects the usage of the `cron_manage` resource, which was renamed to `cron_access` when it was included in Chef Infra Client 14.4.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefModernize/UsesZypperRepo

The `ChefModernize/UsesZypperRepo` cop detects the usage of the `zypper_repo` resource, which was renamed to  `zypper_repository` when it was included in Chef Infra Client 13.3.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefModernize/DependsOnZypperCookbook

The `ChefModernize/DependsOnZypperCookbook` cop detects a cookbook that depends on the `zypper` cookbook. Chef Infra Client 13.3 and later include the `zypper_repository` resource, which was previously only available in the `zypper` cookbook.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefModernize/ExecuteTzUtil

The `ChefModernize/ExecuteTzUtil` cop detects a cookbook that uses an `execute` resource to shell out to the `tzutil.exe` command. Chef Infra Client 14.6 and later ships with the [timezone resource](https://docs.chef.io/resources/timezone/), which should be used instead of `tzutil`.

`Enabled by default`: True

`Autocorrects`: No

#### ChefModernize/OpensslRsaKeyResource

The `ChefModernize/OpensslRsaKeyResource` cop detects usage of the `openssl_rsa_key` resource, which was renamed to `openssl_rsa_private_key` when it shipped in Chef Infra Client 14.0.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefModernize/OpensslX509Resource

The `ChefModernize/OpensslX509Resource` cop detects usage of the `openssl_x509` resource, which was renamed to `openssl_x509_certificate` when it shipped in Chef Infra Client 14.4.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefModernize/OsxConfigProfileResource

The `ChefModernize/OsxConfigProfileResource` cop detects usage of the `osx_config_profile` resource, which was renamed to `osx_profile`.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefModernize/SysctlParamResource

The `ChefModernize/SysctlParamResource` cop detects usage of the `sysctl_param` resource, which was renamed to `sysctl` when it shipped in Chef Infra Client 14.0.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefModernize/MacOsXUserdefaults

The `ChefModernize/MacOsXUserdefaults` cop detects usage of the `mac_os_x_userdefaults` resource, which was renamed to `macos_userdefaults` when it was added to Chef Infra Client 14.0.

`Enabled by default`: True

`Autocorrects`: Yes

## Cookstyle 5.5

### Chef Cops Broken Up Into Four Departments

The Chef cops have been broken up into four more granular cop departments. This makes it easier to pick and choose which cops to scan for, and makes disabling groups of cops simpler. Instead of just "Chef" we now have the following departments:

- `ChefDeprecations`: Cops that detect (and in many cases correct) deprecations that will prevent cookbooks from running on modern versions of Chef Infra Client.
- `ChefStyle`: Cops that help with the format and readability of your cookbooks.
- `ChefModernize`: Cops that help you modernize your cookbooks to better use functionality introduced in new Chef Infra Client Releases.
- `ChefEffortless`: Cops that help with the migration to the Effortless pattern. These are disabled by default.

You can run cookstyle with just a single department:

```bash
cookstyle --only ChefDeprecations
```

You can also exclude a specific group from the command line:

```bash
cookstyle --except ChefStyle
```

You can also add the following to your .rubocop.yml config to disable a specific department:

```yaml
ChefStyle:
  Enabled: false
```

### Chef Cop Documentation

Documentation for all Chef cops can now be found in the Cookstyle repos's [docs directory](https://github.com/chef/cookstyle/blob/main/docs/cops.md)

### 15 New Chef Cops

#### Chef/ResourceSetsInternalProperties

The `ResourceSetsInternalProperties` cop detects resources that set internal state properties used by built-in Chef Infra resources. These undocumented properties should not be set in a resource block and doing so will cause unexpected behavior when running Chef Infra Client.

`Examples`

Service resource setting the internal running property:

```ruby
service 'foo' do
  running true
  action [:start, :enable]
end
```

#### Chef/ResourceSetsNameProperty

The `ResourceSetsNameProperty` cop detects a resource block with the `name` property set. The `name` property is a special property that is derived from the name of the resource block and should not be changed with the block. Changing the name within a resource block can cause issues with reporting and notifications. If you wish to give your resources a more friendly name, consider setting a `name_property`, which is available in all built-in Chef Infra resources. The name_property for each resource can be found in the [resource reference documentation](https://docs.chef.io/resource_reference.html).

`Examples`

Service resource incorrectly setting the name property:

```ruby
service 'Start the important service' do
  name 'foo'
  action [:start, :enable]
end
```

Service resource correctly setting the service_name name property:

```ruby
service 'Start the important service' do
  service_name 'foo'
  action [:start, :enable]
end
```

`Enabled by default`: True

`Autocorrects`: No

#### Chef/ResourceWithNoneAction

The `ResourceWithNoneAction` cop detects the use of the `:none` action in a resource. The `:none` action is a common typo for the built-in `:nothing` action in all resources.

`Examples`

Service resource with the incorrect :none action:

```ruby
service 'my_service' do
  action [:none]
end
```

`Enabled by default`: True

`Autocorrects`: Yes

#### Chef/ChocolateyPackageUninstallAction

The `ChocolateyPackageUninstallAction` cop detects a `chocolatey_package` resource that uses the `:uninstall` action. The uninstall action has been replaced with the `:remove` action and will error in Chef Infra Client 14+.

`Examples`

chocolatey_package incorrectly setting the `:uninstall` action:

```ruby
chocolatey_package 'nginx' do
  action :uninstall
end
```

chocolatey_package correctly setting the :remove action:

```ruby
chocolatey_package 'nginx' do
  action :remove
end
```

`Enabled by default`: True

`Autocorrects`: Yes

#### Chef/LaunchdDeprecatedHashProperty

The `LaunchdDeprecatedHashProperty` cop detects the use of the deprecated `hash` property in the `launchd` resource. The hash property was renamed to `plist_hash` in Chef Infra Client 13 and support for the `hash` name was removed in Chef Infra Client 14.

`Examples`

launchd with the deprecated `hash` property:

```ruby
launchd 'foo' do
  hash foo: 'bar'
end
```

launchd with the correct `plist_hash` property:

```ruby
launchd 'foo' do
  plist_hash foo: 'bar'
end
```

`Enabled by default`: True

`Autocorrects`: Yes

#### Chef/LocaleDeprecatedLcAllProperty

The `LocaleDeprecatedLcAllProperty` cop detects the use of the `lc_all` property in the `locale` resource. The `lc_all` property was deprecated in Chef Infra Client 15.0 and will be removed in the 16.0 release. Setting the LC_ALL variable is NOT recommended. As a system-wide setting, LANG should provide the desired behavior. LC_ALL is intended to be used for temporarily troubleshooting issues rather than an everyday system setting. Changing LC_ALL can break Chef’s parsing of command output in unexpected ways. Use one of the more specific LC_ properties as needed.

`Examples`

locale resource setting the lc_all property:

```ruby
locale 'set locale' do
  lang 'en_gb.utf-8'
  lc_all 'en_gb.utf-8'
end
```

`Enabled by default`: True

`Autocorrects`: No

#### Chef/UserDeprecatedSupportsProperty

The `UserDeprecatedSupportsProperty` cop detects the usage of the deprecated `supports` property in the `user` resource.

`Enabled by default`: True

`Autocorrects`: No

#### Chef/PowershellScriptExpandArchive

The `PowershellScriptExpandArchive` op detects the usage of the `powershell_script` resource to run the `Expand-Archive` Cmdlet. The [archive_file](https://docs.chef.io/resource_archive_file.html) resource in Chef Infra Client 15.0 should be used instead.

`Examples`

powershell_script using Expand-Archive to setup a website:

```ruby
powershell_script 'Expand website' do
  code 'Expand-Archive "C:\\file.zip" -DestinationPath "C:\\inetpub\\wwwroot\\mysite"'
  not_if { File.exist?("C:\\inetpub\\wwwroot\\mysite") }
end
```

The same archive handled by archive_file:

```ruby
archive_file 'Expand website' do
  path 'C:\file.zip'
  destination 'C:\inetpub\wwwroot\mysite'
end
```

`Enabled by default`: True

`Autocorrects`: No

#### Chef/PowershellInstallPackage

The `PowershellInstallPackage` cop detects the usage of the `powershell_script` resource to run the `Install-Package` Cmdlet. The [powershell_package](https://docs.chef.io/resource_powershell_package.html) resources should be used to install packages via the PowerShell Package Manager instead.

Installing Docker via `powershell_script` and `Install-Package`:

```ruby
powershell_script 'Install Docker' do
  code 'Install-Package -Name docker'
  not_if { File.exist?("C:\\Program Files\\Docker") }
end
```

The same package installed with powershell_package:

```ruby
powershell_package 'Install Docker' do
  package_name 'Docker'
end
```

`Enabled by default`: True

`Autocorrects`: No

#### Chef/PowershellInstallWindowsFeature

The `PowershellInstallWindowsFeature` cop detects the usage of the `powershell_script` resource to run the `Install-WindowsFeature` or `Add-WindowsFeature` Cmdlets. The `windows_feature` resource should be used to install Windows features.

`Examples`

powershell_script using Install-WindowsFeature to install a feature:

```ruby
powershell_script 'Install Feature' do
  code 'Install-WindowsFeature -Name "Windows-Identity-Foundation"'
  not_if '(Get-WindowsFeature | where {$_.Name -eq "Windows-Identity-Foundation"}).IsInstalled -eq true'
end
```

The same feature install with windows_feature:

```ruby
windows_feature 'Windows-Identity-Foundation' do
  action :install
  install_method :windows_feature_powershell
end
```

`Enabled by default`: True

`Autocorrects`: No

#### Chef/CookbookUsesNodeSave

The `CookbookUsesNodeSave` cop detects the usage of `node.save` within a cookbook. `node.save` is often used to ensure a run_list is saved, or so that other state information is immediately available for search by other nodes in your environment. The use of `node.save` can be incredibly problematic and should be avoided as a run failure will still result in the node data being saved to the Chef Infra Server. If search is used to put nodes into production state, this may result in non-functioning nodes being used.

`Enabled by default`: True

`Autocorrects`: No

#### Chef/SevenZipArchiveResource

The `SevenZipArchiveResource` cop detects the usage of the `seven_zip_archive` resource from the `seven_zip` community cookbook. The `archive_file` resource built into Chef Infra Client 15.0 should be used instead to avoid the need for extra cookbook dependencies.

`Examples`

Expanding a zip archive with seven_zip_archive:

```ruby
seven_zip_archive 'seven_zip_source' do
  path      'C:\inetpub\wwwroot\mysite'
  source    'C:\file.zip'
end
```

The same archive handled by archive_file:

```ruby
archive_file 'Expand website' do
  path 'C:\file.zip'
  destination 'C:\inetpub\wwwroot\mysite'
end
```

`Enabled by default`: True

`Autocorrects`: No

#### Chef/LibarchiveFile

The `LibarchiveFile` cop detects the usage of the `libarchive_file` resource from the `libarchive` community cookbook. The `archive_file` resource built into Chef Infra Client 15.0 is based on the `libarchive_file` resource and it should be used instead to avoid the need for extra cookbook dependencies.

`Examples`

Expanding a zip archive with libarchive_file:

```ruby
libarchive_file 'seven_zip_source' do
  path 'C:\file.zip'
  destination 'C:\inetpub\wwwroot\mysite'
end
```

The same archive handled by archive_file:

```ruby
archive_file 'Expand website' do
  path 'C:\file.zip'
  destination 'C:\inetpub\wwwroot\mysite'
end
```

`Enabled by default`: True

`Autocorrects`: No

#### Chef/ShellOutToChocolatey

The `ShellOutToChocolatey` cop detects the use of `powershell_script` or `execute` resources to shell out to Chocolatey's `choco` command line utility. Chef Infra Client ships with multiple chocolatey resources, which should be used instead to install packages, configure features, and setup sources:

- [chocolatey_config](https://docs.chef.io/resources/chocolatey_config)
- [chocolatey_feature](https://docs.chef.io/resources/chocolatey_feature)
- [chocolatey_package](https://docs.chef.io/resources/chocolatey_package)
- [chocolatey_source](https://docs.chef.io/resources/chocolatey_source)

`Enabled by default`: True

`Autocorrects`: No

#### Chef/UsesChefRESTHelpers

The `UsesChefRESTHelpers` cop detects the usage of the various Chef::REST helpers, which were removed in Chef Infra Client 13.0. For communicating with the Chef Infra Server directly, you may consider using the `Chef::ServerAPI` helpers instead.

`Enabled by default`: True

`Autocorrects`: No

### Other fixes and changes

- `Chef/DefaultMetadataMaintainer` now detects additional default `maintainer` and `maintainer_email` field values.
- `Chef/UsesDeprecatedMixins` now inspects files in the resources directory in addition to the providers and libraries directories.

## Cookstyle 5.4

### 11 New Chef Cops

#### Chef/UseInlineResourcesDefined

The `UseInlineResourcesDefined` cop checks for resources that call the `use_inline_resources` method. Chef Infra Client 13 made the inline resources mode as the default for all resources, so this call is no longer necessary.

`Enabled by default`: True

`Autocorrects`: Yes

#### Chef/IncludingOhaiDefaultRecipe

The `IncludingOhaiDefaultRecipe` cop detects cookbooks that include the `ohai::default` recipe. The ohai cookbook's default recipe was used to install custom Ohai plugins located in the cookbook's `files` directory. Since the ohai cookbook required placing plugins into the cookbook's `files` directory it had to be forked locally, which we no longer recommend doing. Modern versions of the Ohai cookbook provide an [ohai_plugin resource](https://github.com/chef-cookbooks/ohai/#ohai_plugin), which can be used to install plugins into Chef Infra Client. Chef Infra Client will install also install Ohai plugins at runtime if they are placed in an `/ohai` directory in any cookbook. Note: This feature requires Chef Infra *Server* 12.18 or later.

`Enabled by default`: True

`Autocorrects`: No

#### Chef/IncludingXMLRubyRecipe

The `IncludingXMLRubyRecipe` cop detects cookbooks that include the `xml::ruby` recipe. This recipe was used to install the `nokogiri` gem into Chef Infra Client for use in parsing XML in cookbooks. Nokogiri ships with Chef Infra Client 13+, so this recipe is no longer necessary.

`Enabled by default`: True

`Autocorrects`: Yes

#### Chef/LegacyYumCookbookRecipes

The `LegacyYumCookbookRecipes` cop detects usage of legacy [yum](https://supermarket.chef.io/cookbooks/yum) cookbook recipes. These recipes were removed from the yum cookbook in version 3.0, which was released in 2013. Cookbooks should be updated to use the new individual yum cookbooks, which contain the same functionality as the legacy recipes.

`Examples`

Legacy recipes:

```ruby
  include_recipe 'yum::epel'
  include_recipe 'yum::ius'
```

New cookbooks containing the same functionality:

```ruby
  include_recipe 'yum-epel'
  include_recipe 'yum-ius'
```

`Enabled by default`: True

`Autocorrects`: No

#### Chef/DefaultMetadataMaintainer

The `DefaultMetadataMaintainer` cop detects the default `maintainer` and `maintainer_email` fields generated by the `chef generate cookbook` command. Cookbook metadata should be updated with actual maintainer information.

`Enabled by default`: True

`Autocorrects`: No

#### Chef/UsesDeprecatedMixins

The `UsesDeprecatedMixins` cop detects various legacy mixins used in `HWRP` and `LWRP` resources. These mixins are no longer necessary and were removed in Chef Infra Client 14. Running these legacy mixins with `HWRP` and `LWRP` resources on modern Chef Infra Client releases will cause errors.

`Enabled by default`: True

`Autocorrects`: Yes

#### Chef/MinitestHandlerUsage

The `MinitestHandlerUsage` cop detects cookbooks that depend on the [minitest-handler](https://supermarket.chef.io/cookbooks/minitest-handler) cookbook. This cookbook provides a handler for running [minitest](https://github.com/seattlerb/minitest) after each Chef Infra Client run. The handler is no longer maintained and we highly recommend using InSpec for validating a system configuration after a Chef Infra Client run. InSpec includes over 100 built-in resources and integrates with Automate to report the results of a system state validation.

`Enabled by default`: True

`Autocorrects`: No

#### Chef/WindowsVersionHelper

The `WindowsVersionHelper` cop detects the usage of the various Windows version helpers that shipped in the [windows](https://supermarket.chef.io/cookbooks/windows) cookbook. Nearly all of the resources that originally shipped in the windows cookbook are now part of Chef Infra Client itself. We would like to help move users away from the windows cookbook so they can avoid the added dependency in their environment. Instead of using the Windows version helpers, we suggest using data from Ohai itself to determine what version of Windows is running on a node.

`Examples`

A cookbook using the Windows version helper:

```ruby
  Windows::VersionHelper.nt_version == 6.1
```

The same version comparison could be done using Ohai attributes

```ruby
  node['platform_version'].to_f == 6.1
```

`Enabled by default`: True

`Autocorrects`: No

#### Chef/WindowsZipfileUsage

The `WindowsZipfileUsage` detects the usage of the `windows_zipfile` resource in the [Windows](https://supermarket.chef.io/cookbooks/windows) cookbook. This is one of the remaining resources in the windows cookbook that is not present in Chef Infra Client itself. In Chef Infra Client 15.0 we introduced the [archive_file](https://docs.chef.io/resources/archive_file) resource, which is a cross-platform resource for uncompressing archives. This resource uses an ultra-fast compression library with support for multiple compression formats, and should be used instead of the legacy `windows_zipfile` resource.

`Enabled by default`: True

`Autocorrects`: No

#### Chef/NodeMethodsInsteadofAttributes

The `NodeMethodsInsteadofAttributes` cop detects cookbooks that reference node attributes in the legacy `node.some.value` format. Chef Infra Client 13 officially deprecated this attribute format. This cop detects the usage of common Ohai attributes and can autocorrect those. But it won't detect cookbook attributes which also need to be updated.

`Enabled by default`: True

`Autocorrects`: Yes

`Examples`

Node attributes in the method format:

```ruby
  node.platform
  node.platform_version
  node.my_cookbook.attribute1
```

The preferred format:

```ruby
  node['platform']
  node['platform_version']
  node['my_cookbook']['attribute1']
```

#### Chef/IncludingMixinShelloutInResources

The `IncludingMixinShelloutInResources` cop detects resources that require and include the Chef Shellout Mixin helper. Chef Infra Client now includes the Chef Shellout Mixin helper automatically for all resources, so require and include statements can be removed from all resources.

`Enabled by default`: True

`Autocorrects`: Yes

### Other fixes and changes

- Multiple cops will now skip scanning metadata.rb to speed up cookstyle runs
- Chef/MetadataMissingName now supports autocorrecting. The folder containing the metadata.rb will be used as the cookbook name if it's missing from metadata.rb
- Chef/WhyRunSupportedTrue has been corrected to properly trigger on the whyrun_supported method in resources
- The files directory in cookbooks is now excluded from Cookstyle scans

## Cookstyle 5.3

### 5 New Chef Cops

#### Chef/IncludingAptDefaultRecipe

The `IncludingAptDefaultRecipe` cop detects cookbooks that include the `apt::default` cookbook in order to run the `apt-get update` command. Users should use Chef Infra Client's built in `apt_update` resource instead.

`Enabled by default`: True

`Autocorrects`: No, due to potential notifications to these resources, which need to be updated.

#### Chef/ExecuteAptUpdate

The `ExecuteAptUpdate` cop detects the use of an `execute` resource to run the `apt-get update` command. Users should use Chef Infra Client's built in `apt_update` resource instead.

`Enabled by default`: True

`Autocorrects`: No, due to potential notifications to these resources, which need to be updated.

#### Chef/IncludingWindowsDefaultRecipe

The `IncludingWindowsDefaultRecipe` detects cookbooks that include the `windows::default` recipe. This recipe installs gems that ship as part of Chef Infra Client 12.0+ and do not need to be installed again.

`Enabled by default`: True

`Autocorrects`: Yes

#### Chef/IncludingYumDNFCompatRecipe

The `IncludingYumDNFCompatRecipe` detects cookbooks that include the `yum::dnf_yum_compat` recipe in order to install yum libraries on systems that use DNF as their default package manager. Chef Infra Client 12.18 and later support the native installation of packages using DNF.

`Enabled by default`: True

`Autocorrects`: Yes

#### Chef/DefinesChefSpecMatchers

The `DefinesChefSpecMatchers` detects cookbooks that ship ChefSpec matchers. ChefSpec 7.1 and later automatically generate ChefSpec matchers for testing resources, so these ChefSpec matchers no longer need to be shipped with cookbooks.

`Enabled by default`: True

`Autocorrects`: Yes. This may result in an empty `libraries/matchers.rb` file, which can then be deleted.

### Other fixes and changes

- Chef/InvalidLicenseString now auto-corrects `Apache v2.0` to `Apache-2.0`
- Chef/CommentFormat better handles leading spaces in comments when auto-correcting
- Testing has been expanded to include testing of auto-correct functionality

## Cookstyle 5.2

### New Chef Cops

#### Chef/InvalidPlatformMetadata

The `InvalidPlatformMetadata` cop detects invalid platform names in the supports metadata.rb method. It uses a hardcoded set of common typos so it can't detect all invalid platforms, but it does detect the most common mistakes found on the Supermarket.

`Enabled by default`: True

`Autocorrects`: True (deletes the occurrence)

#### Chef/RespondToResourceName

The `RespondToResourceName` cop detects the usage of respond_to?(:resource_name) in resources to provide backwards compatibility. This `respond_to?` check is no longer necessary in Chef Infra Client 12.5+

`Enabled by default`: True

`Autocorrects`: True (deletes the `if respond_to?` occurrence)

#### Chef/RespondToProvides

The `RespondToProvides` cop detects the usage of respond_to?(:provides) in providers to provide backwards compatibility. This `respond_to?` check is no longer necessary in Chef Infra Client 12+

`Enabled by default`: True

`Autocorrects`: True (deletes the `if respond_to?` occurrence)

#### Chef/RespondToInMetadata

The `RespondToInMetadata` cop detects the usage of `if respond_to?(:foo)` to prevent newer metadata methods from running on Chef Infra Client versions older than 12.15. The chef-client doesn't fail when it encounters unknown metadata in Chef Infra Client versions 12.15.

`Enabled by default`: True

`Autocorrects`: True (deletes the `if respond_to?` occurrence)

#### Chef/LongDescriptionMetadata

The `LongDescriptionMetadata` cop detects usage of `long_description` in metadata.rb. Chef Infra and Supermarket never utilized the `long_description` metadata, but cookbooks commonly load their README.md file into the metadata. This increases the size of metadata stored on Chef Infra Server without providing a clear benefit to users.

`Enabled by default`: True

`Autocorrects`: True (deletes the occurrence)

#### Chef/CookbooksDependsOnSelf

The `CookbooksDependsOnSelf` cop detects a cookbook that depends on itself in metadata.rb.

`Enabled by default`: True

`Autocorrects`: True

#### Chef/MetadataMissingName

The `MetadataMissingName` cop detects a missing name field in the metadata.rb. Chef Infra Client 12+ requires the name field.

`Enabled by default`: True

`Autocorrects`: False

#### Chef/RequireRecipe

The `RequireRecipe` cop detects the usage of `require_recipe` to include a recipe instead of `include_recipe`.

`Enabled by default`: True

`Autocorrects`: True

#### Chef/InvalidLicenseString

The `InvalidLicenseString` cop detects non-SPDX compliant license strings (or 'all rights reserved') in metadata.rb and autocorrects many common license typos.

`Enabled by default`: True

`Autocorrects`: True

#### Chef/SetOrReturnInResources

The `SetOrReturnInResources` cop detects the usage of the `set_or_return` helper method in resources to create properties. Modern Chef Infra practice prefers using the `property` method because `set_or_return` lacks additional validation, reporting, and documentation functionality.

`Examples`

A resource property created using set_or_return:

```ruby
  def severity(arg = nil)
    set_or_return(
      :severity, arg,
      :kind_of => String,
      :default => nil
    )
  end
```

The same property created using the resource DSL

```ruby
  property :severity, String
```

`Enabled by default`: True

`Autocorrects`: False

#### Chef/CustomResourceWithAttributes

The `CustomResourceWithAttributes` cop detects a custom resource that contains attributes. LWRPs and HWRPs contained attributes, but custom resources changed the name attribute to property to avoid confusion with traditional Chef Infra node attributes.

`Enabled by default`: True

`Autocorrects`: True  (deletes the occurrence)

#### Chef/CustomResourceWithAllowedActions

The `CustomResourceWithAllowedActions` cop detects a custom resource that uses the `actions` or `allowed_actions` methods. These methods were necessary when writing LWRPs and HWRPs, but are no longer necessary with custom resources.

`Enabled by default`: True

`Autocorrects`: True  (deletes the occurrence)

### Other fixes and changes

- Improves the configuration file to correctly verify LWRP/HWRP files
- Enables several Chef/* cops in the config file
- Enables Chef/UseBuildEssentialResource by default
- Fixes Chef/NodeSetUnless and Chef/NodeSet to correctly autocorrect node.set in ChefSpec tests

## Cookstyle 5.1

Cookstyle 5.1 greatly expands the Chef Infra linting experience of Cookstyle with a large number of new Chef specific Cops and improved configuration default behavior.

Cookstyle now ships with 32 Chef Infra specific cops to help you update cookbooks for the latest releases of Chef Infra Client.

This release also introduces a less user impacting method of shipping new Chef cops going forward. All of the existing Chef cops are now `Refactor` level instead of `Error`, and Cookstyle has been updated to not fail builds for anything at the Refactor level by default. We'll continue to ship new Cops every month and you'll be able to autocorrect any of these new warnings without impacting any CI jobs. Every April, in our major release window, the existing cops will become `Error` level and any occurrences will need to be resolved or excluded.

### New Chef Cops

#### Chef/ConflictsMetadata

The `ConflictsMetadata` cop detects the usage of the `conflicts` method in metadata.rb. This method was never used by Chef Infra and it has been deprecated.

`Enabled by default`: True

`Autocorrects`: True (deletes the occurrence)

#### Chef/SuggestsMetadata

The `SuggestsMetadata` cop detects the usage of the `suggests` method in metadata.rb. This method was never used by Chef Infra and it has been deprecated.

`Enabled by default`: True

`Autocorrects`: True (deletes the occurrence)

#### Chef/ReplacesMetadata

The `ReplacesMetadata` cop detects the usage of the `replaces` method in metadata.rb. This method was never used by Chef Infra and it has been deprecated.

`Enabled by default`: True

`Autocorrects`: True (deletes the occurrence)

#### Chef/ProvidesMetadata

The `ProvidesMetadata` cop detects the usage of the `provides` method in metadata.rb. This method was never used by Chef Infra and it has been deprecated.

`Enabled by default`: True

`Autocorrects`: True (deletes the occurrence)

#### Chef/AttributeMetadata

The `AttributeMetadata` detects metadata that contains attribute documentation. The attribute method for documenting attributes in metadata was never used by Chef Infra itself and has been deprecated. Attributes should be documented using inline comments or in a readme.

`Enabled by default`: True

`Autocorrects`: True (deletes the occurrence)

#### Chef/CookbookDependsOnCompatResource

The `CookbookDependsOnCompatResource` cop detects cookbooks that depend on the deprecated `compat_resource` cookbook. This cookbook backported custom resource functionality to early version of Chef Infra Client 12 and is no longer necessary.

`Enabled by default`: True

`Autocorrects`: True (deletes the occurrence)

#### Chef/CookbookDependsOnPartialSearch

The `CookbookDependsOnPartialSearch` cop detects cookbooks that depend on the deprecated `partial_search` cookbook. This cookbook was necessary on older Chef Infra Client releases, which lacked the Partial Search functionality, but this functionality is built into Chef Infra Client 13 and later.

`Enabled by default`: True

`Autocorrects`: True (deletes the occurrence)

#### Chef/UnnecessaryDependsChef14

The `CookbookDependsOnPartialSearch` cop detects cookbooks that depend on various resource cookbooks, which were made obsolete with the release of Chef Infra Client 14. These cookbooks no longer need to be shipped to the load or loaded and can be removed.

`Examples`

```ruby
depends 'build-essential'
depends 'chef_handler'
depends 'chef_hostname'
depends 'dmg'
depends 'mac_os_x'
depends 'swap'
depends 'sysctl'
```

`Enabled by default`: True

`Autocorrects`: True (deletes the occurrence)

#### Chef/CookbookDependsOnPoise

The `CookbookDependsOnPoise` cop detects a cookbook that depends on the `poise` library. Poise is no longer maintained and cookbooks that depend on it should be refactored to use standard Custom Resource functionality.

`Enabled by default`: True

`Autocorrects`: False

#### Chef/EasyInstallResource

The `EasyInstallResource` cop detects the usage of the `easy_install` resource, which was removed in Chef Infra Client 13. If you are using this resource you will need to find a new method of accomplishing the same functionality.

`Enabled by default`: True

`Autocorrects`: False

#### Chef/ErlCallResource

The `ErlCallResource` cop detects the usage of the `erl_call` resource, which was removed in Chef Infra Client 13. If you are using this resource you will need to find a new method of accomplishing the same functionality.

`Enabled by default`: True

`Autocorrects`: False

#### Chef/NamePropertyIsRequired

The `NamePropertyIsRequired` detects Custom Resource properties that are marked as both `required: true` and `name_property: true`. The name property functionality exists to provide an optional way to override the resource block name set in a recipe. Since this is an optional method, it does not make sense to mark the property as a required. If it's necessary for this property to always be passed just remove `name_property: true`.

`Enabled by default`: True

`Autocorrects`: False

#### Chef/PropertyWithRequiredAndDefault

The `PropertyWithRequiredAndDefault` cop detects resource properties that are set to `required: true` and also have a `default:` value set. Since these properties are required the default will never actually be used and shouldn't be set in the resource.

`Example`:

```ruby
property :type, String, required: true, default: 'cpu'
```

`Enabled by default`: True

`Autocorrects`: False

#### Chef/PropertyWithNameAttribute

The `PropertyWithNameAttribute` cop detects a property within a custom resource that defines a `name_attribute` instead of a `name_property`.

`Example`:

```ruby
property :command, String, name_attribute: true
```

`Enabled by default`: True

`Autocorrects`: True

#### Chef/EpicFail

The `EpicFail` cop detects usage of the legacy `epic_fail` method, which was aliases to `ignore_failure` many years ago. This method was removed in Chef Infra Client 15.

`Example`:

```ruby
execute '/bin/command_that_fails_often' do
  epic_fail true
end
```

`Enabled by default`: True

`Autocorrects`: True

#### Chef/UseBuildEssentialResource

The `UseBuildEssentialResource` cop detects usage of the legacy `default.rb` recipe in the `build-essential` cookbook. Chef Infra Client 14 shipped with a `build_essential` resource, which should be used instead.

`Example`:

```ruby
include_recipe 'build-essential'
include_recipe 'build-essential::default'
```

`Enabled by default`: True

`Autocorrects`: True

#### Chef/WhyRunSupportedTrue

The `WhyRunSupportedTrue` cop detects cookbooks that enable Why Run support within LWRPs and custom resources. Why Run support is enabled by default in Chef 13, and this configuration is no longer necessary.

`Enabled by default`: True

`Autocorrects`: True (deletes the occurrence)

#### Chef/NodeNormal

The `NodeNormal` detects the usage of `node.normal` level attributes. Normal level attributes persist to the node even if the cookbook code is removed and should be avoided unless there is an absolute need for their usage. Instead consider `default` or `override` levels.

`Enabled by default`: True

`Autocorrects`: False

#### Chef/NodeNormalUnless

The `NodeNormalUnless` detects the usage of `node.normal_unless` level attributes. Normal level attributes persist to the node even if the cookbook code is removed and should be avoided unless there is an absolute need for their usage. Instead consider `default_unless` or `override_unless` levels.

`Enabled by default`: True

`Autocorrects`: False

#### Chef/NodeSetUnless

The `NodeSetUnless` detects the usage of `node.set_unless` level attributes. The name `set` was unfortunate and did not correctly convey the functionality of the level. The `set` level of attributes was removed in Chef Infra Client 14 in favor of the `normal` level, which behaves the same, but has a more descriptive name. This cop will autocorrect `node.set_unless` to `node.normal_unless`

`Enabled by default`: True

`Autocorrects`: True

#### Chef/LegacyBerksfileSource

The `LegacyBerksfileSource` cop detects legacy source URLs in a `Berksfile`. These URLs continue to function, but often require redirects to point to the current Supermarket URL. This cop will autocorrect the URLs to supermarket.chef.io

`Examples`:

```ruby
source 'http://community.opscode.com/api/v3'
source 'https://supermarket.getchef.com'
source 'https://api.berkshelf.com'
```

`Enabled by default`: True

`Autocorrects`: True

#### Chef/InsecureCookbookURL

The `InsecureCookbookURL` cop detects non-HTTP GitHub and GitLab URLs in metadata.rb's `issue_url` and `source_url` fields.

`Examples`:

```ruby
source_url 'http://github.com/something/something'
source_url 'http://www.github.com/something/something'
source_url 'http://www.gitlab.com/something/something'
source_url 'http://gitlab.com/something/something'
```

`Enabled by default`: True

`Autocorrects`: True

#### Chef/CookbookUsesDatabags

The `CookbookUsesDatabags` is an optional cop for users wishing to migrate to the Effortless Infra pattern. This cop detects usage of Data Bags, which are incompatible with the Effortless pattern. This cop will need to be enabled in your `rubocop.yml` file or it can be run on the command line using `cookstyle --only Chef/CookbookUsesDatabags`

`Enabled by default`: False

`Autocorrects`: False

#### Chef/CookbookUsesSearch

The `CookbookUsesSearch` is an optional cop for users wishing to migrate to the Effortless Infra pattern. This cop detects usage of search, which is incompatible with the Effortless pattern. This cop will need to be enabled in your `rubocop.yml` file or it can be run on the command line using `cookstyle --only Chef/CookbookUsesSearch`

`Enabled by default`: False

`Autocorrects`: False
