# ChefEffortless

## ChefEffortless/Berksfile

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

## ChefEffortless/CookbookUsesDatabags

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

## ChefEffortless/CookbookUsesEnvironmments

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

## ChefEffortless/CookbookUsesPolicygroups

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

## ChefEffortless/CookbookUsesRoles

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | All Versions

Neither Policyfiles or Effortless Infra which is based on Policyfiles supports Chef Roles

### Examples

```ruby
# bad
node.role?('webserver')
node.roles.include?('webserver')
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.10.0` | String
Exclude | `**/metadata.rb`, `**/Berksfile` | Array

### References

* [https://rubystyle.guide#chefeffortlesscookbookusesroles](https://rubystyle.guide#chefeffortlesscookbookusesroles)

## ChefEffortless/CookbookUsesSearch

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

## ChefEffortless/SearchForEnvironmentsOrRoles

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
