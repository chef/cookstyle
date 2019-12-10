# ChefRedundantCode

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

## ChefRedundantCode/PropertyWithRequiredAndDefault

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

## ChefRedundantCode/UnnecessaryNameProperty

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

There is no need to define a property named :name in a resource as Chef Infra defines that property for all resources by default.

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
VersionChanged | `5.15.0` | String
Include | `**/resources/*.rb`, `**/libraries/*.rb` | Array
