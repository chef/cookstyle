# ChefEffortless

## ChefEffortless/CookbookUsesDatabags

Enabled by default | Supports autocorrection
--- | ---
Disabled | No

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

## ChefEffortless/CookbookUsesSearch

Enabled by default | Supports autocorrection
--- | ---
Disabled | No

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
