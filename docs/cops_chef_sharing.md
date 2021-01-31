# Chef/Sharing

## Chef/Sharing/DefaultMetadataMaintainer

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

Metadata contains default maintainer information from the `chef generate cookbook` command. This should be updated to reflect that actual maintainer of the cookbook.

### Examples

```ruby
# bad
maintainer 'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
maintainer 'The Authors'
maintainer_email 'you@example.com'
# good
maintainer 'Bob Bobberson'
maintainer_email 'bob@bobberson.com'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.4.0` | String
VersionChanged | `5.15.0` | String
Include | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefsharingdefaultmetadatamaintainer](https://rubystyle.guide#chefsharingdefaultmetadatamaintainer)

## Chef/Sharing/EmptyMetadataField

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | No | All Versions

metadata.rb should not include fields with an empty string. Either don't include the field or add a value.

### Examples

```ruby
# bad
license ''

# good
license 'Apache-2.0'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.8.0` | String
VersionChanged | `5.15.0` | String
Include | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefsharingemptymetadatafield](https://rubystyle.guide#chefsharingemptymetadatafield)

## Chef/Sharing/IncludePropertyDescriptions

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | 13.9+

Resource properties should include description fields to allow automated documentation. Requires Chef Infra Client 13.9 or later.

### Examples

```ruby
# bad
property :foo, String

# good
property :foo, String, description: "Set the important thing to..."
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.1.0` | String
Include | `**/libraries/*.rb`, `**/resources/*.rb` | Array

### References

* [https://rubystyle.guide#chefsharingincludepropetydescriptions](https://rubystyle.guide#chefsharingincludepropetydescriptions)

## Chef/Sharing/IncludeResourceDescriptions

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | 13.9+

Resources should include description fields to allow automated documentation. Requires Chef Infra Client 13.9 or later.

### Examples

```ruby
# good
resource_name :foo
description "The foo resource is used to do..."
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.1.0` | String
Include | `**/resources/*.rb` | Array

### References

* [https://rubystyle.guide#chefsharingincluderesourcedescriptions](https://rubystyle.guide#chefsharingincluderesourcedescriptions)

## Chef/Sharing/IncludeResourceExamples

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Disabled | No | 13.9+

Resources should include examples field to allow automated documentation. Requires Chef Infra Client 13.9 or later.

### Examples

```ruby
# good
examples <<~DOC
  **Specify a global domain value**

  ```ruby
  macos_userdefaults 'full keyboard access to all controls' do
    key 'AppleKeyboardUIMode'
    value '2'
  end
  ```
DOC
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `6.10.0` | String
Include | `**/resources/*.rb` | Array

### References

* [https://rubystyle.guide#chefsharingincluderesourceexamples](https://rubystyle.guide#chefsharingincluderesourceexamples)

## Chef/Sharing/InsecureCookbookURL

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

Use secure Github and Gitlab URLs for source_url and issues_url

### Examples

```ruby
# bad
source_url 'http://github.com/something/something'
source_url 'http://www.github.com/something/something'
source_url 'http://www.gitlab.com/something/something'
source_url 'http://gitlab.com/something/something'

# good
source_url 'http://github.com/something/something'
source_url 'http://gitlab.com/something/something'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
VersionChanged | `5.15.0` | String
Include | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefsharinginsecurecookbookurl](https://rubystyle.guide#chefsharinginsecurecookbookurl)

## Chef/Sharing/InvalidLicenseString

Enabled by default | Supports autocorrection | Target Chef Version
--- | --- | ---
Enabled | Yes | All Versions

metadata.rb license field should include a SPDX compliant string or "all right reserved" (not case sensitive)

list of valid SPDX.org license strings. To build an array run this ruby:
```ruby
require 'json'
require 'net/http'
json_data = JSON.parse(Net::HTTP.get(URI('https://raw.githubusercontent.com/spdx/license-list-data/master/json/licenses.json')))
licenses = json_data['licenses'].map {|l| l['licenseId'] }.sort
```

### Examples

```ruby
# bad
license 'Apache 2.0'

# good
license 'Apache-2.0'
license 'all rights reserved'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.2.0` | String
VersionChanged | `5.15.0` | String
Include | `**/metadata.rb` | Array

### References

* [https://rubystyle.guide#chefsharinginvalidlicensestring](https://rubystyle.guide#chefsharinginvalidlicensestring)
