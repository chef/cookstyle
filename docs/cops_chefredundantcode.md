# ChefRedundantCode

## ChefRedundantCode/AptRepositoryDistributionDefault

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

There is no need to pass `distribution node['lsb']['codename']` to an apt_repository resource as this is done automatically by the apt_repository resource.

  # bad
  apt_repository 'my repo' do
    uri 'http://packages.example.com/debian'
    components %w(stable main)
    deb_src false
    distribution node['lsb']['codename']
  end

  # good
  apt_repository 'my repo' do
    uri 'http://packages.example.com/debian'
    components %w(stable main)
    deb_src false
  end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.17.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

## ChefRedundantCode/AptRepositoryNotifiesAptUpdate

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

There is no need to notify an apt-get update when an apt_repository is created as this is done automatically by the apt_repository resource.

  # bad
  apt_repository 'my repo' do
    uri 'http://packages.example.com/debian'
    components %w(stable main)
    deb_src false
    notifies :run, 'execute[apt-get update]', :immediately
  end

  # good
  apt_repository 'my repo' do
    uri 'http://packages.example.com/debian'
    components %w(stable main)
    deb_src false
  end

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.17.0` | String
Exclude | `**/metadata.rb`, `**/attributes/*.rb`, `**/Berksfile` | Array

## ChefRedundantCode/AttributeMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The attribute metadata.rb method is not used and is unnecessary in cookbooks.

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
VersionChanged | `5.15.0` | String
Include | `**/metadata.rb` | Array

## ChefRedundantCode/ConflictsMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The conflicts metadata.rb method is not used and is unnecessary in cookbooks.

### Examples

```ruby
# bad in metadata.rb:

conflicts "another_cookbook"
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
VersionChanged | `5.15.0` | String
Include | `**/metadata.rb` | Array

## ChefRedundantCode/CustomResourceWithAllowedActions

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

It is not necessary to set `actions` or `allowed_actions` in custom resources as Chef Infra Client determines these automatically from the set of all actions defined in the resource.

### Examples

```ruby
# bad
allowed_actions [:create, :remove]

# also bad
actions [:create, :remove]
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
VersionChanged | `5.15.0` | String
Include | `**/resources/*.rb` | Array

## ChefRedundantCode/GroupingMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The grouping metadata.rb method is not used and is unnecessary in cookbooks.

### Examples

```ruby
# bad
grouping 'windows_log_rotate', title: 'Demonstration cookbook with code to switch loggers'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.19.0` | String
Include | `**/metadata.rb` | Array

## ChefRedundantCode/LongDescriptionMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The long_description metadata.rb method is not used and is unnecessary in cookbooks.

### Examples

```ruby
# bad
long_description 'this is my cookbook and this description will never be seen'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
VersionChanged | `5.15.0` | String
Include | `**/metadata.rb` | Array

## ChefRedundantCode/NamePropertyIsRequired

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
attribute :config_file, String, required: true, name_attribute: true

# good
property :config_file, String, required: true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
VersionChanged | `5.15.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

## ChefRedundantCode/PropertySplatRegex

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

When a property has a type of String it can accept any string. There is no need to also validate string inputs against a regex that accept all values.

### Examples

```ruby
# bad
property :config_file, String, regex: /.*/
attribute :config_file, String, regex: /.*/

# good
property :config_file, String
attribute :config_file, String
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.21.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

## ChefRedundantCode/PropertyWithRequiredAndDefault

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

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
VersionChanged | `5.15.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

## ChefRedundantCode/ProvidesMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The provides metadata.rb method is not used and is unnecessary in cookbooks.

### Examples

```ruby
# bad in metadata.rb:

provides "some_thing"
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
VersionChanged | `5.15.0` | String
Include | `**/metadata.rb` | Array

## ChefRedundantCode/RecipeMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The recipe metadata.rb method is not used and is unnecessary in cookbooks. Recipes should be documented in the cookbook's README.md file instead.

### Examples

```ruby
# bad
recipe 'openldap::default', 'Install and configure OpenLDAP'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.6.0` | String
VersionChanged | `5.15.0` | String
Include | `**/metadata.rb` | Array

## ChefRedundantCode/ReplacesMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The replaces metadata.rb method is not used and is unnecessary in cookbooks. Replacements for existing cookbooks should be documented in the cookbook's README.md file instead.

### Examples

```ruby
# bad in metadata.rb:

replaces "another_cookbook"
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
VersionChanged | `5.15.0` | String
Include | `**/metadata.rb` | Array

## ChefRedundantCode/ResourceWithNothingAction

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Chef Infra Client provides the :nothing action by default for every resource. There is no need to define a :nothing action in your resource code.

### Examples

```ruby
# bad
action :nothing
  # let's do nothing
end
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.12.0` | String
VersionChanged | `5.15.0` | String
Include | `**/libraries/*.rb`, `**/resources/*.rb`, `**/providers/*.rb` | Array

## ChefRedundantCode/SensitivePropertyInResource

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Every Chef Infra resources already include a sensitive property with a default value of false.

# bad
property :sensitive, [true, false], default: false

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

## ChefRedundantCode/StringPropertyWithNilDefault

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Properties have a nil value by default so there is no need to set the default value to nil.

### Examples

```ruby
# bad
property :config_file, String, default: nil
property :config_file, [String, NilClass], default: nil

# good
property :config_file, String
property :config_file, [String, NilClass]
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.21.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

## ChefRedundantCode/SuggestsMetadata

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

The suggests metadata.rb method is not used and is unnecessary in cookbooks.

### Examples

```ruby
# bad in metadata.rb:

suggests "another_cookbook"
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
VersionChanged | `5.15.0` | String
Include | `**/metadata.rb` | Array

## ChefRedundantCode/UnnecessaryDesiredState

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

There is no need to set a property to desired_state: true as all properties have a desired_state of true by default.

### Examples

```ruby
# bad
property :foo, String, desired_state: true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.16.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array

## ChefRedundantCode/UnnecessaryNameProperty

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

There is no need to define a property or attribute named :name in a resource as Chef Infra defines this on all resources by default.

### Examples

```ruby
# bad
property :name, String
property :name, String, name_property: true
attribute :name, String
attribute :name, String, name_attribute: true
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.8.0` | String
VersionChanged | `5.15.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array
