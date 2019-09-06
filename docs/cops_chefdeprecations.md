# ChefDeprecations

## ChefDeprecations/AttributeMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't use the deprecated 'attribute' metadata value

### Examples

```ruby
# bad in metadata.rb:

 attribute 'zookeeper_bridge/server',
           display_name: 'zookeeper server',
           description: 'Zookeeper server address.',
           type: 'string',
           required: 'optional',
           default: '"127.0.0.1:2181"'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/metadata.rb` | Array

## ChefDeprecations/ChocolateyPackageUninstallAction

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Use the :remove action in the chocolatey_package resource instead of :uninstall which was removed in Chef Infra Client 14+

### Examples

```ruby
# bad
chocolatey_package 'nginx' do
  action :uninstall
end

# good
chocolatey_package 'nginx' do
  action :remove
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/ConflictsMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't use the deprecated 'conflicts' metadata value

### Examples

```ruby
# bad in metadata.rb:

conflicts "another_cookbook"
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/metadata.rb` | Array

## ChefDeprecations/CookbookDependsOnCompatResource

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't depend on the deprecated compat_resource cookbook made obsolete by Chef 12.19+

### Examples

```ruby
# bad
depends 'compat_resource'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/metadata.rb` | Array

## ChefDeprecations/CookbookDependsOnPartialSearch

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Don't depend on the partial_search cookbook made obsolete by Chef 13

### Examples

```ruby
# bad
depends 'partial_search'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/metadata.rb` | Array

## ChefDeprecations/CookbookDependsOnPoise

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Cookbooks should not depend on the deprecated Poise framework. They should instead
be refactored as standard custom resources.

### Examples

```ruby
# bad
depends 'poise'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/metadata.rb` | Array

## ChefDeprecations/EasyInstallResource

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Don't use the deprecated easy_install resource removed in Chef 13

### Examples

```ruby
# bad
easy_install "my_thing" do
  bar
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/EpicFail

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Make sure ignore_failure is used instead of epic_fail

### Examples

```ruby
# bad
package "foo" do
  epic_fail true
end

# good
package "foo" do
  ignore_failure true
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/ErlCallResource

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Don't use the deprecated erl_call resource

### Examples

```ruby
# bad
erl_call "foo" do
  bar
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/IncludingXMLRubyRecipe

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Do not include the deprecated xml::ruby recipe to install the nokogiri gem.
Chef Infra Client 12 and later ships with nokogiri included.

### Examples

```ruby
# bad
include_recipe 'xml::ruby'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/IncludingYumDNFCompatRecipe

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't include the deprecated yum DNF compatibility recipe, which is no longer necessary
as Chef Infra Client includes DNF package support

### Examples

```ruby
# bad
include_recipe 'yum::dnf_yum_compat'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.3.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/LaunchdDeprecatedHashProperty

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The launchd resource's hash property was renamed to plist_hash in Chef Infra Client 13+ to avoid conflicts with Ruby's hash class.

### Examples

```ruby
# bad
launchd 'foo' do
  hash foo: 'bar'
end

# good
launchd 'foo' do
  plist_hash foo: 'bar'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/LegacyYumCookbookRecipes

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

The Ohai default recipe previously allowed a user to ship custom Ohai plugins to a system by including them
in a directory in the Ohai cookbook. This functionality was replaced with the ohai_plugin resource, which
should be used instead as it doesn't require forking the ohai cookbook.

### Examples

```ruby
# bad
include_recipe 'yum::elrepo'
include_recipe 'yum::epel'
include_recipe 'yum::ius'
include_recipe 'yum::remi'
include_recipe 'yum::repoforge'
include_recipe 'yum::yum'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/LocaleDeprecatedLcAllProperty

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

The local resource's lc_all property has been deprecated and will be removed in Chef Infra Client 16

### Examples

```ruby
# bad
locale 'set locale' do
  lang 'en_gb.utf-8'
  lc_all 'en_gb.utf-8'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/LongDescriptionMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The long_description metadata.rb method is not used and is unnecessary in cookbooks

### Examples

```ruby
# bad
long_description 'this is my cookbook and this description will never be seen'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/metadata.rb` | Array

## ChefDeprecations/NodeMethodsInsteadofAttributes

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Incorrectly using node methods for Ohai data when you really want node attributes

### Examples

```ruby
# bad
node.fqdn
node.platform
node.platform_family
node.platform_version
node.hostname

# good
node['fqdn']
node['platform']
node['platform_family']
node['platform_version']
node['hostname']
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/NodeSet

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The node.set method has been removed in Chef-13 and must be replaced by node.normal.

Note that node.normal keeps the semantics identical, but the use of node.normal is
also discouraged.

### Examples

```ruby
# bad
node.set['foo'] = true

# good
node.normal['foo'] = true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.0.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/NodeSetUnless

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The node.set_unless method has been removed in Chef-13 and must be replaced by node.normal_unless.

Note that node.normal_unless keeps the semantics identical, but the use of node.normal is
also discouraged.

### Examples

```ruby
# bad
node.set_unless['foo'] = true

# good
node.normal_unless['foo'] = true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/ProvidesMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't use the deprecated 'provides' metadata value

### Examples

```ruby
# bad in metadata.rb:

provides "some_thing"
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/metadata.rb` | Array

## ChefDeprecations/ReplacesMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't use the deprecated 'replaces' metadata value

### Examples

```ruby
# bad in metadata.rb:

replaces "another_cookbook"
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/metadata.rb` | Array

## ChefDeprecations/RequireRecipe

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Make sure to use include_recipe instead of require_recipe

### Examples

```ruby
# bad
require_recipe 'foo'

# good
include_recipe 'foo'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/SuggestsMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't use the deprecated 'suggests' metadata value

### Examples

```ruby
# bad in metadata.rb:

suggests "another_cookbook"
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/metadata.rb` | Array

## ChefDeprecations/UseInlineResourcesDefined

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

use_inline_resources became the default in Chef Infra Client 13+ and no longer needs
to be called in resources

### Examples

```ruby
# bad
use_inline_resources
use_inline_resources if defined?(use_inline_resources)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Include | `**/libraries/*.rb`, `**/providers/*.rb`, `**/resources/*.rb` | Array

## ChefDeprecations/UserDeprecatedSupportsProperty

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

The supports property was removed in Chef Infra Client 13 in favor of individual 'manage_home' and 'non_unique' properties.

### Examples

```ruby
# bad
user "betty" do
  supports({
    manage_home: true,
    non_unique: true
  })
end

# good
user "betty" do
  manage_home true
  non_unique true
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/UsesChefRESTHelpers

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Chef::REST was removed in Chef Infra Client 13.

### Examples

```ruby
# bad
require 'chef/rest'
Chef::REST::RESTRequest.new(:GET, FOO, nil).call
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/UsesDeprecatedMixins

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't use deprecated Mixins no longer included in Chef Infra Client 14 and later

### Examples

```ruby
# bad
include Chef::Mixin::LanguageIncludeAttribute
include Chef::Mixin::RecipeDefinitionDSLCore
include Chef::Mixin::LanguageIncludeRecipe
include Chef::Mixin::Language
include Chef::DSL::Recipe::FullDSL
require 'chef/mixin/language'
require 'chef/mixin/language_include_attribute'
require 'chef/mixin/language_include_recipe'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Include | `**/libraries/*.rb`, `**/providers/*.rb`, `**/resources/*.rb` | Array
