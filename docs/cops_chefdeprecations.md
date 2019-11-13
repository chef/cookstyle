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

## ChefDeprecations/ChefHandlerUsesSupports

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Use the type property instead of the deprecated supports property in the chef_handler resource. The supports property was removed in chef_handler cookbook version 3.0 (June 2017) and Chef Infra Client 14.0.

### Examples

```ruby
# bad
chef_handler 'whatever' do
  supports start: true, report: true, exception: true
end0

# good
chef_handler 'whatever' do
  type start: true, report: true, exception: true
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.9.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/ChefSpecCoverageReport

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't use the deprecated ChefSpec Coverage report functionality in your specs. This feature has been removed as coverage reports encourage cookbook authors to write ineffective specs. Focus on testing your logic instead of achieving 100% code coverage.

### Examples

```ruby
# bad

at_exit { ChefSpec::Coverage.report! }
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.8.0` | String
Include | `**/spec/*.rb` | Array

## ChefDeprecations/ChefSpecLegacyRunner

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Use ChefSpec::SoloRunner or ChefSpec::ServerRunner instead of the deprecated ChefSpec::Runner. These new runners were introduced in ChefSpec 4.1 (Oct 2014).

### Examples

```ruby
# bad

describe 'foo::default' do
  subject { ChefSpec::Runner.new.converge(described_recipe) }

  # some spec code
end

# good

describe 'foo::default' do
  subject { ChefSpec::ServerRunner.new.converge(described_recipe) }

  # some spec code
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.8.0` | String
Include | `**/spec/*.rb` | Array

## ChefDeprecations/Cheffile

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

No documentation

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.12.0` | String
Include | `**/Cheffile` | Array

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

Cookbooks should not depend on the deprecated Poise framework cookbooks. They should instead be refactored to use standard Chef Infra custom resources.

### Examples

```ruby
# bad
depends 'poise'
depends 'poise-service'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/metadata.rb` | Array

## ChefDeprecations/DeprecatedYumRepositoryProperties

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

With the release of Chef Infra Client 12.14 and the yum cookbook 3.0 several properties in the yum_repository resource were renamed. url -> baseurl, keyurl -> gpgkey, and mirrorexpire -> mirror_expire.

### Examples

```ruby
# bad
yum_repository 'OurCo' do
  description 'OurCo yum repository'
  url 'http://artifacts.ourco.org/foo/bar'
  keyurl 'http://artifacts.ourco.org/pub/yum/RPM-GPG-KEY-OURCO-6'
  mirrorexpire 1440
  action :create
end

# good
yum_repository 'OurCo' do
  description 'OurCo yum repository'
  baseurl 'http://artifacts.ourco.org/foo/bar'
  gpgkey 'http://artifacts.ourco.org/pub/yum/RPM-GPG-KEY-OURCO-6'
  mirror_expire 1440
  action :create
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.10.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/EOLAuditModeUsage

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

The beta Audit Mode for Chef Infra Client was removed in Chef Infra Client 15.0. Users should instead use InSpec and the audit cookbook. See https://www.inspec.io/ for more informmation.

### Examples

```ruby
# bad
control_group 'Baseline' do
  control 'SSH' do
    it 'should be listening on port 22' do
      expect(port(22)).to be_listening
    end
  end
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.10.0` | String
Exclude | `**/metadata.rb` | Array

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

## ChefDeprecations/NamePropertyWithDefaultValue

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

A custom resource property can't be marked as a name_property and also have a default value. The name property is a special property that is derived from the name of the resource block in and thus always has a value passed to the resource. For example if you define `my_resource 'foo'` in recipe, then the name property of `my_resource` will automatically be set to `foo`. Setting a property to be both a name_property and have a default value will cause Chef Infra Client failures in 13.0 and later releases.

### Examples

```ruby
# bad
property :config_file, String, default: 'foo', name_property: true

# good
property :config_file, String, name_property: true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.7.0` | String
Include | `**/libraries/*.rb`, `**/providers/*.rb`, `**/resources/*.rb` | Array

## ChefDeprecations/NodeDeepFetch

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The node.deep_fetch method has been removed from Chef-Sugar, and must be replaced by
the node.read API.

### Examples

```ruby
# bad
node.deep_fetch("foo")

# good
node.read("foo")

# bad
node.deep_fetch!("foo")

# good
node.read!("foo")
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.12.0` | String
Exclude | `**/metadata.rb` | Array

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

## ChefDeprecations/PartialSearchClassUsage

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Legacy Chef::PartialSearch class usage should be updated to use the `search` helper instead with the `filter_result` key.

### Examples

```ruby
# bad
::Chef::PartialSearch.new.search((:node, 'role:web',
  keys: { 'name' => [ 'name' ],
          'ip' => [ 'ipaddress' ],
          'kernel_version' => %w(kernel version),
            }
).each do |result|
  puts result['name']
  puts result['ip']
  puts result['kernel_version']
end

# good
search(:node, 'role:web',
  filter_result: { 'name' => [ 'name' ],
                   'ip' => [ 'ipaddress' ],
                   'kernel_version' => %w(kernel version),
            }
).each do |result|
  puts result['name']
  puts result['ip']
  puts result['kernel_version']
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.11.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/PartialSearchHelperUsage

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Legacy partial_search usage should be updated to use :filter_result in the search helper instead

### Examples

```ruby
# bad
partial_search(:node, 'role:web',
  keys: { 'name' => [ 'name' ],
          'ip' => [ 'ipaddress' ],
          'kernel_version' => %w(kernel version),
            }
).each do |result|
  puts result['name']
  puts result['ip']
  puts result['kernel_version']
end

# good
search(:node, 'role:web',
  filter_result: { 'name' => [ 'name' ],
                   'ip' => [ 'ipaddress' ],
                   'kernel_version' => %w(kernel version),
            }
).each do |result|
  puts result['name']
  puts result['ip']
  puts result['kernel_version']
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.11.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/PoiseArchiveUsage

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

The poise_archive resource in the deprecated poise-archive should be replaced with the archive_file resource found in Chef Infra Client 15+.

### Examples

```ruby
# bad
poise_archive 'https://example.com/myapp.tgz' do
  destination '/opt/myapp'
end

# good
archive_file 'https://example.com/myapp.tgz' do
  destination '/opt/myapp'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.11.0` | String

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

## ChefDeprecations/RecipeMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The recipe metadata.rb method is not used and is unnecessary in cookbooks. Recipes should be documented
in the README.md file instead.

### Examples

```ruby
# bad
recipe 'openldap::default', 'Install and configure OpenLDAP'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
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

## ChefDeprecations/ResourceInheritsFromCompatResource

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Resources written in the class based HWRP style should inherit from the 'Chef::Resource' class and not the 'ChefCompat::Resource' class from the deprecated compat_resource cookbook.

### Examples

```ruby
# bad
class AptUpdate < ChefCompat::Resource
  # some resource code
end

# good
class AptUpdate < Chef::Resource
  # some resource code
end

# better
Write a custom resource using the custom resource DSL and avoid class based HWRPs entirely
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.10.0` | String
Include | `**/libraries/*.rb` | Array

## ChefDeprecations/ResourceOverridesProvidesMethod

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Some providers in resources override the provides? method, used to check whether they are a valid provider on the current platform. In Chef Infra Client 13, this will cause an error. Instead use `provides :SOME_PROVIDER_NAME` to register the provider.

### Examples

```ruby
# bad
def provides?
 true
end

# good
provides :SOME_PROVIDER_NAME
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.7.0` | String
Include | `**/libraries/*.rb`, `**/providers/*.rb`, `**/resources/*.rb` | Array

## ChefDeprecations/ResourceUsesDslNameMethod

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Don't use the dsl_name method in a resource to find the name of the resource. Use the resource_name method instead. dsl_name was removed in Chef Infra Client 13 and will now result in an error.

### Examples

```ruby
# bad
my_resource = MyResource.dsl_name

# good
my_resource = MyResource.resource_name
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.7.0` | String
Include | `**/libraries/*.rb`, `**/providers/*.rb`, `**/resources/*.rb` | Array

## ChefDeprecations/ResourceUsesProviderBaseMethod

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

The Resource.provider_base allows the developer to specify within a resource a module to load the resource's provider from. Instead, the provider should call provides to register itself, or the resource should call provider to specify the provider to use.

### Examples

```ruby
# bad
provider_base ::Chef::Provider::SomethingSomething
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.7.0` | String
Include | `**/libraries/*.rb`, `**/resources/*.rb` | Array

## ChefDeprecations/ResourceUsesUpdatedMethod

Enabled by default | Supports autocorrection
--- | ---
Disabled | No

Don't call the deprecated updated= method in a resource to set the resource to updated. This method was removed from Chef Infra Client 13 and this will now cause an error. Instead wrap code that updated the state of the node in a converge_by block. Documentation on using the converge_by block can be found at https://docs.chef.io/custom_resources.html.

### Examples

```ruby
# bad
action :foo do
  updated = true
end

# good
action :foo do
  converge_by('resource did something) do
    # code that causes the resource to converge
  end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.7.0` | String
Include | `**/libraries/*.rb`, `**/providers/*.rb`, `**/resources/*.rb` | Array

## ChefDeprecations/SearchUsesPositionalParameters

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

good

query(:node, '*:*')
 search(:node, '*:*', start: 0, rows: 1000, filter_result: { :ip_address => ["ipaddress"] })
 search(:node, '*:*', start: 0, rows: 1000)
 search(:node, '*:*', start: 0)

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.11.0` | String
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
use_inline_resources if respond_to?(:use_inline_resources)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Include | `**/libraries/*.rb`, `**/providers/*.rb`, `**/resources/*.rb` | Array

## ChefDeprecations/UserDeprecatedSupportsProperty

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

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

## ChefDeprecations/UsesRunCommandHelper

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Use 'shell_out!' instead of the legacy 'run_command' helper for shelling out. The run_command helper was removed in Chef Infra Client 13.

### Examples

```ruby
# bad
run_command('/bin/foo')

# good
shell_out!('/bin/foo')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.9.0` | String
Exclude | `**/metadata.rb`, `Rakefile` | Array

## ChefDeprecations/VerifyPropertyUsesFileExpansion

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

In Chef Infra Client 13 the "file" variable for use within the verify property was replaced with the "path" variable.

### Examples

```ruby
# bad
file '/etc/nginx.conf' do
  verify 'nginx -t -c %{file}'
end

# good
file '/etc/nginx.conf' do
  verify 'nginx -t -c %{path}'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.10.0` | String
Exclude | `**/metadata.rb` | Array

## ChefDeprecations/WindowsTaskChangeAction

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The :change action in the windows_task resource was removed when windows_task was added to Chef Infra Client 13+
The default action of :create should can now be used to create an update tasks.

### Examples

```ruby
# bad
windows_task 'chef ad-join leave start time' do
  task_name 'chef ad-join leave'
  start_day '06/09/2016'
  start_time '01:00'
  action [:change, :create]
end

# good
windows_task 'chef ad-join leave start time' do
  task_name 'chef ad-join leave'
  start_day '06/09/2016'
  start_time '01:00'
  action :create
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
Exclude | `**/metadata.rb` | Array
