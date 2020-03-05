# ChefStyle

## ChefStyle/AttributeKeys

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

## ChefStyle/ChefWhaaat

Enabled by default | Supports autocorrection
--- | ---
Disabled | No

Checks for comments that mention "Chef" without context. Do you mean Chef Infra or Chef Software?

### Examples

```ruby
# bad
Chef makes software
Chef configures your systems

# good
Chef Software makes software
Chef Infra configures your systems
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.20.0` | String

## ChefStyle/CommentFormat

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
Exclude | `**/Berksfile` | Array

## ChefStyle/CommentSentenceSpacing

Enabled by default | Supports autocorrection
--- | ---
Disabled | Yes

Replaces double spaces between sentences with a single space.
Note: This is DISABLED by default.

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String

## ChefStyle/CopyrightCommentFormat

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

## ChefStyle/DefaultCopyrightComments

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

Checks for default copyright comments from the chef generator cookbook command

### Examples

```ruby
# bad
Copyright:: 2019 YOUR_NAME
Copyright:: 2019 YOUR_COMPANY_NAME

# good
Copyright:: 2019 Tim Smith
Copyright:: 2019 Chef Software, Inc.
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.12.0` | String

## ChefStyle/FileMode

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
Exclude | `**/attributes/*`, `**/metadata.rb`, `**/Berksfile` | Array

## ChefStyle/ImmediateNotificationTiming

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Use :immediately instead of :immediate for resource notification timing

### Examples

```ruby
# bad

template '/etc/www/configures-apache.conf' do
  notifies :restart, 'service[apache]', :immediate
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

## ChefStyle/OverlyComplexSupportsDependsMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Don't loop over an array to set cookbook dependencies or supported platforms if you have fewer than three values to set.  Setting multiple `supports` or `depends` values is simpler and easier to understand for new users.

### Examples

```ruby
# bad

%w( debian ubuntu ).each do |os|
  supports os
end

%w( apt yum ).each do |cb|
  depends cb
end

# good

supports 'debian'
supports 'ubuntu'

depends 'apt'
depends 'yum'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.19.0` | String
Include | `**/metadata.rb` | Array

## ChefStyle/SimplifyPlatformMajorVersionCheck

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

When checking the major version number of a platform you can take the node['platform_version'] attribute and transform it to an integer to strip it down to just the major version number. This simple way of determining the major version number of a platform should be used instead of splitting the platform into multiple fields with '.' as the delimiter.

### Examples

```ruby
# bad
node['platform_version'].split('.').first
node['platform_version'].split('.')[0]
node['platform_version'].split('.').first.to_i
node['platform_version'].split('.')[0].to_i

# good

# check to see if we're on RHEL 7 on a RHEL 7.6 node where node['platform_version] is 7.6.1810
if node['platform_version'].to_i == 7
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.8.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

## ChefStyle/TrueClassFalseClassResourceProperties

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

When setting the allowed types for a resource to accept either true or false values it's much simpler to use true and false instead of TrueClass and FalseClass.

### Examples

```ruby
# bad
property :foo, [TrueClass, FalseClass]

# good
property :foo, [true, false]
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Include | `**/libraries/*.rb`, `**/resources/*.rb` | Array

## ChefStyle/UnnecessaryOSCheck

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Use the platform_family?() helpers instead of node['os] == 'foo' for platform_families that match one-to-one with OS values. These helpers are easier to read and can accept multiple platform arguments, which greatly simplifies complex platform logic. All values of `os` from Ohai match one-to-one with `platform_family` values except for `linux`, which has no single equivalent `plaform_family`.

### Examples

```ruby
# bad
node['os'] == 'darwin'
node['os'] == 'windows'
node['os'].eql?('aix')
%w(netbsd openbsd freebsd).include?(node['os'])

# good
platform_family?('mac_os_x')
platform_family?('windows')
platform_family?('aix')
platform_family?('netbsd', 'openbsd', 'freebsd)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.21.0` | String

## ChefStyle/UnnecessaryPlatformCaseStatement

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Use the platform?() and platform_family?() helpers instead of a case statement that only includes a single when statement.

### Examples

```ruby
# bad
case node['platform']
when 'ubuntu'
  log "We're on Ubuntu"
  apt_update
end

case node['platform_family']
when 'rhel'
  include_recipe 'yum'
end

# good
if platform?('ubuntu')
  log "We're on Ubuntu"
  apt_update
end

include_recipe 'yum' if platform_family?('rhel')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

## ChefStyle/UsePlatformHelpers

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Use the platform?() and platform_family?() helpers instead of node['platform] == 'foo' and node['platform_family'] == 'bar'. These helpers are easier to read and can accept multiple platform arguments, which greatly simplifies complex platform logic.

### Examples

```ruby
# bad
node['platform'] == 'ubuntu'
node['platform_family'] == 'debian'
node['platform'] != 'ubuntu'
node['platform_family'] != 'debian'
%w(rhel suse).include?(node['platform_family'])
node['platform'].eql?('ubuntu')

# good
platform?('ubuntu')
!platform?('ubuntu')
platform_family?('debian')
!platform_family?('debian')
platform_family?('rhel', 'suse')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
Exclude | `**/metadata.rb`, `**/libraries/*`, `**/Berksfile` | Array
