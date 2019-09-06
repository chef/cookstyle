# Chef

## Chef/AttributeKeys

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Check which style of keys are used to access node attributes.

There are two supported styles: "symbols" and "strings".

### Examples

#### when configuration is `EnforcedStyle: symbols`

```ruby
# bad
node['foo']
node["foo"]

# good
node[:foo]
```
#### when configuration is `EnforcedStyle: strings`

```ruby
# bad
node[:foo]

# good
node['foo']
node["foo"]
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `strings` | `strings`, `symbols`
VersionAdded | `5.0.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/AttributeMetadata

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

## Chef/BlockGuardWithOnlyString

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

A resource guard (not_if/only_if) that is a string should not be wrapped in {}.
Wrapping a guard string in {} causes it be executed as Ruby code which will always returns true instead of a shell command that will actually run.

### Examples

```ruby
# bad
template '/etc/foo' do
  mode '0644'
  source 'foo.erb'
  only_if { 'test -f /etc/foo' }
end

# good
template '/etc/foo' do
  mode '0644'
  source 'foo.erb'
  only_if 'test -f /etc/foo'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/ChocolateyPackageUninstallAction

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

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

## Chef/CommentFormat

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Checks for incorrectly formatted headers

### Examples

```ruby
# bad
Copyright 2013-2016 Chef Software, Inc.
Recipe default.rb
Attributes default.rb
License Apache2
Cookbook tomcat
Cookbook Name:: Tomcat
Attributes File:: default

# good
Copyright:: 2013-2016 Chef Software, Inc.
Recipe:: default.rb
Attributes:: default.rb
License:: Apache License, Version 2.0
Cookbook:: Tomcat
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.0.0` | String

## Chef/CommentSentenceSpacing

Enabled by default | Supports autocorrection
--- | ---
Disabled | Yes

Replaces double spaces between sentences with a single space.
Note: This is DISABLED by default.

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String

## Chef/ConflictsMetadata

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

## Chef/CookbookDependsOnCompatResource

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

## Chef/CookbookDependsOnPartialSearch

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

## Chef/CookbookDependsOnPoise

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

## Chef/CookbookUsesDatabags

Enabled by default | Supports autocorrection
--- | ---
Disabled | No

Data bags cannot be used with the Effortless Infra pattern

### Examples

```ruby
# bad
data_bag_item('admins', login)
data_bag(data_bag_name)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String

## Chef/CookbookUsesNodeSave

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Don't use node.save to save partial node data to the Chef Infra Server mid-run unless it's
absolutely necessary. Node.save can result in failed Chef Infra runs appearing in search and
increases load on the Chef Infra Server."

### Examples

```ruby
# bad
node.save
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/CookbookUsesSearch

Enabled by default | Supports autocorrection
--- | ---
Disabled | No

Search is not compatible with the Effortless Infra pattern

### Examples

```ruby
# bad
search(:node, 'run_list:recipe\[bacula\:\:server\]')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String

## Chef/CookbooksDependsOnSelf

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Make sure a cookbook doesn't depend on itself. This will fail on Chef Infra Client 13+

### Examples

```ruby
# bad
name 'foo'
depends 'foo'

# good
name 'foo'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/metadata.rb` | Array

## Chef/CopyrightCommentFormat

Enabled by default | Supports autocorrection
--- | ---
Disabled | Yes

Checks for incorrectly formatted copyright comments.

### Examples

```ruby
# bad (assuming current year is 2019)
Copyright:: 2013-2019 Opscode, Inc.
Copyright:: 2013-2019 Chef Inc.
Copyright:: 2013-2019 Chef Software Inc.
Copyright:: 2009-2010 2013-2019 Chef Software Inc.
Copyright:: Chef Software Inc.
Copyright:: Tim Smith
Copyright:: Copyright (c) 2015-2019 Chef Software, Inc.

# good (assuming current year is 2019)
Copyright:: 2013-2019 Chef Software, Inc.
Copyright:: 2013-2019 Tim Smith
Copyright:: 2019 37Signals, Inc.
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.0.0` | String

## Chef/CustomResourceWithAllowedActions

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

In HWRPs and LWRPs it was necessary to define the allowed actions within the resource.
In custom resources this is no longer necessary as Chef will determine it based on the
actions defined in the resource.

### Examples

```ruby
# bad
property :something, String

allowed_actions [:create, :remove]
action :create do
  # some action code because we're in a custom resource
end

# also bad
property :something, String

actions [:create, :remove]
action :create do
  # some action code because we're in a custom resource
end

# good
property :something, String

action :create do
  # some action code because we're in a custom resource
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/resources/*.rb` | Array

## Chef/CustomResourceWithAttributes

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

In HWRPs and LWRPs you defined attributes, but custom resources changed the name to
be properties to avoid confusion with chef recipe attributes. When writing a custom resource
they should be called properties even though the two are aliased.

### Examples

```ruby
# bad
attribute :something, String

action :create do
  # some action code because we're in a custom resource
end

# good
property :something, String

action :create do
  # some action code because we're in a custom resource
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/resources/*.rb` | Array

## Chef/DefaultMetadataMaintainer

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Metadata contains default maintainer information from the `chef generate cookbook`
command. This should be updated to reflect that actual maintainer of the cookbook.

### Examples

```ruby
# bad
maintainer 'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
maintainer 'The Authors'
maintainer_email 'you@example.com'
# good
maintainer 'Bob Bobberson'
maintainer_email 'bob@bobberson.com'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Include | `**/metadata.rb` | Array

## Chef/DefinesChefSpecMatchers

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

ChefSpec 7.1 and later auto generate ChefSpec matchers. Matchers in cookbooks can now be removed.

### Examples

```ruby
# bad
if defined?(ChefSpec)
  def create_yum_repository(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:yum_repository, :create, resource_name)
  end
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.3.0` | String
Include | `**/libraries/*.rb` | Array

## Chef/EasyInstallResource

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

## Chef/EpicFail

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

## Chef/ErlCallResource

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

## Chef/ExecuteAptUpdate

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Instead of using the execute resource to to run the `apt-get update` use Chef Infra Client's built-n
apt_update resource which is available in Chef Infra Client 12.7 and later.

  # bad
  execute 'apt-get update'

  # good
  apt_update

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.3.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/FileMode

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Check the file modes are given as strings instead of integers.

### Examples

```ruby
# bad
mode 644
mode 0644

# good
mode '644'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.0.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/IncludingAptDefaultRecipe

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Don't include the apt default recipe to update apt's package cache when you can
use the apt_update resource built into Chef Infra Client 12.7 and later.

### Examples

```ruby
# bad
include_recipe 'apt::default'
include_recipe 'apt'

# good
apt_update
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.3.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/IncludingMixinShelloutInResources

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

There is no need to include Chef::Mixin::ShellOut in resources or providers as this is already done by Chef Infra Client.

### Examples

```ruby
# bad
require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Include | `**/resources/*.rb`, `**/providers/*.rb` | Array

## Chef/IncludingOhaiDefaultRecipe

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

The Ohai default recipe previously allowed a user to ship custom Ohai plugins to a system by including them
in a directory in the Ohai cookbook. This functionality was replaced with the ohai_plugin resource, which
should be used instead as it doesn't require forking the ohai cookbook.

### Examples

```ruby
# bad
include_recipe 'ohai::default'
include_recipe 'ohai'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/IncludingWindowsDefaultRecipe

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't include the windows default recipe that is either full of gem install that are part
of the Chef Infra Client, or empty (depends on version).

### Examples

```ruby
# bad
include_recipe 'windows::default'
include_recipe 'windows'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.3.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/IncludingXMLRubyRecipe

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The xml::ruby recipe was used to install nokogiri into the Chef installation. Nokogiri is included
in Chef Infra Client 12 and later so this recipe is no longer necessary.

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

## Chef/IncludingYumDNFCompatRecipe

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't include the yum DNF compatibility recipe, which is no longer necessary
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

## Chef/InsecureCookbookURL

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Use secure Github and Gitlab URLs for source_url and issues_url

### Examples

```ruby
# bad
source_url 'http://github.com/something/something'
source_url 'http://www.github.com/something/something'
source_url 'http://www.gitlab.com/something/something'
source_url 'http://gitlab.com/something/something'

# good
source_url 'http://github.com/something/something'
source_url 'http://gitlab.com/something/something'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/metadata.rb` | Array

## Chef/InvalidLicenseString

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

metadata.rb license field should include a SPDX compliant string
or "all right reserved" (not case sensitive)

list of valid SPDX.org license strings. To build an array run this:
require 'json'
require 'net/http'
json_data = JSON.parse(Net::HTTP.get(URI('https://raw.githubusercontent.com/spdx/license-list-data/master/json/licenses.json')))
licenses = json_data['licenses'].map {|l| l['licenseId'] }.sort

### Examples

```ruby
# bad
license 'Apache 2.0'

# good
license 'Apache-2.0'
license 'all rights reserved'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/metadata.rb` | Array

## Chef/InvalidPlatformMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

metadata.rb supports methods should contain valid platforms

### Examples

```ruby
# bad
supports 'darwin'
supports 'mswin'

# good
supports 'mac_os_x'
supports 'windows'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/metadata.rb` | Array

## Chef/LaunchdDeprecatedHashProperty

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

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

## Chef/LegacyBerksfileSource

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Over the course of years there have been many different valid community site / Supermarket
URLs to use in a cookbook's Berksfile. These old URLs continue to function via redirects,
but should be updated to point to the latest Supermarket URL.

### Examples

```ruby
# bad
source 'http://community.opscode.com/api/v3'
source 'https://supermarket.getchef.com'
source 'https://api.berkshelf.com'

# good
source 'https://supermarket.chef.io'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/Berksfile` | Array

## Chef/LegacyYumCookbookRecipes

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

## Chef/LibarchiveFileResource

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Use the archive_file resource built into Chef Infra Client 15+ instead of the libarchive_file resource

### Examples

```ruby
# bad
libarchive "C:\file.zip" do
  path 'C:\expand_here'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/LocaleDeprecatedLcAllProperty

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

## Chef/LongDescriptionMetadata

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

## Chef/MetadataMissingName

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

metadata.rb needs to include the name method

### Examples

```ruby
# good
name 'foo'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/metadata.rb` | Array

## Chef/MinitestHandlerUsage

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Use Chef InSpec for testing instead of the Minitest Handler cookbook pattern.

### Examples

```ruby
# bad
depends 'minitest-handler'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Include | `**/metadata.rb` | Array

## Chef/NamePropertyIsRequired

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

When using properties in a custom resource you shouldn't set a property to
be both required and a name_property. Name properties are a way to optionally
override the name given to the resource block in cookbook code. In your resource
code you use the name_property and if the user doesn't pass in anything to that
property its value will be populated with resource block's name. This
allows users to provide more friendly resource names for logging that give
additional context on the change being made.

How about a nice example! Here we have a resource called ntp_config that has a
name_property of config_file. All throughout the code of this resource we'd
use new_resource.config_file when referencing the path to the config.

We can use a friendly name for the block and specific a value to config_file
ntp_config 'Configure the main config file' do
  config_file '/etc/ntp/ntp.conf'
  action :create
end

We can also just set the config path as the resource block and Chef will
make sure to pass this in as new_resource.config_file as well.
ntp_config '/etc/ntp/ntp.conf' do
  action :create
end

The core tenant of the name property feature is that these properties are optional
and making them required effectively turns off the functionality provided by name
properties. If the goal is to always require the user to pass the config_file property
then it should just be made a required property and not a name_property.

### Examples

```ruby
# bad
property :config_file, String, required: true, name_property: true

# good
property :config_file, String, required: true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String

## Chef/NodeMethodsInsteadofAttributes

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

## Chef/NodeNormal

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Normal attributes are discouraged since their semantics differ importantly from the
default and override levels.  Their values persist in the node object even after
all code referencing them has been deleted, unlike default and override.

Code should be updated to use default or override levels, but this will change
attribute merging behavior so needs to be validated manually and force_default or
force_override levels may need to be used in recipe code.

### Examples

```ruby
# bad
node.normal['foo'] = true

# good
node.default['foo'] = true
node.override['foo'] = true
node.force_default['foo'] = true
node.force_override['foo'] = true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/NodeNormalUnless

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Normal attributes are discouraged since their semantics differ importantly from the
default and override levels.  Their values persist in the node object even after
all code referencing them has been deleted, unlike default and override.

Code should be updated to use default or override levels, but this will change
attribute merging behavior so needs to be validated manually and force_default or
force_override levels may need to be used in recipe code.

### Examples

```ruby
# bad
node.normal_unless['foo'] = true

# good
node.default_unless['foo'] = true
node.override_unless['foo'] = true
node.force_default_unless['foo'] = true
node.force_override_unless['foo'] = true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/NodeSet

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

## Chef/NodeSetUnless

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

## Chef/PowershellInstallPackage

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Use the powershell_package resource built into Chef Infra Client instead of the powershell_script
resource to run Install-Package

 # good
 powershell_package 'docker'

### Examples

```ruby
# bad
powershell_script 'Expand website' do
  code 'Install-Package -Name docker'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/PowershellInstallWindowsFeature

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Use the windows_feature resource built into Chef Infra Client 15+ instead of the powershell_script resource
to run Install-WindowsFeature or Add-WindowsFeature

 # good
 windows_feature 'Net-framework-Core' do
   action :install
   install_method :windows_feature_powershell
 end

### Examples

```ruby
# bad
powershell_script 'Install Feature' do
  code 'Install-WindowsFeature -Name "Net-framework-Core"'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/PowershellScriptExpandArchive

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Use the archive_file resource built into Chef Infra Client 15+ instead of using the powershell_script
resource to run Expand-Archive

### Examples

```ruby
# bad
powershell_script 'Expand website' do
  code 'Expand-Archive "C:\\file.zip" -DestinationPath "C:\\inetpub\\wwwroot\\" -Force'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/PropertyWithNameAttribute

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

When using properties in a custom resource you should use name_property not
the legacy name_attribute from the days of attributes

### Examples

```ruby
# bad
property :bob, String, name_attribute: true

# good
property :bob, String, name_property: true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

## Chef/PropertyWithRequiredAndDefault

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

When using properties in a custom resource you shouldn't set a property to
required and then provide a default value. If a property is required the
user will always pass in a value and the default will never be used. In Chef
Infra Client 13+ this became an error.

### Examples

```ruby
# bad
property :bob, String, required: true, default: 'foo'

# good
property :bob, String, required: true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

## Chef/ProvidesMetadata

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

## Chef/ReplacesMetadata

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

## Chef/RequireRecipe

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

## Chef/ResourceSetsInternalProperties

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Chef Infra Client uses properties in several resources to track state. These
should not be set in recipes as they break the internal workings of the Chef
Infra Client

### Examples

```ruby
# bad
service 'foo' do
  running true
  action [:start, :enable]
end

# good
service 'foo' do
  action [:start, :enable]
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/ResourceSetsNameProperty

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Use name properties instead of setting the name property in a resource. Setting the name property
directly causes notification and reporting issues.

### Examples

```ruby
# bad
service 'foo' do
 name 'bar'
end

# good
service 'foo' do
 service_name 'bar'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/ResourceWithNoneAction

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

The :nothing action is often typo'd as :none

### Examples

```ruby
# bad
service 'foo' do
 action :none
end

# good
service 'foo' do
 action :nothing
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/RespondToInMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

It is not longer necessary respond_to?(:foo) in metadata. This was used to support new metadata
methods in Chef 11 and early versions of Chef 12.

### Examples

```ruby
# bad
chef_version '>= 13' if respond_to?(:chef_version)

# good
chef_version '>= 13'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/metadata.rb` | Array

## Chef/RespondToProvides

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

It is not longer necessary respond_to?(:foo) in metadata. This was used to support new metadata
methods in Chef 11 and early versions of Chef 12.

### Examples

```ruby
# bad
provides :foo if respond_to?(:provides)

# good
provides :foo
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/providers/*.rb`, `**/libraries/*.rb` | Array

## Chef/RespondToResourceName

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Chef 12.5 introduced the resource_name method for resources. Many cookbooks used
respond_to?(:resource_name) to provide backwards compatibility with older chef-client
releases. This backwards compatibility is no longer necessary.

### Examples

```ruby
# bad
resource_name :foo if respond_to?(:resource_name)

# good
resource_name :foo
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

## Chef/ServiceResource

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Use a service resource to start and stop services

### Examples

#### when command starts a service

```ruby
# bad
command "/etc/init.d/mysql start"
command "/sbin/service/memcached start"
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.0.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/SetOrReturnInResources

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

set_or_return within a method should not be used to define property in a resource. Instead use
the property method which properly validates and defines properties in a way that works with
reporting and documentation functionality in Chef Infra Client

### Examples

```ruby
# bad
 def severity(arg = nil)
   set_or_return(
     :severity, arg,
     :kind_of => String,
     :default => nil
   )
 end

# good
property :severity, String
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

## Chef/SevenZipArchiveResource

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Use the archive_file resource built into Chef Infra Client 15+ instead of the seven_zip_archive

### Examples

```ruby
# bad
seven_zip_archive "C:\file.zip" do
  path 'C:\expand_here'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/ShellOutToChocolatey

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Use the Chocolatey resources built into Chef Infra Client instead of shelling out to the choco command

 powershell_script 'add artifactory choco source' do
   code "choco source add -n=artifactory -s='https://mycorp.jfrog.io/mycorp/api/nuget/chocolatey-remote' -u foo -p bar"x
   not_if 'choco source list | findstr artifactory'
 end

### Examples

```ruby
# bad
execute 'install package foo' do
  command "choco install --source=artifactory \"foo\" -y --no-progress --ignore-package-exit-codes"
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/SuggestsMetadata

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

## Chef/TmpPath

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Use file_cache_path rather than hard-coding tmp paths

### Examples

#### downloading a large file into /tmp/

```ruby
# bad
remote_file '/tmp/large-file.tar.gz' do

# good
remote_file "#{Chef::Config[:file_cache_path]}/large-file.tar.gz" do
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.0.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/UnnecessaryDependsChef14

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't depend on cookbooks made obsolete by Chef 14

### Examples

```ruby
# bad
depends 'build-essential'
depends 'chef_handler'
depends 'chef_hostname'
depends 'dmg'
depends 'mac_os_x'
depends 'swap'
depends 'sysctl'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/metadata.rb` | Array

## Chef/UseBuildEssentialResource

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Use secure Github and Gitlab URLs for source_url and issues_url

### Examples

```ruby
# bad
depends 'build-essential'
include_recipe 'build-essential::default'
include_recipe 'build-essential'

# good
build_essential 'install compilation tools'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/UseInlineResourcesDefined

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

## Chef/UserDeprecatedSupportsProperty

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

## Chef/UsesChefRESTHelpers

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

## Chef/UsesDeprecatedMixins

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
Include | `**/libraries/*.rb`, `**/providers/*.rb` | Array

## Chef/WhyRunSupportedTrue

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

whyrun_supported? no longer needs to be set to true as that is the default in Chef Infra Client 13+

### Examples

```ruby
# bad
def whyrun_supported?
 true
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/resources/*.rb`, `**/providers/*.rb`, `**/libraries/*.rb` | Array

## Chef/WindowsVersionHelper

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Use node['platform_version] data instead of the Windows::VersionHelper helper from the Windows cookbook.

### Examples

```ruby
# bad
Windows::VersionHelper.nt_version

# good
node['platform_version].to_i
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Exclude | `**/metadata.rb` | Array

## Chef/WindowsZipfileUsage

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Use the archive_file resource built into Chef Infra Client 15+ instead of the windows_zipfile from the Windows cookbook

### Examples

```ruby
# bad
windows_zipfile 'C:\\files\\' do
  source 'C:\\Temp\\file.zip'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Exclude | `**/metadata.rb` | Array
