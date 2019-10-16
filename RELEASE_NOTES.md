## Cookstyle 5.9

### 3 New Chef Cops

#### ChefModernize/PowerShellGuardInterpreter

The `PowerShellGuardInterpreter` cop detects `powershell_script` resources that set the `guard_interpreter` property to `:powershell_script`. In Chef Infra Client 13 and later, `:powershell_script` is the default and does not need to be set.

`Enabled by default`: True

`Autocorrects`: Yes

#### ChefDeprecations/UsesRunCommandHelper

The `UsesRunCommandHelper` cop detects recipes and resources that use the legacy `run_command` helper, which was removed in Chef Infra Client 13. Users should instead use the `shell_out` or `shell_out!` helpers which use the `mixlib-shellout` Ruby gem under the hood.

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
- The docs at https://github.com/chef/cookstyle/blob/master/docs/cops.md are now auto generated on each pull request merge

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
