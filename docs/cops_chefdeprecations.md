# ChefDeprecations

## ChefDeprecations/ChefDKGenerators

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Chef Workstation 0.8 and later renamed the ChefDK module used when writing custom cookbook generators from ChefDK to ChefCLI. For compatibility with the latest Chef Workstation releases you'll need to reference the new class names.

### Examples

```ruby
# bad
ChefDK::CLI
ChefDK::Generator::TemplateHelper
module ChefDK
  ...
end

# good
ChefCLI::CLI
ChefCLI::Generator::TemplateHelper
module ChefCLI
  ...
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.12.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationschefdkgenerators](https://rubystyle.guide#chefdeprecationschefdkgenerators)

## ChefDeprecations/ChefHandlerRecipe

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

There is no need to include the empty and deprecated chef_handler::default recipe in order to use the chef_handler resource

### Examples

```ruby
# bad
include_recipe 'chef_handler'
include_recipe 'chef_handler::default'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.12.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationschefhandlerrecipe](https://rubystyle.guide#chefdeprecationschefhandlerrecipe)

## ChefDeprecations/ChefHandlerUsesSupports

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationschefhandlerusessupports](https://rubystyle.guide#chefdeprecationschefhandlerusessupports)

## ChefDeprecations/ChefRewind

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 12.10+

Use delete_resource / edit_resource introduced in Chef Infra Client 12.10 instead of functionality in the deprecated chef-rewind gem

### Examples

```ruby
chef_gem 'chef-rewind'

require 'chef/rewind'

rewind "user[postgres]" do
  home '/var/lib/pgsql/9.2'
  cookbook 'my-postgresql'
end

unwind "user[postgres]"
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.14.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb` | Array

### References

* [https://rubystyle.guide#chefdeprecationschefrewind](https://rubystyle.guide#chefdeprecationschefrewind)

## ChefDeprecations/ChefShellout

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Don't use deprecated Chef::ShellOut which was removed in Chef Infra Client 13.
Use Mixlib::ShellOut instead, which behaves identically or convert to the shell_out
helper provided in chef-utils.

### Examples

```ruby
# bad
include Chef::ShellOut
require 'chef/shellout'
Chef::ShellOut.new('some_command')

# good
include Mixlib::ShellOut
require 'mixlib/shellout'
Mixlib::ShellOut.new('some_command')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.17.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationschefshellout](https://rubystyle.guide#chefdeprecationschefshellout)

## ChefDeprecations/ChefSpecCoverageReport

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationschefspeccoveragereport](https://rubystyle.guide#chefdeprecationschefspeccoveragereport)

## ChefDeprecations/ChefSpecLegacyRunner

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationschefspeclegacyrunner](https://rubystyle.guide#chefdeprecationschefspeclegacyrunner)

## ChefDeprecations/ChefWindowsPlatformHelper

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use `platform?('windows')` instead of the legacy `Chef::Platform.windows?` helper

### Examples

```ruby
# bad
Chef::Platform.windows?

# good
platform?('windows')
platform_family?('windows')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.0.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationschefwindowsplatformhelper](https://rubystyle.guide#chefdeprecationschefwindowsplatformhelper)

## ChefDeprecations/Cheffile

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

No documentation

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.12.0` | String
Include | `**/Cheffile` | Array

### References

* [https://rubystyle.guide#chefdeprecationscheffile](https://rubystyle.guide#chefdeprecationscheffile)

## ChefDeprecations/ChocolateyPackageUninstallAction

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationschocolateypackageuninstallaction](https://rubystyle.guide#chefdeprecationschocolateypackageuninstallaction)

## ChefDeprecations/CookbookDependsOnCompatResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 12.19+

Don't depend on the deprecated compat_resource cookbook made obsolete by Chef Infra Client 12.19+

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

### References

* [https://rubystyle.guide#chefdeprecationscookbookdependsoncompatresource](https://rubystyle.guide#chefdeprecationscookbookdependsoncompatresource)

## ChefDeprecations/CookbookDependsOnPartialSearch

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 13.0+

Don't depend on the partial_search cookbook made obsolete by Chef Infra Client 13

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

### References

* [https://rubystyle.guide#chefdeprecationscookbookdependsonpartialsearch](https://rubystyle.guide#chefdeprecationscookbookdependsonpartialsearch)

## ChefDeprecations/CookbookDependsOnPoise

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationscookbookdependsonpoise](https://rubystyle.guide#chefdeprecationscookbookdependsonpoise)

## ChefDeprecations/CookbooksDependsOnSelf

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

No documentation

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
VersionChanged | `6.16.0` | String
Include | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefdeprecationscookbooksdependonself](https://rubystyle.guide#chefdeprecationscookbooksdependonself)

## ChefDeprecations/DeprecatedChefSpecPlatform

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use currently supported platforms in ChefSpec listed at https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md. Fauxhai / ChefSpec will perform fuzzy matching on platform version so it's always best to be less specific ie. 10 instead of 10.3

### Examples

```ruby
let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') }
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.20.0` | String
Include | `**/spec/**/*.rb` | Array

### References

* [https://rubystyle.guide#chefdeprecationsdeprecatedchefspecplatform](https://rubystyle.guide#chefdeprecationsdeprecatedchefspecplatform)

## ChefDeprecations/DeprecatedPlatformMethods

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

Use provider_for_action or provides instead of the deprecated Chef::Platform methods in resources, which were removed in Chef Infra Client 13.

### Examples

```ruby
# bad
resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
provider = Chef::Platform.provider_for_resource(resource, :create)

resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
provider = Chef::Platform.find_provider("ubuntu", "16.04", resource)

resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
provider = Chef::Platform.find_provider_for_node(node, resource)

Chef::Platform.set :platform => :mac_os_x, :resource => :package, :provider => Chef::Provider::Package::Homebrew

# good
resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
provider = resource.provider_for_action(:create)

# provides :package, platform_family: 'mac_os_x'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
VersionChanged | `6.17.0` | String
Include | `**/libraries/*.rb`, `**/resources/*.rb`, `**/providers/*.rb` | Array

### References

* [https://rubystyle.guide#chefdeprecationsdeprecatedplatformmethods](https://rubystyle.guide#chefdeprecationsdeprecatedplatformmethods)

## ChefDeprecations/DeprecatedShelloutMethods

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 14.3+

The large number of shell_out helper methods in Chef Infra Client has been reduced to just shell_out and shell_out! methods. The legacy methods were removed in Chef Infra Client and cookbooks using these legacy helpers will need to be updated.

### Examples

```ruby
# bad
shell_out_compact('foo')
shell_out_compact!('foo')
shell_out_with_timeout('foo')
shell_out_with_timeout!('foo')
shell_out_with_systems_locale('foo')
shell_out_with_systems_locale!('foo')
shell_out_compact_timeout('foo')
shell_out_compact_timeout!('foo')

# good
shell_out('foo')
shell_out!('foo')
shell_out!('foo', default_env: false) # replaces shell_out_with_systems_locale
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.3.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsdeprecatedshelloutmethods](https://rubystyle.guide#chefdeprecationsdeprecatedshelloutmethods)

## ChefDeprecations/DeprecatedWindowsVersionCheck

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

Don't use the deprecated older_than_win_2012_or_8? helper. Windows versions before 2012 and 8 are now end of life and this helper will always return false.

### Examples

```ruby
# bad
if older_than_win_2012_or_8?
  # do some legacy things
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.0.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsdeprecatedwindowsversioncheck](https://rubystyle.guide#chefdeprecationsdeprecatedwindowsversioncheck)

## ChefDeprecations/DeprecatedYumRepositoryProperties

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 12.14+

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

### References

* [https://rubystyle.guide#chefdeprecationsdeprecatedyumrepositoryproperties](https://rubystyle.guide#chefdeprecationsdeprecatedyumrepositoryproperties)

## ChefDeprecations/EOLAuditModeUsage

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

The beta Audit Mode for Chef Infra Client was removed in Chef Infra Client 15.0. Users should instead use InSpec and the audit cookbook. See https://www.inspec.io/ for more information.

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

### References

* [https://rubystyle.guide#chefdeprecationseolauditmodeusage](https://rubystyle.guide#chefdeprecationseolauditmodeusage)

## ChefDeprecations/EasyInstallResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

Don't use the deprecated easy_install resource removed in Chef Infra Client 13

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
Exclude | `**/attributes/*.rb`, `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationseasyinstallresource](https://rubystyle.guide#chefdeprecationseasyinstallresource)

## ChefDeprecations/EpicFail

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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
Exclude | `**/attributes/*.rb`, `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsepicfail](https://rubystyle.guide#chefdeprecationsepicfail)

## ChefDeprecations/ErlCallResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

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
Exclude | `**/attributes/*.rb`, `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationserlcallresource](https://rubystyle.guide#chefdeprecationserlcallresource)

## ChefDeprecations/ExecutePathProperty

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

In Chef Infra Client 13 and later you must set path env vars in execute resources using the `environment` property not the legacy `path` property.

### Examples

```ruby
# bad
execute 'some_cmd' do
  path '/foo/bar'
end

# good
execute 'some_cmd' do
  environment {path: '/foo/bar'}
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.17.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsexecutepathproperty](https://rubystyle.guide#chefdeprecationsexecutepathproperty)

## ChefDeprecations/ExecuteRelativeCreatesWithoutCwd

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

In Chef Infra Client 13 and later you must either specific an absolute path when using the `execute` resource's `creates` property or also use the `cwd` property.

### Examples

```ruby
# bad
execute 'some_cmd' do
  creates 'something'
end

# good
execute 'some_cmd' do
  creates '/tmp/something'
end

execute 'some_cmd' do
  creates 'something'
  cwd '/tmp/'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.17.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsexecuterelativecreateswithoutcwd](https://rubystyle.guide#chefdeprecationsexecuterelativecreateswithoutcwd)

## ChefDeprecations/HWRPWithoutProvides

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Chef Infra Client 16 and later a legacy HWRP resource must use `provides` to define how the resource is called in recipes or other resources. To maintain compatibility with Chef Infra Client < 16 use both `resource_name` and `provides`.

 # good when Chef Infra Client < 15 (but compatible with 16+ as well)
  class Chef
    class Resource
      class UlimitRule < Chef::Resource
        resource_name :ulimit_rule
        provides :ulimit_rule

        property :type, [Symbol, String], required: true
        property :item, [Symbol, String], required: true

        # additional resource code
      end
    end
  end

 # good when Chef Infra Client 16+
  class Chef
    class Resource
      class UlimitRule < Chef::Resource
        provides :ulimit_rule

        property :type, [Symbol, String], required: true
        property :item, [Symbol, String], required: true

        # additional resource code
      end
    end
  end

 # better
 Convert your legacy HWRPs to custom resources

### Examples

```ruby
# bad
class Chef
  class Resource
    class UlimitRule < Chef::Resource
      property :type, [Symbol, String], required: true
      property :item, [Symbol, String], required: true

      # additional resource code
    end
  end
end

# bad
class Chef
  class Resource
    class UlimitRule < Chef::Resource
      resource_name :ulimit_rule

      property :type, [Symbol, String], required: true
      property :item, [Symbol, String], required: true

      # additional resource code
    end
  end
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.0.0` | String
VersionChanged | `6.8.0` | String
Include | `**/libraries/*.rb` | Array

### References

* [https://rubystyle.guide#chefdeprecationsresourcewithoutnameorprovides](https://rubystyle.guide#chefdeprecationsresourcewithoutnameorprovides)

## ChefDeprecations/IncludingXMLRubyRecipe

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Do not include the deprecated xml::ruby recipe to install the nokogiri gem. Chef Infra Client 12 and later ships with nokogiri included.

### Examples

```ruby
# bad
include_recipe 'xml::ruby'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Exclude | `**/attributes/*.rb`, `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsincludingxmlrubyrecipe](https://rubystyle.guide#chefdeprecationsincludingxmlrubyrecipe)

## ChefDeprecations/IncludingYumDNFCompatRecipe

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationsincludingyumdnfcompatrecipe](https://rubystyle.guide#chefdeprecationsincludingyumdnfcompatrecipe)

## ChefDeprecations/LaunchdDeprecatedHashProperty

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 12.19+

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

### References

* [https://rubystyle.guide#chefdeprecationslaunchddeprecatedhashproperty](https://rubystyle.guide#chefdeprecationslaunchddeprecatedhashproperty)

## ChefDeprecations/LegacyNotifySyntax

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use the new-style notification syntax which allows you to notify resources defined later in a recipe or resource.

### Examples

```ruby
# bad
template '/etc/www/configures-apache.conf' do
  notifies :restart, resources(service: 'apache')
end

template '/etc/www/configures-apache.conf' do
  notifies :restart, resources(service: 'apache'), :immediately
end

template '/etc/www/configures-apache.conf' do
  notifies :restart, resources(service: service_name_variable), :immediately
end

template '/etc/www/configures-apache.conf' do
  subscribes :restart, resources(service: service_name_variable), :immediately
end

# good
template '/etc/www/configures-apache.conf' do
  notifies :restart, 'service[apache]'
end

template '/etc/www/configures-apache.conf' do
  notifies :restart, 'service[apache]', :immediately
end

template '/etc/www/configures-apache.conf' do
  notifies :restart, "service[#{service_name_variable}]", :immediately
end

template '/etc/www/configures-apache.conf' do
  subscribes :restart, "service[#{service_name_variable}]", :immediately
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.13.0` | String
Exclude | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefdeprecationslegacynotifysyntax](https://rubystyle.guide#chefdeprecationslegacynotifysyntax)

## ChefDeprecations/LegacyYumCookbookRecipes

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationslegacyyumcookbookrecipes](https://rubystyle.guide#chefdeprecationslegacyyumcookbookrecipes)

## ChefDeprecations/LocaleDeprecatedLcAllProperty

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

The local resource's lc_all property has been deprecated and will be removed in Chef Infra Client 17

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

### References

* [https://rubystyle.guide#chefdeprecationslocaledeprecatedlcallproperty](https://rubystyle.guide#chefdeprecationslocaledeprecatedlcallproperty)

## ChefDeprecations/LogResourceNotifications

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 15.8+

In Chef Infra Client 16 the log resource no longer notifies when logging so notifications should not be triggered from log resources. Use the notify_group resource introduced in Chef Infra Client 15.8 instead to aggregate notifications.

### Examples

```ruby
# bad
template '/etc/foo' do
  source 'bar.erb'
  notifies :write, 'log[Aggregate notifications using a single log resource]', :immediately
end

log 'Aggregate notifications using a single log resource' do
  notifies :restart, 'service[foo]', :delayed
end

# good
template '/etc/foo' do
  source 'bar.erb'
  notifies :run, 'notify_group[Aggregate notifications using a single notify_group resource]', :immediately
end

notify_group 'Aggregate notifications using a single notify_group resource' do
  notifies :restart, 'service[foo]', :delayed
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.0.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationslogresourcenotifications](https://rubystyle.guide#chefdeprecationslogresourcenotifications)

## ChefDeprecations/MacosUserdefaultsGlobalProperty

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 16.3+

The `global` property in the macos_userdefaults resource was deprecated in Chef Infra Client 16.3. This property was never properly implemented and caused failures under many conditions. Omitting the `domain` property will now set global defaults.

### Examples

```ruby
# bad
macos_userdefaults 'set a value' do
  global true
  key 'key'
  value 'value'
end

# good
macos_userdefaults 'set a value' do
  key 'key'
  value 'value'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.14.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsmacosuserdefaultsglobalproperty](https://rubystyle.guide#chefdeprecationsmacosuserdefaultsglobalproperty)

## ChefDeprecations/NamePropertyWithDefaultValue

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

A resource property (or attribute) can't be marked as a name_property (or name_attribute) and also have a default value. The name property is a special property that is derived from the name of the resource block in and thus always has a value passed to the resource. For example if you define `my_resource 'foo'` in recipe, then the name property of `my_resource` will automatically be set to `foo`. Setting a property to be both a name_property and have a default value will cause Chef Infra Client failures in 13.0 and later releases.

### Examples

```ruby
# bad
property :config_file, String, default: 'foo', name_property: true
attribute :config_file, String, default: 'foo', name_attribute: true

# good
property :config_file, String, name_property: true
attribute :config_file, String, name_attribute: true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.7.0` | String
Include | `**/libraries/*.rb`, `**/resources/*.rb` | Array

### References

* [https://rubystyle.guide#chefdeprecationsnamepropertywithdefaultvalue](https://rubystyle.guide#chefdeprecationsnamepropertywithdefaultvalue)

## ChefDeprecations/NodeDeepFetch

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

The node.deep_fetch method has been removed from Chef-Sugar, and must be replaced by the node.read API.

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
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsnodedeepfetch](https://rubystyle.guide#chefdeprecationsnodedeepfetch)

## ChefDeprecations/NodeMethodsInsteadofAttributes

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use node attributes to access data provided by Ohai instead of using node methods to access that data.

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
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsnodemethodsinsteadofattributes](https://rubystyle.guide#chefdeprecationsnodemethodsinsteadofattributes)

## ChefDeprecations/NodeSet

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

The `node.set` method has been removed in Chef Infra Client 13 and usage must be replaced with `node.normal`.

This cop will autocorrect code to use node.normal, which is functionally identical to node.set, but we also discourage the use of that method as normal level attributes persist on the node even if the code setting the attribute is later removed.

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
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsnodeset](https://rubystyle.guide#chefdeprecationsnodeset)

## ChefDeprecations/NodeSetUnless

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

The node.set_unless method has been removed in Chef Infra Client 13 and usage must be replaced with node.normal_unless.

This cop will autocorrect code to use node.normal_unless, which is functionally identical to node.set_unless, but we also discourage the use of that method as normal level attributes persist on the node even if the code setting the attribute is later removed.

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
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsnodesetunless](https://rubystyle.guide#chefdeprecationsnodesetunless)

## ChefDeprecations/NodeSetWithoutLevel

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

When setting a node attribute in Chef Infra Client 11 and later you must specify the precedence level.

### Examples

```ruby
# bad
node['foo']['bar'] = 1
node['foo']['bar'] << 1
node['foo']['bar'] += 1
node['foo']['bar'] -= 1

# good
node.default['foo']['bar'] = 1
node.default['foo']['bar'] << 1
node.default['foo']['bar'] += 1
node.default['foo']['bar'] -= 1
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.13.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb` | Array

### References

* [https://rubystyle.guide#chefdeprecationsnodesetwithoutlevel](https://rubystyle.guide#chefdeprecationsnodesetwithoutlevel)

## ChefDeprecations/PartialSearchClassUsage

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationspartialsearchclassusage](https://rubystyle.guide#chefdeprecationspartialsearchclassusage)

## ChefDeprecations/PartialSearchHelperUsage

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationspartialsearchhelperusage](https://rubystyle.guide#chefdeprecationspartialsearchhelperusage)

## ChefDeprecations/PoiseArchiveUsage

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | 15.0+

The poise_archive resource in the deprecated poise-archive should be replaced with the archive_file resource found in Chef Infra Client 15+.

### Examples

```ruby
# bad
poise_archive 'https://example.com/myapp.tgz' do
  destination '/opt/my_app'
end

# good
archive_file 'https://example.com/myapp.tgz' do
  destination '/opt/my_app'
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.11.0` | String

### References

* [https://rubystyle.guide#chefdeprecationspoisearchiveusage](https://rubystyle.guide#chefdeprecationspoisearchiveusage)

## ChefDeprecations/PowershellCookbookHelpers

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use `node['powershell']['version']` or the new `powershell_version` helper available in Chef Infra Client 15.8+ instead of the deprecated PowerShell cookbook helpers

### Examples

```ruby
# bad
Powershell::VersionHelper.powershell_version?('4.0')

# good
node['powershell']['version'].to_f == 4.0

# better (Chef Infra Client 15.8+)
powershell_version == 4.0
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.1.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationspowershellcookbookhelpers](https://rubystyle.guide#chefdeprecationspowershellcookbookhelpers)

## ChefDeprecations/RequireRecipe

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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
Exclude | `**/attributes/*.rb`, `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsrequirerecipe](https://rubystyle.guide#chefdeprecationsrequirerecipe)

## ChefDeprecations/ResourceInheritsFromCompatResource

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationsresourceinheritsfromcompatresource](https://rubystyle.guide#chefdeprecationsresourceinheritsfromcompatresource)

## ChefDeprecations/ResourceOverridesProvidesMethod

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationsresourceoverridesprovidesmethod](https://rubystyle.guide#chefdeprecationsresourceoverridesprovidesmethod)

## ChefDeprecations/ResourceUsesDslNameMethod

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationsresourceusesdslnamemethod](https://rubystyle.guide#chefdeprecationsresourceusesdslnamemethod)

## ChefDeprecations/ResourceUsesOnlyResourceName

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Starting with Chef Infra Client 16, using `resource_name` without also using `provides` will result in resource failures. Make sure to use both `resource_name` and `provides` to change the name of the resource. You can also omit `resource_name` entirely if the value set matches the name Chef Infra Client automatically assigns based on COOKBOOKNAME_FILENAME.

### Examples

```ruby
# bad
mycookbook/resources/myresource.rb:
resource_name :mycookbook_myresource
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.7.0` | String
Include | `**/libraries/*.rb`, `**/resources/*.rb` | Array

### References

* [https://rubystyle.guide#chefdeprecationsresourceusesonlyresourcename](https://rubystyle.guide#chefdeprecationsresourceusesonlyresourcename)

## ChefDeprecations/ResourceUsesProviderBaseMethod

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationsresourceusesproviderbasemethod](https://rubystyle.guide#chefdeprecationsresourceusesproviderbasemethod)

## ChefDeprecations/ResourceUsesUpdatedMethod

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationsresourceusesupdatedmethod](https://rubystyle.guide#chefdeprecationsresourceusesupdatedmethod)

## ChefDeprecations/Ruby27KeywordArgumentWarnings

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Pass options to shell_out helpers without the brackets to avoid Ruby 2.7 deprecation warnings.

### Examples

```ruby
# bad
shell_out!('hostnamectl status', { returns: [0, 1] })
shell_out('hostnamectl status', { returns: [0, 1] })

# good
shell_out!('hostnamectl status', returns: [0, 1])
shell_out('hostnamectl status', returns: [0, 1])
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.5.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsruby27keywordargumentwarnings](https://rubystyle.guide#chefdeprecationsruby27keywordargumentwarnings)

## ChefDeprecations/RubyBlockCreateAction

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use the :run action in the ruby_block resource instead of the deprecated :create action

### Examples

```ruby
# bad
ruby_block 'my special ruby block' do
  block do
    puts 'running'
  end
  action :create
end

# good
ruby_block 'my special ruby block' do
  block do
    puts 'running'
  end
  action :run
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsrubyblockcreateaction](https://rubystyle.guide#chefdeprecationsrubyblockcreateaction)

## ChefDeprecations/SearchUsesPositionalParameters

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationssearchusespositionalparameters](https://rubystyle.guide#chefdeprecationssearchusespositionalparameters)

## ChefDeprecations/UseAutomaticResourceName

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

The use_automatic_resource_name method was removed in Chef Infra Client 16. The resource name/provides should be set explicitly instead.

### Examples

```ruby
# bad
module MyCookbook
  class MyCookbookService < Chef::Resource
    use_automatic_resource_name
    provides :mycookbook_service
    ...
  end
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.12.0` | String
Include | `**/libraries/*.rb`, `**/resources/*.rb` | Array

### References

* [https://rubystyle.guide#chefdeprecationsuseautomaticresourcename](https://rubystyle.guide#chefdeprecationsuseautomaticresourcename)

## ChefDeprecations/UseInlineResourcesDefined

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationsuseinlineresourcesdefined](https://rubystyle.guide#chefdeprecationsuseinlineresourcesdefined)

## ChefDeprecations/UseYamlDump

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Chef Infra Client 16.5 introduced performance enhancements to Ruby library loading. Due to the underlying implementation of Ruby's `.to_yaml` method, it does not automatically load the `yaml` library and `YAML.dump()` should be used instead to properly load the `yaml` library.

### Examples

```ruby
# bad
{"foo" => "bar"}.to_yaml

# good
YAML.dump({"foo" => "bar"})
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.21.0` | String

### References

* [https://rubystyle.guide#chefdeprecationsuseyamldump](https://rubystyle.guide#chefdeprecationsuseyamldump)

## ChefDeprecations/UserDeprecatedSupportsProperty

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

user 'betty' do
  supports :manage_home => true
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

### References

* [https://rubystyle.guide#chefdeprecationsuserdeprecatedsupportsproperty](https://rubystyle.guide#chefdeprecationsuserdeprecatedsupportsproperty)

## ChefDeprecations/UsesChefRESTHelpers

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationsuseschefresthelpers](https://rubystyle.guide#chefdeprecationsuseschefresthelpers)

## ChefDeprecations/UsesDeprecatedMixins

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

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

### References

* [https://rubystyle.guide#chefdeprecationsusesdeprecatedmixins](https://rubystyle.guide#chefdeprecationsusesdeprecatedmixins)

## ChefDeprecations/UsesRunCommandHelper

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

Use 'shell_out!' instead of the legacy 'run_command' or 'run_command_with_systems_locale' helpers for shelling out. The run_command helper was removed in Chef Infra Client 13.

### Examples

```ruby
# bad
require 'chef/mixin/command'
include Chef::Mixin::Command

run_command('/bin/foo')
run_command_with_systems_locale('/bin/foo')

# good
shell_out!('/bin/foo')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.9.0` | String
Exclude | `**/metadata.rb`, `Rakefile` | Array

### References

* [https://rubystyle.guide#chefdeprecationsusesruncommandhelper](https://rubystyle.guide#chefdeprecationsusesruncommandhelper)

## ChefDeprecations/VerifyPropertyUsesFileExpansion

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 12.5+

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

### References

* [https://rubystyle.guide#chefdeprecationsverifypropertyusesfileexpansion](https://rubystyle.guide#chefdeprecationsverifypropertyusesfileexpansion)

## ChefDeprecations/WindowsFeatureServermanagercmd

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

The `windows_feature` resource no longer supports setting the `install_method` to `:servermanagercmd`. `:windows_feature_dism` or `:windows_feature_powershell` should be used instead.

### Examples

```ruby
# bad
windows_feature 'DHCP' do
  install_method :servermanagercmd
end

# good
windows_feature 'DHCP' do
  install_method :windows_feature_dism
end

windows_feature 'DHCP' do
  install_method :windows_feature_powershell
end

windows_feature_dism 'DHCP'

windows_feature_powershell 'DHCP'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.22.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationswindowsfeatureservermanagercmd](https://rubystyle.guide#chefdeprecationswindowsfeatureservermanagercmd)

## ChefDeprecations/WindowsPackageInstallerTypeString

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

In Chef Infra Client 13 and later the `windows_package` resource's `installer_type` property must be a symbol.

### Examples

```ruby
# bad
windows_package 'AppveyorDeploymentAgent' do
  source 'https://www.example.com/appveyor.msi'
  installer_type 'msi'
  options "/quiet /qn /norestart /log install.log"
end

# good
windows_package 'AppveyorDeploymentAgent' do
  source 'https://www.example.com/appveyor.msi'
  installer_type :msi
  options "/quiet /qn /norestart /log install.log"
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.17.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationswindowspackageinstallertypestring](https://rubystyle.guide#chefdeprecationswindowspackageinstallertypestring)

## ChefDeprecations/WindowsTaskChangeAction

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 13.0+

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

### References

* [https://rubystyle.guide#chefdeprecationswindowstaskchangeaction](https://rubystyle.guide#chefdeprecationswindowstaskchangeaction)

## ChefDeprecations/WindowsVersionHelpers

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | 14.0+

Use node['platform_version'] and node['kernel'] data instead of the deprecated Windows::VersionHelper helpers from the Windows cookbook.

### Examples

```ruby
# bad
Windows::VersionHelper.nt_version
Windows::VersionHelper.server_version?
Windows::VersionHelper.core_version?
Windows::VersionHelper.workstation_version?

# good
node['platform_version'].to_f
node['kernel']['product_type'] == 'Server'
node['kernel']['server_core']
node['kernel']['product_type'] == 'Workstation'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefdeprecationswindowsversionhelpers](https://rubystyle.guide#chefdeprecationswindowsversionhelpers)
