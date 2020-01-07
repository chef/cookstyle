# ChefSharing

## ChefSharing/DefaultMetadataMaintainer

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

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

## ChefSharing/EmptyMetadataField

Enabled by default | Supports autocorrection
--- | ---
Enabled | No

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

## ChefSharing/InsecureCookbookURL

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

Use secure Github and Gitlab URLs for source_url and issues_url

### Examples

```ruby
# bad
source_url 'http://github.com/something/something'
source_url 'http://www.github.com/something/something'
source_url 'http://www.gitlab.com/something/something'
source_url 'http://gitlab.com/something/something'

# good
source_url 'https://github.com/something/something'
source_url 'https://gitlab.com/something/something'
```

### Configurable attributes

Name | Default value | Configurable values
--- | --- | ---
VersionAdded | `5.1.0` | String
VersionChanged | `5.15.0` | String
Include | `**/metadata.rb` | Array

## ChefSharing/InvalidLicenseString

Enabled by default | Supports autocorrection
--- | ---
Enabled | Yes

metadata.rb license field should include a SPDX compliant string or "all right reserved" (not case sensitive)

list of valid SPDX.org license strings. To build an array run this:

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
