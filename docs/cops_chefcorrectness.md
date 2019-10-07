# ChefCorrectness

## ChefCorrectness/BlockGuardWithOnlyString

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

A resource guard (not_if/only_if) that is a string should not be wrapped in {}. Wrapping a guard string in {} causes it be executed as Ruby code which will always returns true instead of a shell command that will actually run.

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

## ChefCorrectness/CookbookUsesNodeSave

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

## ChefCorrectness/CookbooksDependsOnSelf

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

No documentation

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/metadata.rb` | Array

## ChefCorrectness/DefaultMetadataMaintainer

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Metadata contains default maintainer information from the `chef generate cookbook` command. This should be updated to reflect that actual maintainer of the cookbook.

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

## ChefCorrectness/EmptyMetadataField

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

metadata.rb should not include fields with an empty string. Either don't include the field or add a value.

### Examples

```ruby
# bad
license ''

# good
license 'Apache-2.0'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.8.0` | String
Include | `**/metadata.rb` | Array

## ChefCorrectness/IncludingOhaiDefaultRecipe

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

## ChefCorrectness/InsecureCookbookURL

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

## ChefCorrectness/InvalidLicenseString

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

metadata.rb license field should include a SPDX compliant string or "all right reserved" (not case sensitive)

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

## ChefCorrectness/InvalidPlatformMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

metadata.rb supports methods should contain valid platforms.

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

## ChefCorrectness/InvalidVersionMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Cookbook metadata.rb version field should follow X.Y.Z version format.

### Examples

```ruby
# bad
version '1.2.3.4'

# good
version '1.2.3'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.8.0` | String
Include | `**/metadata.rb` | Array

## ChefCorrectness/MetadataMissingName

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

No documentation

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/metadata.rb` | Array

## ChefCorrectness/NamePropertyIsRequired

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

## ChefCorrectness/NodeNormal

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

## ChefCorrectness/NodeNormalUnless

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

## ChefCorrectness/PropertyWithNameAttribute

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

## ChefCorrectness/PropertyWithRequiredAndDefault

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

## ChefCorrectness/ResourceSetsInternalProperties

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

## ChefCorrectness/ResourceSetsNameProperty

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

## ChefCorrectness/ResourceWithNoneAction

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

## ChefCorrectness/ServiceResource

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

## ChefCorrectness/TmpPath

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

## ChefCorrectness/UnnecessaryNameProperty

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

There is no need to define a property named :name in a resource as Chef Infra defines that property for all resources out of the box.

### Examples

```ruby
# bad
property :name, String
property :name, String, name_property: true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.8.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array
