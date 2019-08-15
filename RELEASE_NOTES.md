## Cookstyle 5.2

### New Chef Cops

#### Chef/InvalidPlatformMetadata

The `InvalidPlatformMetadata` cop detects invalid platform names in the supports metadata.rb method. It uses a hardcoded set of common typos so it can't detect all invalid platforms, but it does detect the most common mistakes found on the Supermarket.

`Enabled by default`: True

`Autocorrects`: True (deletes the occurrence)

#### Chef/RespondToResourceName

The `RespondToResourceName` cop detects the usage of respond_to?(:resource_name) in resources to provide backwards compatibility. This `respond_to?` check is no longer necessary in Chef Infra Client 12.5+

`Enabled by default`: True

`Autocorrects`: True (deletes the `if respond_to?` occurence)

#### Chef/RespondToProvides

The `RespondToProvides` cop detects the usage of respond_to?(:provides) in providers to provide backwards compatibility. This `respond_to?` check is no longer necessary in Chef Infra Client 12+

`Enabled by default`: True

`Autocorrects`: True (deletes the `if respond_to?` occurence)

#### Chef/RespondToInMetadata

The `RespondToInMetadata` cop detects the usage of `if respond_to?(:foo)` to prevent newer metadata methods from running on Chef Infra Client versions older than 12.15. The chef-client doesn't fail when it encounters unknown metadata in Chef Infra Client versions 12.15.

`Enabled by default`: True

`Autocorrects`: True (deletes the `if respond_to?` occurence)

#### Chef/LongDescriptionMetadata

The `LongDescriptionMetadata` cop detects usage of `long_description` in metadata.rb. The `long_description` metadata was never utilized by Chef Infra or Supermarket, but cookbooks commonly load their README.md file into the metadata. This increases the size of metadata stored on Chef Infra Server and provides no benefit to users.

`Enabled by default`: True

`Autocorrects`: True (deletes the `if respond_to?` occurence)

#### Chef/CookbooksDependsOnSelf

The `CookbooksDependsOnSelf` cop detects a cookbook that depends on itself in metadata.rb.

`Enabled by default`: True

`Autocorrects`: False

#### Chef/MetadataMissingName

The `MetadataMissingName` cop detects metadata.rb which is missing the name field required by Chef Infra Client 12+

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

The `SetOrReturnInResources` cop detects the usage of the `set_or_return` helper method in resources to create properties instead of using the `property` method. This was traditionally done when writing HWRPs, but properties created this way lack additional validation, reporting, and documentation functionality.

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

- The configuration file has been improved to properly verify LWRP/HWRP files
- Several Chef/* cops are now properly enabled in the config file
- Chef/UseBuildEssentialResource is now enabled by default
- Chef/NodeSetUnless and Chef/NodeSet have been improved to properly correct usage of node.set in ChefSpec tests

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

The `InsecureCookbookURL` cop detects non-HTTP GitHub and Gitlab URLs in metadata.rb's `issue_url` and `source_url` fields.

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
