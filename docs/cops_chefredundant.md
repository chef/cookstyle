# ChefRedundant

## ChefRedundant/CustomResourceWithAllowedActions

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
