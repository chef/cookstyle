# Chef/Style

## Chef/Style/AttributeKeys

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Check which style of keys are used to access node attributes.

There are two supported styles: "symbols" and "strings".

### Examples

#### when configuration is `EnforcedStyle: symbols`

```ruby
#### incorrect
node['foo']
node["foo"]

#### correct
node[:foo]
```
#### when configuration is `EnforcedStyle: strings`

```ruby
#### incorrect
node[:foo]

#### correct
node['foo']
node["foo"]
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
EnforcedStyle | `strings` | `strings`, `symbols`
VersionAdded | `5.0.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefstyleattributekeys](https://rubystyle.guide#chefstyleattributekeys)

## Chef/Style/ChefWhaaat

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | All Versions

Checks for comments that mention "Chef" without context. Do you mean Chef Infra or Chef Software?

### Examples

```ruby
#### incorrect
Chef makes software
Chef configures your systems

#### correct
Chef Software makes software
Chef Infra configures your systems
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.20.0` | String

### References

* [https://rubystyle.guide#chefstylechefwhaaat](https://rubystyle.guide#chefstylechefwhaaat)

## Chef/Style/CommentFormat

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Checks for incorrectly formatted headers

### Examples

```ruby
#### incorrect
Copyright 2013-2016 Chef Software, Inc.
Recipe default.rb
Attributes default.rb
License Apache2
Cookbook tomcat
Cookbook Name:: Tomcat
Attributes File:: default

#### correct
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

### References

* [https://rubystyle.guide#chefstylecommentformat](https://rubystyle.guide#chefstylecommentformat)

## Chef/Style/CommentSentenceSpacing

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | Yes | All Versions

Replaces double spaces between sentences with a single space.
Note: This is DISABLED by default.

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String

### References

* [https://rubystyle.guide#chefstylecommentsentencespacing](https://rubystyle.guide#chefstylecommentsentencespacing)

## Chef/Style/CopyrightCommentFormat

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | Yes | All Versions

Checks for incorrectly formatted copyright comments.

### Examples

```ruby
#### incorrect
Copyright:: 2013-2022 Opscode, Inc.
Copyright:: 2013-2022 Chef Inc.
Copyright:: 2013-2022 Chef Software Inc.
Copyright:: 2009-2010 2013-2022 Chef Software Inc.
Copyright:: Chef Software Inc.
Copyright:: Tim Smith
Copyright:: Copyright (c) 2015-2022 Chef Software, Inc.

#### correct
Copyright:: 2013-2022 Chef Software, Inc.
Copyright:: 2013-2022 Tim Smith
Copyright:: 2019 37Signals, Inc.
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.0.0` | String

### References

* [https://rubystyle.guide#chefstylecopyrightcommentformat](https://rubystyle.guide#chefstylecopyrightcommentformat)

## Chef/Style/DefaultCopyrightComments

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

Checks for default copyright comments from the chef generator cookbook command

### Examples

```ruby
#### incorrect
Copyright:: 2019 YOUR_NAME
Copyright:: 2019 YOUR_COMPANY_NAME

#### correct
Copyright:: 2019 Tim Smith
Copyright:: 2019 Chef Software, Inc.
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.12.0` | String

### References

* [https://rubystyle.guide#chefstyledefaultcopyrightcomments](https://rubystyle.guide#chefstyledefaultcopyrightcomments)

## Chef/Style/FileMode

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use strings to represent file modes to avoid confusion between octal and base 10 integer formats.

### Examples

```ruby
#### incorrect
remote_directory '/etc/my.conf' do
  content 'some content'
  mode 0600
  action :create
end

remote_directory 'handler' do
  source 'handlers'
  recursive true
  files_mode 644
  action :create
end

#### correct
remote_directory '/etc/my.conf' do
  content 'some content'
  mode '600'
  action :create
end

remote_directory 'handler' do
  source 'handlers'
  recursive true
  files_mode '644'
  action :create
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.0.0` | String
Exclude | `**/attributes/*`, `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefstylefilemode](https://rubystyle.guide#chefstylefilemode)

## Chef/Style/ImmediateNotificationTiming

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use :immediately instead of :immediate for resource notification timing

### Examples

```ruby
#### incorrect

template '/etc/www/configures-apache.conf' do
  notifies :restart, 'service[apache]', :immediate
end

#### correct

template '/etc/www/configures-apache.conf' do
  notifies :restart, 'service[apache]', :immediately
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Exclude | `**/attributes/*.rb`, `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefstyleimmediatenotificationtiming](https://rubystyle.guide#chefstyleimmediatenotificationtiming)

## Chef/Style/IncludeRecipeWithParentheses

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

There is no need to wrap the recipe in parentheses when using the include_recipe helper.

### Examples

```ruby
#### incorrect
include_recipe('foo::bar')

#### correct
include_recipe 'foo::bar'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.11.0` | String
Exclude | `**/attributes/*.rb`, `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#includerecipewithparentheses](https://rubystyle.guide#includerecipewithparentheses)

## Chef/Style/NegatingOnlyIf

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Instead of using only_if conditionals with ! to negate the returned value, use not_if which is easier to read

### Examples

```ruby
#### incorrect
package 'legacy-sysv-deps' do
  only_if { !systemd }
end

#### correct
package 'legacy-sysv-deps' do
  not_if { systemd }
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.2.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefstylenegatingonlyif](https://rubystyle.guide#chefstylenegatingonlyif)

## Chef/Style/OverlyComplexSupportsDependsMetadata

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Don't loop over an array to set cookbook dependencies or supported platforms if you have fewer than three values to set. Setting multiple `supports` or `depends` values is simpler and easier to understand for new users.

### Examples

```ruby
#### incorrect

%w( debian ubuntu ).each do |os|
  supports os
end

%w( apt yum ).each do |cb|
  depends cb
end

#### correct

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

### References

* [https://rubystyle.guide#chefstyleovercomplexsupportsdependsmetadata](https://rubystyle.guide#chefstyleovercomplexsupportsdependsmetadata)

## Chef/Style/SimplifyPlatformMajorVersionCheck

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

When checking the major version number of a platform you can take the node['platform_version'] attribute and transform it to an integer to strip it down to just the major version number. This simple way of determining the major version number of a platform should be used instead of splitting the platform into multiple fields with '.' as the delimiter.

### Examples

```ruby
#### incorrect
node['platform_version'].split('.').first
node['platform_version'].split('.')[0]
node['platform_version'].split('.').first.to_i
node['platform_version'].split('.')[0].to_i

#### correct

# check to see if we're on RHEL 7 on a RHEL 7.6 node where node['platform_version] is 7.6.1810
if node['platform_version'].to_i == 7
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.8.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefstylesimplifyplatformmajorversioncheck](https://rubystyle.guide#chefstylesimplifyplatformmajorversioncheck)

## Chef/Style/TrueClassFalseClassResourceProperties

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

When setting the allowed types for a resource to accept either true or false values it's much simpler to use true and false instead of TrueClass and FalseClass.

### Examples

```ruby
#### incorrect
property :foo, [TrueClass, FalseClass]

#### correct
property :foo, [true, false]
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Include | `**/libraries/*.rb`, `**/resources/*.rb` | Array

### References

* [https://rubystyle.guide#chefstyletrueclassfalseclassresourceproperties](https://rubystyle.guide#chefstyletrueclassfalseclassresourceproperties)

## Chef/Style/UnnecessaryOSCheck

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use the platform_family?() helpers instead of node['os] == 'foo' for platform_families that match one-to-one with OS values. These helpers are easier to read and can accept multiple platform arguments, which greatly simplifies complex platform logic. All values of `os` from Ohai match one-to-one with `platform_family` values except for `linux`, which has no single equivalent `plaform_family`.

### Examples

```ruby
#### incorrect
node['os'] == 'darwin'
node['os'] == 'windows'
node['os'].eql?('aix')
%w(netbsd openbsd freebsd).include?(node['os'])

#### correct
platform_family?('mac_os_x')
platform_family?('windows')
platform_family?('aix')
platform_family?('netbsd', 'openbsd', 'freebsd)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.21.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefstyleunnecessaryoscheck](https://rubystyle.guide#chefstyleunnecessaryoscheck)

## Chef/Style/UnnecessaryPlatformCaseStatement

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use the platform?() and platform_family?() helpers instead of a case statement that only includes a single when statement.

### Examples

```ruby
#### incorrect
case node['platform']
when 'ubuntu'
  log "We're on Ubuntu"
  apt_update
end

case node['platform_family']
when 'rhel'
  include_recipe 'yum'
end

#### correct
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

### References

* [https://rubystyle.guide#chefstyleunnecessaryplatformcasestatement](https://rubystyle.guide#chefstyleunnecessaryplatformcasestatement)

## Chef/Style/UsePlatformHelpers

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use the platform?() and platform_family?() helpers instead of node['platform] == 'foo' and node['platform_family'] == 'bar'. These helpers are easier to read and can accept multiple platform arguments, which greatly simplifies complex platform logic.

### Examples

```ruby
#### incorrect
node['platform'] == 'ubuntu'
node['platform_family'] == 'debian'
node['platform'] != 'ubuntu'
node['platform_family'] != 'debian'
%w(rhel suse).include?(node['platform_family'])
node['platform'].eql?('ubuntu')

#### correct
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

### References

* [https://rubystyle.guide#chefstyleuseplatformhelpers](https://rubystyle.guide#chefstyleuseplatformhelpers)
