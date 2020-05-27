# ChefModernize

## ChefModernize/AllowedActionsFromInitialize

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

The allowed actions can now be specified using the `allowed_actions` helper instead of using the @actions or @allowed_actions variables in the resource's initialize method. In general we recommend against writing HWRPs, but if HWRPs are necessary you should utilize as much of the resource DSL as possible.

### Examples

```ruby
# bad
def initialize(*args)
  super
  @actions = [ :create, :add ]
end

# also bad
def initialize(*args)
  super
  @allowed_actions = [ :create, :add ]
end

# good
allowed_actions [ :create, :add ]
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.15.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeallowedactionsfrominitialize](https://rubystyle.guide#chefmodernizeallowedactionsfrominitialize)

## ChefModernize/ChefGemNokogiri

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

The nokogiri gem ships in Chef Infra Client 12+ and does not need to be installed before being used

### Examples

```ruby
# bad
chef_gem 'nokogiri'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.14.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizechefgemnokogiri](https://rubystyle.guide#chefmodernizechefgemnokogiri)

## ChefModernize/CronManageResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 14.4+

The cron_manage resource was renamed to cron_access in the 6.1 release of the cron
cookbook, and later shipped in Chef Infra Client 14.4. The new resource name should
be used.

  # bad
  cron_manage 'mike'

  # good
  cron_access 'mike'

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizecronmanageresource](https://rubystyle.guide#chefmodernizecronmanageresource)

## ChefModernize/CustomResourceWithAttributes

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

### References

* [https://rubystyle.guide#chefmodernizecustomresourcewithattributes](https://rubystyle.guide#chefmodernizecustomresourcewithattributes)

## ChefModernize/DatabagHelpers

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use the `data_bag_item` helper instead of `Chef::DataBagItem.load` or `Chef::EncryptedDataBagItem.load`.

### Examples

```ruby
# bad
plain_text_data = Chef::DataBagItem.load('foo', 'bar')
encrypted_data = Chef::EncryptedDataBagItem.load('foo2', 'bar2')

# good
plain_text_data = data_bag_item('foo', 'bar')
encrypted_data = data_bag_item('foo2', 'bar2')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.0.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizedatabaghelpers](https://rubystyle.guide#chefmodernizedatabaghelpers)

## ChefModernize/DefaultActionFromInitialize

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

The default actions can now be specified using the `default_action` helper instead of using the @action variable in the resource provider initialize method. In general we recommend against writing HWRPs, but if HWRPs are necessary you should utilize as much of the resource DSL as possible.

 # good
 default_action :create

### Examples

```ruby
# bad
def initialize(*args)
  super
  @action = :create
end

# bad
def initialize(*args)
  super
  @default_action = :create
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.10.0` | String
Include | `**/resources/*.rb`, `**/providers/*.rb`, `**/libraries/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizedefaultactionfrominitialize](https://rubystyle.guide#chefmodernizedefaultactionfrominitialize)

## ChefModernize/DefinesChefSpecMatchers

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

### References

* [https://rubystyle.guide#chefmodernizedefineschefspecmatchers](https://rubystyle.guide#chefmodernizedefineschefspecmatchers)

## ChefModernize/Definitions

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

In 2016 with Chef Infra Client 12.5 Custom Resources were introduced as a way of writing reusable resource code that could be shipped in cookbooks. Custom Resources offer many advantages of legacy Definitions including unit testing with ChefSpec, input validation, actions, commmon properties like not_if/only_if, and resource reporting.

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.11.0` | String
Include | `**/definitions/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizedefinitions](https://rubystyle.guide#chefmodernizedefinitions)

## ChefModernize/DependsOnZypperCookbook

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 13.3+

Don't depend on the zypper cookbook as the zypper_repository resource is built into Chef Infra Client 13.3+

### Examples

```ruby
# bad
depends 'zypper'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizedependsonzyppercookbook](https://rubystyle.guide#chefmodernizedependsonzyppercookbook)

## ChefModernize/DslIncludeInResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Chef Infra Client 12.4+ includes the Chef::DSL::Recipe in the resource and provider classed by default so there is no need to include this DSL in your resources or providers.

  # bad
  include Chef::DSL::Recipe
  include Chef::DSL::IncludeRecipe

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.17.0` | String
Include | `**/resources/*.rb`, `**/providers/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizedslincludeinresource](https://rubystyle.guide#chefmodernizedslincludeinresource)

## ChefModernize/EmptyResourceInitializeMethod

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

There is no need for an empty initialize method in a resource

### Examples

```ruby
# bad
def initialize(*args)
  super
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.13.0` | String
Include | `**/resources/*.rb`, `**/providers/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeemptyresourceinitializemethod](https://rubystyle.guide#chefmodernizeemptyresourceinitializemethod)

## ChefModernize/ExecuteAptUpdate

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

Instead of using the execute resource to to run the `apt-get update` use Chef Infra Client's built-n
apt_update resource which is available in Chef Infra Client 12.7 and later.

  # bad
  execute 'apt-get update'

  execute 'Apt all the apt cache' do
    command 'apt-get update'
  end

  execute 'some execute resource' do
    notifies :run, 'execute[apt-get update]', :immediately
  end

  # good
  apt_update

  apt_update 'update apt cache'

  execute 'some execute resource' do
    notifies :update, 'apt_update[update apt cache]', :immediately
  end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.3.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeexecuteaptupdate](https://rubystyle.guide#chefmodernizeexecuteaptupdate)

## ChefModernize/ExecuteScExe

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 14.0+

Chef Infra Client 14.0 and later includes :create, :delete, and :configure actions with the full idempotency of the windows_service resource. See the windows_service documentation at https://docs.chef.io/resource_windows_service.html for additional details on creating services with the windows_service resource.

  # bad
  execute "Delete chef-client service" do
    command "sc.exe delete chef-client"
    action :run
  end

  # good
  windows_service 'chef-client' do
    action :delete
  end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizeexecutescexe](https://rubystyle.guide#chefmodernizeexecutescexe)

## ChefModernize/ExecuteSleep

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 15.5+

Chef Infra Client 15.5 and later include a chef_sleep resource that should be used to sleep between executing resources if necessary instead of using the bash or execute resources to run the sleep command.

  # bad
  execute "sleep 60" do
    command "sleep 60"
    action :run
  end

  bash 'sleep' do
    user 'root'
    cwd '/tmp'
    code 'sleep 60'
  end

  # good
  chef_sleep '60'

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizeexecutesleep](https://rubystyle.guide#chefmodernizeexecutesleep)

## ChefModernize/ExecuteSysctl

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 14.0+

Chef Infra Client 14.0 and later includes a sysctl resource that should be used to idempotently load sysctl values instead of templating files and using execute to load them.

  # bad
  file '/etc/sysctl.d/ipv4.conf' do
    notifies :run, 'execute[sysctl -p /etc/sysctl.d/ipv4.conf]', :immediately
    content '9000 65500'
  end

  execute 'sysctl -p /etc/sysctl.d/ipv4.conf' do
    action :nothing
  end

  # good
  sysctl 'net.ipv4.ip_local_port_range' do
    value '9000 65500'
  end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.18.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizeexecutesysctl](https://rubystyle.guide#chefmodernizeexecutesysctl)

## ChefModernize/ExecuteTzUtil

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 14.6+

Instead of using the execute or powershell_script resources to to run the `tzutil` command, use
Chef Infra Client's built-in timezone resource which is available in Chef Infra Client 14.6 and later.

  # bad
  execute 'set tz' do
    command 'tzutil.exe /s UTC'
  end

  execute 'tzutil /s UTC'

  powershell_script 'set windows timezone' do
    code "tzutil.exe /s UTC"
    not_if { shell_out('tzutil.exe /g').stdout.include?('UTC') }
  end

  # good
  timezone 'UTC'

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeexecutetzutil](https://rubystyle.guide#chefmodernizeexecutetzutil)

## ChefModernize/FoodcriticComments

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Remove legacy code comments that disable Foodcritic rules. These comments are no longer necessary if you've migrated from Foodcritic to Cookstyle for cookbook linting.

### Examples

```ruby
# bad
# ~FC013
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Exclude | `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizefoodcriticcomments](https://rubystyle.guide#chefmodernizefoodcriticcomments)

## ChefModernize/IfProvidesDefaultAction

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

if defined?(default_action) is no longer necessary in Chef Resources as default_action shipped in Chef 10.8.

### Examples

```ruby
# bad
default_action :foo if defined?(default_action)

# good
default_action :foo
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.12.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeifprovidesdefaultaction](https://rubystyle.guide#chefmodernizeifprovidesdefaultaction)

## ChefModernize/IncludingAptDefaultRecipe

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 12.7+

For many users the apt::default cookbook is used only to update apt's package cache. Chef Infra Client 12.7 and later include an apt_update resource which should be used to perform this instead. Keep in mind that some users will want to stick with the apt::default recipe as it also installs packages necessary for using https repositories on Debian systems and manages some configuration files.

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

### References

* [https://rubystyle.guide#chefmodernizeincludingaptdefaultrecipe](https://rubystyle.guide#chefmodernizeincludingaptdefaultrecipe)

## ChefModernize/IncludingMixinShelloutInResources

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

There is no need to include Chef::Mixin::ShellOut or Chef::Mixin::PowershellOut in resources or providers as this is already done by Chef Infra Client 12.4+.

### Examples

```ruby
# bad
require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut
require 'chef/mixin/powershell_out'
include Chef::Mixin::PowershellOut
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Include | `**/resources/*.rb`, `**/providers/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeincludingmixinshelloutinresources](https://rubystyle.guide#chefmodernizeincludingmixinshelloutinresources)

## ChefModernize/IncludingOhaiDefaultRecipe

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

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
VersionChanged | `5.15.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizeincludingohaidefaultrecipe](https://rubystyle.guide#chefmodernizeincludingohaidefaultrecipe)

## ChefModernize/IncludingWindowsDefaultRecipe

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Don't include the windows default recipe that is either full of gem install that are part of the Chef Infra Client, or empty (depends on version).

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

### References

* [https://rubystyle.guide#chefmodernizeincludingwindowsdefaultrecipe](https://rubystyle.guide#chefmodernizeincludingwindowsdefaultrecipe)

## ChefModernize/LegacyBerksfileSource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Over the course of years there have been many different valid community site / Supermarket
URLs to use in a cookbook's Berksfile. These old URLs continue to function via redirects,
but should be updated to point to the latest Supermarket URL.

### Examples

```ruby
# bad
source 'http://community.opscode.com/api/v3'
source 'https://supermarket.getchef.com'
source 'https://api.berkshelf.com'
site :opscode

# good
source 'https://supermarket.chef.io'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
Include | `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizelegacyberksfilesource](https://rubystyle.guide#chefmodernizelegacyberksfilesource)

## ChefModernize/LibarchiveFileResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 15.0+

Use the archive_file resource built into Chef Infra Client 15+ instead of the libarchive_file resource.

### Examples

```ruby
# bad
libarchive_file "C:\file.zip" do
  path 'C:\expand_here'
end

# good
archive_file "C:\file.zip" do
  path 'C:\expand_here'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.5.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizelibarchivefileresource](https://rubystyle.guide#chefmodernizelibarchivefileresource)

## ChefModernize/MacOsXUserdefaults

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 14.0+

The mac_os_x_userdefaults resource was renamed to macos_userdefaults when it was added to Chef Infra Client
14.0. The new resource name should be used.

  # bad
  mac_os_x_userdefaults 'full keyboard access to all controls' do
    domain 'AppleKeyboardUIMode'
    global true
    value '2'
  end

  # good
  macos_userdefaults 'full keyboard access to all controls' do
    domain 'AppleKeyboardUIMode'
    global true
    value '2'
  end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizemacosxuserdefaults](https://rubystyle.guide#chefmodernizemacosxuserdefaults)

## ChefModernize/MinitestHandlerUsage

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

### References

* [https://rubystyle.guide#chefmodernizeminitesthandlerusage](https://rubystyle.guide#chefmodernizeminitesthandlerusage)

## ChefModernize/NodeInitPackage

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use node['init_package'] to check for systemd instead of reading the contents of '/proc/1/comm'

### Examples

```ruby
# bad
::File.open('/proc/1/comm').gets.chomp == 'systemd'
::File.open('/proc/1/comm').chomp == 'systemd'
File.open('/proc/1/comm').gets.chomp == 'systemd'
File.open('/proc/1/comm').chomp == 'systemd'
File.exist?('/proc/1/comm') && File.open('/proc/1/comm').chomp == 'systemd'

IO.read('/proc/1/comm').chomp == 'systemd'
IO.read('/proc/1/comm').gets.chomp == 'systemd'
::IO.read('/proc/1/comm').chomp == 'systemd'
::IO.read('/proc/1/comm').gets.chomp == 'systemd'
File.exist?('/proc/1/comm') && File.open('/proc/1/comm').chomp == 'systemd'

# good
node['init_package'] == 'systemd'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.22.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizenodeinitpackage](https://rubystyle.guide#chefmodernizenodeinitpackage)

## ChefModernize/NodeRolesInclude

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use `node.role?('foo')` to check if a node includes a role instead of `node['roles'].include?('foo')`.

### Examples

```ruby
# bad
node['roles'].include?('foo')

# good
node.role?('foo')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.1.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizenoderolesinclude](https://rubystyle.guide#chefmodernizenoderolesinclude)

## ChefModernize/OpensslRsaKeyResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 14.0+

The openssl_rsa_key resource was renamed to openssl_rsa_private_key in Chef
Infra Client 14.0. The new resource name should be used.

  # bad
  openssl_rsa_key '/etc/httpd/ssl/server.key' do
    key_length 2048
  end

  # good
  openssl_rsa_private_key '/etc/httpd/ssl/server.key' do
    key_length 2048
  end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeopensslrsakeyresource](https://rubystyle.guide#chefmodernizeopensslrsakeyresource)

## ChefModernize/OpensslX509Resource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 14.4+

The openssl_x509 resource was renamed to openssl_x509_certificate in Chef Infra Client 14.4.
The new resource name should be used.

  # bad
  openssl_x509 '/etc/httpd/ssl/mycert.pem' do
    common_name 'www.f00bar.com'
    org 'Foo Bar'
    org_unit 'Lab'
    country 'US'
  end

  # good
  openssl_x509_certificate '/etc/httpd/ssl/mycert.pem' do
    common_name 'www.f00bar.com'
    org 'Foo Bar'
    org_unit 'Lab'
    country 'US'
  end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeopensslx509resource](https://rubystyle.guide#chefmodernizeopensslx509resource)

## ChefModernize/OsxConfigProfileResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

The osx_config_profile resource was renamed to osx_profile.
The new resource name should be used.

  # bad
  osx_config_profile 'Install screensaver profile' do
    profile 'screensaver/com.company.screensaver.mobileconfig'
  end

  # good
  osx_profile 'Install screensaver profile' do
    profile 'screensaver/com.company.screensaver.mobileconfig'
  end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeosxconfigprofileresource](https://rubystyle.guide#chefmodernizeosxconfigprofileresource)

## ChefModernize/PowerShellGuardInterpreter

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 13.0+

PowerShell is already set as the default guard interpreter for `powershell_script` and `batch` resources in Chef Infra Client 13 and later and does not need to be specified.

### Examples

```ruby
# bad
powershell_script 'Create Directory' do
  code "New-Item -ItemType Directory -Force -Path C:\mydir"
  guard_interpreter :powershell_script
end

batch 'Create Directory' do
  code "mkdir C:\mydir"
  guard_interpreter :powershell_script
end

# good
powershell_script 'Create Directory' do
  code "New-Item -ItemType Directory -Force -Path C:\mydir"
end

batch 'Create Directory' do
  code "mkdir C:\mydir"
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.9.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizepowershellguardinterpreter](https://rubystyle.guide#chefmodernizepowershellguardinterpreter)

## ChefModernize/PowershellInstallPackage

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 12.16+

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

### References

* [https://rubystyle.guide#chefmodernizepowershellinstallpackage](https://rubystyle.guide#chefmodernizepowershellinstallpackage)

## ChefModernize/PowershellInstallWindowsFeature

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 14.0+

Use the windows_feature resource built into Chef Infra Client 14+ instead of the powershell_script resource
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

### References

* [https://rubystyle.guide#chefmodernizepowershellinstallwindowsfeature](https://rubystyle.guide#chefmodernizepowershellinstallwindowsfeature)

## ChefModernize/PowershellScriptExpandArchive

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 15.0+

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

### References

* [https://rubystyle.guide#chefmodernizepowershellscriptexpandarchive](https://rubystyle.guide#chefmodernizepowershellscriptexpandarchive)

## ChefModernize/PropertyWithNameAttribute

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

When using properties in a custom resource you should use name_property not the legacy name_attribute from the days of attributes

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
VersionChanged | `5.15.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizepropertywithnameattribute](https://rubystyle.guide#chefmodernizepropertywithnameattribute)

## ChefModernize/ProvidesFromInitialize

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Provides should be set using the `provides` resource DSL method instead of instead of setting @provides in the initialize method.

### Examples

```ruby
# bad
def initialize(*args)
  super
  @provides = :foo
end

# good
provides :foo
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.0.0` | String
Include | `**/resources/*.rb`, `**/providers/*.rb`, `**/libraries/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeprovidesfrominitialize](https://rubystyle.guide#chefmodernizeprovidesfrominitialize)

## ChefModernize/ResourceForcingCompileTime

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

The hostname, build_essential, chef_gem, and ohai_hint resources include 'compile_time' properties, which should be used to force the resources to run at compile time by setting `compile_time true`.

### Examples

```ruby
# bad
build_essential 'install build tools' do
 action :nothing
end.run_action(:install)

# good
build_essential 'install build tools' do
 compile_time true
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.18.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizeresourceforcingcompiletime](https://rubystyle.guide#chefmodernizeresourceforcingcompiletime)

## ChefModernize/ResourceNameFromInitialize

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

The resource name can now be specified using the `resource_name` helper instead of using the @resource_name variable in the resource provider initialize method. In general we recommend against writing HWRPs, but if HWRPs are necessary you should utilize as much of the resource DSL as possible.

 # good
 resource_name :create

### Examples

```ruby
# bad
def initialize(*args)
  super
  @resource_name = :foo
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.10.0` | String
Include | `**/resources/*.rb`, `**/providers/*.rb`, `**/libraries/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeresourcenamefrominitialize](https://rubystyle.guide#chefmodernizeresourcenamefrominitialize)

## ChefModernize/RespondToCompileTime

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 12.1+

There is no need to check if the chef_gem resource supports compile_time as Chef Infra Client 12.1 and later support the compile_time property.

  # bad
  chef_gem 'ultradns-sdk' do
    compile_time true if Chef::Resource::ChefGem.method_defined?(:compile_time)
    action :nothing
  end

  chef_gem 'ultradns-sdk' do
    compile_time true if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
    action :nothing
  end

  chef_gem 'ultradns-sdk' do
    compile_time true if respond_to?(:compile_time)
    action :nothing
  end

  # good
  chef_gem 'ultradns-sdk' do
    compile_time true
    action :nothing
  end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.3.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizeresondtocompiletime](https://rubystyle.guide#chefmodernizeresondtocompiletime)

## ChefModernize/RespondToInMetadata

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 12.15+

It is not longer necessary respond_to?(:foo) or defined?(foo) in metadata. This was used to support new metadata
methods in Chef 11 and early versions of Chef 12.

### Examples

```ruby
# bad
chef_version '>= 13' if respond_to?(:chef_version)
chef_version '>= 13' if defined?(chef_version)
if defined(chef_version)
  chef_version '>= 13'
end

# good
chef_version '>= 13'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizerespondtoinmetadata](https://rubystyle.guide#chefmodernizerespondtoinmetadata)

## ChefModernize/RespondToProvides

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

In Chef Infra Client 12+ is is no longer necessary to gate the use of the provides methods in resources with `if respond_to?(:provides)` or `if defined? provides`.

### Examples

```ruby
# bad
provides :foo if respond_to?(:provides)

provides :foo if defined? provides

# good
provides :foo
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
Include | `**/providers/*.rb`, `**/libraries/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizerespondtoprovides](https://rubystyle.guide#chefmodernizerespondtoprovides)

## ChefModernize/RespondToResourceName

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Chef Infra Client 12.5 introduced the resource_name method for resources. Many cookbooks used respond_to?(:resource_name) to provide backwards compatibility with older chef-client releases. This backwards compatibility is no longer necessary.

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

### References

* [https://rubystyle.guide#chefmodernizerespondtoresourcename](https://rubystyle.guide#chefmodernizerespondtoresourcename)

## ChefModernize/SetOrReturnInResources

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

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

### References

* [https://rubystyle.guide#chefmodernizesetorreturninresources](https://rubystyle.guide#chefmodernizesetorreturninresources)

## ChefModernize/SevenZipArchiveResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 15.0+

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

### References

* [https://rubystyle.guide#chefmodernizesevenziparchiveresource](https://rubystyle.guide#chefmodernizesevenziparchiveresource)

## ChefModernize/ShellOutHelper

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 12.11+

Use the built-in `shell_out` helper available in Chef Infra Client 12.11+ instead of calling `Mixlib::ShellOut.new('foo').run_command`.

### Examples

```ruby
# bad
Mixlib::ShellOut.new('foo').run_command

# good
shell_out('foo')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.5.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile`, `**/libraries/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeshellouthelper](https://rubystyle.guide#chefmodernizeshellouthelper)

## ChefModernize/ShellOutToChocolatey

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

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

### References

* [https://rubystyle.guide#chefmodernizeshellouttochocolatey](https://rubystyle.guide#chefmodernizeshellouttochocolatey)

## ChefModernize/SimplifyAptPpaSetup

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

The apt_repository resource allows setting up PPAs without using the full URL to ppa.launchpad.net, which should be used to simplify the resource code in your cookbooks.

### Examples

```ruby
# bad
  apt_repository 'atom-ppa' do
    uri 'http://ppa.launchpad.net/webupd8team/atom/ubuntu'
    components ['main']
    keyserver 'keyserver.ubuntu.com'
    key 'C2518248EEA14886'
  end

# good
  apt_repository 'atom-ppa' do
    uri 'ppa:webupd8team/atom'
    components ['main']
    keyserver 'keyserver.ubuntu.com'
    key 'C2518248EEA14886'
  end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.21.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizesimplifyaptppasetup](https://rubystyle.guide#chefmodernizesimplifyaptppasetup)

## ChefModernize/SysctlParamResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 14.0+

The sysctl_param resource was renamed to sysctl when it was added to Chef Infra Client 14.0. The new resource name should be used.

  # bad
  sysctl_param 'fs.aio-max-nr' do
    value '1048576'
  end

  # good
  sysctl 'fs.aio-max-nr' do
    value '1048576'
  end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizesysctlparamresource](https://rubystyle.guide#chefmodernizesysctlparamresource)

## ChefModernize/UnnecessaryDependsChef14

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 14.0+

Don't depend on cookbooks made obsolete by Chef Infra Client 14+. These community cookbooks contain resources that are now included in Chef Infra Client itself.

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

### References

* [https://rubystyle.guide#chefmodernizeunnecessarydependschef14](https://rubystyle.guide#chefmodernizeunnecessarydependschef14)

## ChefModernize/UnnecessaryMixlibShelloutRequire

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Chef Infra Client 12.4+ includes mixlib/shellout automatically in resources and providers.

### Examples

```ruby
# bad
require 'mixlib/shellout'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.12.0` | String
Include | `**/resources/*.rb`, `**/providers/*.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeunnecessarymixlibshelloutrequire](https://rubystyle.guide#chefmodernizeunnecessarymixlibshelloutrequire)

## ChefModernize/UseBuildEssentialResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use the build_essential resource from the build-essential cookbook 5.0+ or Chef Infra Client 14+ instead of using the build-essential::default recipe.

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

### References

* [https://rubystyle.guide#chefmodernizeusebuildessentialresource](https://rubystyle.guide#chefmodernizeusebuildessentialresource)

## ChefModernize/UseMultipackageInstalls

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Pass an array of packages to package resources instead of interating over an array of packages when using multi-package capable package subystem such as apt, yum, chocolatey, dnf, or zypper. Multipackage installs are faster and simplify logs.

### Examples

```ruby
# bad
%w(bmon htop vim curl).each do |pkg|
  package pkg do
    action :install
  end
end

# good
package %w(bmon htop vim curl)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.0.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizeusemultipackageinstalls](https://rubystyle.guide#chefmodernizeusemultipackageinstalls)

## ChefModernize/UseRequireRelative

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Instead of using require with a File.expand_path and __FILE__ use the simpler require_relative method.

### Examples

```ruby
# bad
require File.expand_path('../../libraries/helpers', __FILE__)

# good
require_relative '../libraries/helpers'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.22.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizeuserequirerelative](https://rubystyle.guide#chefmodernizeuserequirerelative)

## ChefModernize/UsesZypperRepo

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 13.3+

The zypper_repo resource was renamed zypper_repository when it was added to Chef Infra Client 13.3.

### Examples

```ruby
# bad
zypper_repo 'apache' do
  baseurl 'http://download.opensuse.org/repositories/Apache'
  path '/openSUSE_Leap_42.2'
  type 'rpm-md'
  priority '100'
end

# good
zypper_repository 'apache' do
  baseurl 'http://download.opensuse.org/repositories/Apache'
  path '/openSUSE_Leap_42.2'
  type 'rpm-md'
  priority '100'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefmodernizeuseszypperrepo](https://rubystyle.guide#chefmodernizeuseszypperrepo)

## ChefModernize/WhyRunSupportedTrue

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 13.0+

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

### References

* [https://rubystyle.guide#chefmodernizewhyrunsupportedtrue](https://rubystyle.guide#chefmodernizewhyrunsupportedtrue)

## ChefModernize/WindowsRegistryUAC

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 15.0+

Chef Infra Client 15.0 and later includes a windows_uac resource that should be used to set Windows UAC values instead of setting registry keys directly.

  # bad
  registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' do
    values [{ name: 'EnableLUA', type: :dword, data: 0 },
            { name: 'PromptOnSecureDesktop', type: :dword, data: 0 },
            { name: 'ConsentPromptBehaviorAdmin', type: :dword, data: 0 },
           ]
    action :create
  end

 # good
 windows_uac 'Set Windows UAC settings' do
   enable_uac false
   prompt_on_secure_desktop true
   consent_behavior_admins :no_prompt
 end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.22.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizewindowsregistryuac](https://rubystyle.guide#chefmodernizewindowsregistryuac)

## ChefModernize/WindowsScResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 14.0+

The sc_windows resource from the sc cookbook allowed for the creation of windows services on legacy Chef Infra Client releases. Chef Infra Client 14.0 and later includes :create, :delete, and :configure actions without the need for additional cookbook dependencies. See the windows_service documentation at https://docs.chef.io/resource_windows_service.html for additional details on creating services with the windows_service resource.

  # bad
  sc_windows 'chef-client' do
    path "C:\\opscode\\chef\\bin"
    action :create
  end

  # good
  windows_service 'chef-client' do
    action :create
    binary_path_name "C:\\opscode\\chef\\bin"
  end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefmodernizewindowsscresource](https://rubystyle.guide#chefmodernizewindowsscresource)

## ChefModernize/WindowsZipfileUsage

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 15.0+

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

### References

* [https://rubystyle.guide#chefmodernizewindowszipfileusage](https://rubystyle.guide#chefmodernizewindowszipfileusage)

## ChefModernize/ZipfileResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 15.0+

Use the archive_file resource built into Chef Infra Client 15+ instead of the zipfile resource from the zipfile cookbook.

### Examples

```ruby
# bad
zipfile "C:\file.zip" do
  path 'C:\expand_here'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.12.0` | String

### References

* [https://rubystyle.guide#chefmodernizezipfileresource](https://rubystyle.guide#chefmodernizezipfileresource)
