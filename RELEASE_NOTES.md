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

The `ChefStyle/UnnecessaryOSCheck` cop checks cookbooks that use `node['os']` to check the operating system of a node, when they could instead use the `platform_family?()` helper. All values of `os` from Ohai match one-to-one with `platform_family` values, except for `linux` which has no single equivalent `plaform_family`.

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

- The `ChefModernize/ExecuteSysctl` cop will now detect `execute` resources that call systctl using the full path to the binary.
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

Rubocop comment to disable a cop:

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

The `Definitions` cop detects cookbooks that include Definitions. We highly recommend replacing legacy Definitions with Custom Resources. Definitions are not *currently* deprecated, but we do plan to deprecate this functionality in the future. See [Converting Definitions to Custom Resources](https://docs.chef.io/definitions.html) for more information on the benefits of Custom Resources and how to convert legacy Definitions.

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

#### ChefEffortless/CookbookUsesEnvironmments

`CookbookUsesEnvironmments` is a disabled by default cop that helps users migrating to the Chef Infra Effortless pattern by detecting cookbooks that use Chef Infra Environnments.

`Enabled by default`: False

`Autocorrects`: No

#### ChefEffortless/CookbookUsesPolicygroups

`CookbookUsesPolicygroups` is a disabled by default cop that helps users migrating to the Chef Infra Effortless pattern by detecting cookbooks that use Chef Infra Policy Groups.

`Enabled by default`: False

`Autocorrects`: No

#### ChefEffortless/CookbookUsesRoles

`CookbookUsesRoles` is a disabled by default cop that helps users migrating to the Chef Infra Effortless pattern by detecting cookbooks that use Chef Infra Roles.

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

The `SimplifyPlatformMajorVersionCheck` cop detects overly complex code for determing the major version of a platform using the `node['platform_version']` attribute. The cop will detect the following methods for selecting the major version from `node['platform_version']`:

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
- The docs at [https://github.com/chef/cookstyle/blob/master/docs/cops.md](https://github.com/chef/cookstyle/blob/master/docs/cops.md) are now auto generated on each pull request merge

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

The `ChefModernize/ExecuteTzUtil` cop detects a cookbook that uses an `execute` resource to shell out to the `tzutil.exe` command. Chef Infra Client 14.6 and later ships with the [timezone resource](https://docs.chef.io/resource_timezone.html), which should be used instead of `tzutil`.

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

Documentation for all Chef cops can now be found in the Cookstyle repos's [docs directory](https://github.com/chef/cookstyle/blob/master/docs/cops.md)

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

- [chocolatey_config](https://docs.chef.io/resource_chocolatey_config.html)
- [chocolatey_feature](https://docs.chef.io/resource_chocolatey_feature.html)
- [chocolatey_package](https://docs.chef.io/resource_chocolatey_package.html)
- [chocolatey_source](https://docs.chef.io/resource_chocolatey_source.html)

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

The `IncludingXMLRubyRecipe` cop detects cookbooks that include the `xml::ruby` recipe. This recipe was used to install the `nokogiri` gem into Chef Infra Client for use in parsing XML in cookbooks. Nokogori ships with Chef Infra Client 13+, so this recipe is no longer necessary.

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

The `MinitestHandlerUsage` cop detects cookbooks that depend on the [minitest-handler](https://supermarket.chef.io/cookbooks/minitest-handler) cookbook. This cookbook provides a handler for running [minitests](https://github.com/seattlerb/minitest) after each Chef Infra Client run. The handler is no longer maintained and we highly recommend using InSpec for validating a system configuration after a Chef Infra Client run. InSpec includes over 100 built-in resources and integrates with Automate to report the results of a system state validation.

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

The `WindowsZipfileUsage` detects the usage of the `windows_zipfile` resource in the [Windows](https://supermarket.chef.io/cookbooks/windows) cookbook. This is one of the remaining resources in the windows cookbook that is not present in Chef Infra Client itself. In Chef Infra Client 15.0 we introduced the [archive_file](https://docs.chef.io/resource_archive_file.html) resource, which is a cross platform resource for uncompressing archives. This resource uses an ulta-fast compression library with support for multiple compression formats, and should be used instead of the legacy `windows_zipfile` resource.

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
- Chef/MetadataMissingName now supports autocorrecting. The folder containing the metadata.rb will be used as the cookbook name if it's missing from metdata.rb
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

`Autocorrects`: True (deletes the occurance)

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
excute '/bin/command_that_fails_often' do
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
