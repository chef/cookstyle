# Chef/Effortless

## Chef/Effortless/Berksfile

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | All Versions

Policyfiles should be used for cookbook dependency solving instead of a Berkshelf Berksfile.

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.12.0` | String
Include | `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefeffortlessberksfile](https://rubystyle.guide#chefeffortlessberksfile)

## Chef/Effortless/ChefVaultUsed

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | All Versions

Chef Vault is not supported in the Effortless pattern, so usage of Chef Vault must be shifted to another secrets management solution before leveraging the Effortless pattern.

### Examples

```ruby
# bad
require 'chef-vault'

# bad
ChefVault::Item

# bad
include_recipe 'chef-vault'

# bad
chef_gem 'chef-vault'

# bad
chef_vault_item_for_environment(arg, arg1)

# bad
chef_vault_item(arg, arg1)
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.19` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefeffortlesscookbookuseschefvault](https://rubystyle.guide#chefeffortlesscookbookuseschefvault)

## Chef/Effortless/CookbookUsesDatabags

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | All Versions

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
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefeffortlesscookbookusesdatabags](https://rubystyle.guide#chefeffortlesscookbookusesdatabags)

## Chef/Effortless/CookbookUsesEnvironments

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | All Versions

Neither Policyfiles or Effortless Infra which is based on Policyfiles supports Chef Environments

### Examples

```ruby
# bad
node.environment == "production"
node.chef_environment == "production"
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.10.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefeffortlesscookbookusesenvironments](https://rubystyle.guide#chefeffortlesscookbookusesenvironments)

## Chef/Effortless/CookbookUsesPolicygroups

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | All Versions

Effortless Infra does not support Policyfile's Policygroup feature

### Examples

```ruby
# bad
node.policy_group == "foo"
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.10.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefeffortlesscookbookusespolicygroups](https://rubystyle.guide#chefeffortlesscookbookusespolicygroups)

## Chef/Effortless/CookbookUsesRoles

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | All Versions

Neither Policyfiles or Effortless Infra which is based on Policyfiles supports Chef Infra Roles

### Examples

```ruby
# bad
node.role?('web_server')
node.roles.include?('web_server')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.10.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefeffortlesscookbookusesroles](https://rubystyle.guide#chefeffortlesscookbookusesroles)

## Chef/Effortless/CookbookUsesSearch

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | All Versions

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
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefeffortlesscookbookusessearch](https://rubystyle.guide#chefeffortlesscookbookusessearch)

## Chef/Effortless/DependsChefVault

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | All Versions

Chef Vault is not supported in the Effortless pattern, so usage of Chef Vault must be shifted to another secrets management solution before leveraging the Effortless pattern.

### Examples

```ruby
# bad
depends 'chef-vault'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.19` | String
Include | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefeffortlesscookbookdependschefvault](https://rubystyle.guide#chefeffortlesscookbookdependschefvault)

## Chef/Effortless/SearchForEnvironmentsOrRoles

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | All Versions

Policyfiles (and Effortless) do not use environments or roles so searching for those will need to be refactored before migrating to Policyfiles and the Effortless pattern.

### Examples

```ruby
# bad
search(:node, 'chef_environment:foo')
search(:node, 'role:bar')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.11.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefeffortlesssearchforenvironmentsorroles](https://rubystyle.guide#chefeffortlesssearchforenvironmentsorroles)
