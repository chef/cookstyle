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

## ChefCorrectness/DnfPackageAllowDowngrades

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

dnf_package does not support the allow_downgrades property

### Examples

```ruby
# bad
dnf_package 'nginx' do
  version '1.2.3'
  allow_downgrades true
end

# good
dnf_package 'nginx' do
  version '1.2.3'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Exclude | `**/attributes/*.rb`, `**/metadata.rb`, `**/Berksfile` | Array

## ChefCorrectness/IncorrectLibraryInjection

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Libraries should be injected into the Chef::DSL::Recipe or Chef::DSL::Resource classes and not Recipe/Resource/Provider classes directly.

### Examples

```ruby
# bad
::Chef::Recipe.send(:include, Filebeat::Helpers)
::Chef::Provider.send(:include, Filebeat::Helpers)
::Chef::Resource.send(:include, Filebeat::Helpers)

# good
::Chef::DSL::Recipe.send(:include, Filebeat::Helpers) # covers previous Recipe & Provider classes
::Chef::DSL::Resource.send(:include, Filebeat::Helpers)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.10.0` | String
Include | `**/libraries/*.rb` | Array

## ChefCorrectness/InvalidNotificationTiming

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Valid notification timings are :immediately, :immediate (alias for :immediately), :delayed, and :before.

### Examples

```ruby
# bad

template '/etc/www/configures-apache.conf' do
  notifies :restart, 'service[apache]', :nope
end

# good

template '/etc/www/configures-apache.conf' do
  notifies :restart, 'service[apache]', :immediately
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Exclude | `**/attributes/*.rb`, `**/metadata.rb`, `**/Berksfile` | Array

## ChefCorrectness/InvalidPlatformFamilyHelper

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Pass valid platform families to the platform_family? helper.

### Examples

```ruby
# bad
platform_family?('redhat')
platform_family?('sles')

# bad
platform_family?('rhel')
platform_family?('suse')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.15.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

## ChefCorrectness/InvalidPlatformHelper

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Pass valid platforms to the platform? helper.

### Examples

```ruby
# bad
platform?('darwin')
platform?('rhel)
platform?('sles')

# good
platform?('mac_os_x')
platform?('redhat)
platform?('suse')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.15.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

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

## ChefCorrectness/InvalidPlatformValueForPlatformFamilyHelper

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Pass valid platforms families to the value_for_platform_family helper.

### Examples

```ruby
# bad
value_for_platform_family(
  %w(rhel sles) => 'foo',
  %w(mac) => 'foo'
)

# good
value_for_platform_family(
  %w(rhel suse) => 'foo',
  %w(mac_os_x) => 'foo'
)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.15.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

## ChefCorrectness/InvalidPlatformValueForPlatformHelper

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Pass valid platforms to the value_for_platform helper.

### Examples

```ruby
# bad
value_for_platform(
  %w(rhel mac_os_x_server) => { 'default' => 'foo' },
  %w(sles) => { 'default' => 'bar' }
)
# good
value_for_platform(
  %w(redhat mac_os_x) => { 'default' => 'foo' },
  %w(opensuseleap) => { 'default' => 'bar' }
)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.15.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

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

## ChefCorrectness/MalformedPlatformValueForPlatformHelper

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

When using the value_for_platform helper you must include a hash of possible platforms where each platform contains a hash of versions and potential values. If you don't wish to match on a particular version you can instead use the key 'default'.

### Examples

```ruby
# bad
value_for_platform(
  %w(redhat oracle) => 'baz'
)

# good
value_for_platform(
  %w(redhat oracle) => {
    '5' => 'foo',
    '6' => 'bar',
    'default'd => 'baz',
  }
)

value_for_platform(
  %w(redhat oracle) => {
    'default' => 'foo',
  },
  'default' => 'bar'
)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

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

## ChefCorrectness/NotifiesActionNotSymbol

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

When notifying or subscribing an action within a resource the action should always be a symbol. In Chef Infra Client releases before 14.0 this may result in double notification.

### Examples

```ruby
# bad
execute 'some commmand' do
  notifies 'restart', 'service[httpd]', 'delayed'
end

execute 'some commmand' do
  subscribes 'restart', 'service[httpd]', 'delayed'
end

# good
execute 'some commmand' do
  notifies :restart, 'service[httpd]', 'delayed'
end

execute 'some commmand' do
  subscribes :restart, 'service[httpd]', 'delayed'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.10.0` | String
Exclude | `**/attributes/*.rb`, `**/metadata.rb`, `**/Berksfile` | Array

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

## ChefCorrectness/ScopedFileExist

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Scope file exist to access the correct File class by using ::File.exist? not File.exist?.

### Examples

```ruby
# bad
not_if { File.exist?('/etc/foo/bar') }

# good
not_if { ::File.exist?('/etc/foo/bar') }
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.15.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

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
