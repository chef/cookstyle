# Chef Cookstyle - Chef Infra Cookbook linting with autocorrection

[![Build status](https://badge.buildkite.com/c086ffe05e32e4d61282b91ead96b3721590a59ed4360cf7ac.svg?branch=master)](https://buildkite.com/chef-oss/chef-cookstyle-master-verify)
[![Gem Version](https://badge.fury.io/rb/cookstyle.svg)](https://badge.fury.io/rb/cookstyle)

* **Umbrella Project**: [Chef Infra](https://github.com/chef/chef-oss-practices/blob/master/projects/chef-infra.md)
* **[Project State](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md):** Active
* **Issues [Response Time Maximum](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md):** 14 days
* **Pull Request [Response Time Maximum](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md):** 14 days

Cookstyle is a [code linting](https://en.wikipedia.org/wiki/Lint_%28software%29) tool that helps you to write better Chef Infra cookbooks by detecting and automatically correcting style, syntax, and logic mistakes in your code.

Cookstyle is powered by the [RuboCop](http://www.rubocop.org) linting engine. RuboCop ships with over three-hundred rules, or cops, designed to detect common Ruby coding mistakes and enforce a common coding style. We've customized Cookstyle with a subset of those cops that we believe are perfectly tailored for cookbook development. We also ship **178 Chef Infra specific cops** that catch common cookbook coding mistakes, cleanup portions of code that are no longer necessary, and detect deprecations that prevent cookbooks from running on the latest releases of Chef Infra Client.

For a complete list of Cookstyle rules see the [Cops Documentation](https://github.com/chef/cookstyle/blob/master/docs/cops.md)

## Cookstyle vs. RuboCop

How does Cookstyle differ from RuboCop?

#### Tailored for Cookbooks

Cookbook development differs from that of traditional Ruby software development, so we have tailored the list of built-in cops in RuboCop for cookbook development. For the most part, this means disabling cops deemed not useful for cookbook development. Occasionally, we've changed the configuration of a rule to enforce a different behavior altogether. We've also extended the base RuboCop package with a set of our own Chef Infra-specific cops. These cops are only found in Cookstyle and will help you to write more reliable and future-proof cookbooks.

See the current set of cops in [config/cookstyle.yml](https://github.com/chef/cookstyle/blob/master/config/cookstyle.yml).

#### Stable

RuboCop is an incredibly active project with new cops being introduced monthly. The new cops cause existing codebases to fail CI tests and force authors to constantly update their code. With Cookstyle, we update the RuboCop engine for bug and performance fixes, but we only change the set of cops that will fail tests once a year during Chef Infra's April major release. All new cops are introduced at RuboCop's "refactor" alert level, meaning they will alert to the screen as you run Cookstyle, but they won't fail a build. This stability means you are free to upgrade releases of Cookstyle without being forced to update your infrastructure code.

## Cookstyle vs. Foodcritic

Cookstyle is the replacement for Foodcritic. For more information on why we decided to replace Foodcritic see our blog post [Goodbye Foodcritic](https://blog.chef.io/goodbye-foodcritic/)

## Installation

Cookstyle is included in the [ChefDK](https://downloads.chef.io/chefdk) and [Chef Workstation](https://downloads.chef.io/chef-workstation/). If you choose not to use these packages, you can still install Cookstyle manually using the instructions below.

Add this line to your application's Gemfile:

```ruby
gem 'cookstyle'
```

And then execute:

```shell
bundle
```

Or install it yourself as:

```shell
gem install cookstyle
```

## Usage

### cookstyle Command

Use this tool just as you would RuboCop, but invoke the `cookstyle` binary instead, which patches RuboCop to load cops from the cookstyle gem. For example:

```shell
cookstyle -D --format offenses
```

### Rake

In a Rakefile, the setup is similar, except you need to require the cookstyle library first:

```ruby
require "cookstyle"
require "rubocop/rake_task"
RuboCop::RakeTask.new do |task|
  task.options << "--display-cop-names"
end
```

### From RuboCop

Run RuboCop as normal, and simply add a `-r cookstyle` option when running:

```sh
rubocop -r cookstyle -D --format offenses
```

### guard-rubocop

You can use one of two methods. The simplest is to add the `-r cookstyle` option to the `:cli` option in your Guardfile:

```ruby
guard :rubocop, cli: "-r cookstyle" do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
```

Alternatively you could pass the path to Cookstyle's configuration by using the `Cookstyle.config` method:

```ruby
require "cookstyle"

guard :rubocop, cli: "--config #{Cookstyle.config}" do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
```

### .rubocop.yml

As with RuboCop, any custom settings can still be placed in a `.rubocop.yml` file in the root of your project.

### Testing Against Specific Chef Versions

Many of the cops included in Cookstyle will autocorrect Chef Infra cookbook code in ways that will require fairly recent releases of Chef Infra Client in order to run those cookbooks. For example the `ChefModernize/UnnecessaryDependsChef14` cop will remove cookbook dependencies from your `metadata.rb` which are no longer necessary with Chef Infra Client 14+. This cop would be problematic if you ran it against your cookbooks, and had yet to upgrade your fleet of systems to Chef Infra Client 14+. For this reason you may want to configure Cookstyle to skip cops that would be destructive on older version of Chef Infra Client by setting.

Cookstyle now includes a new top-level configuration option TargetChefVersion. This new configuration option works similarly to RuboCop's TargetRubyVersion config option and allows you to specify a Chef Infra version that you want to target in your Cookstyle analysis. By setting the target version you disable incompatible cops and autocorrect from running. This allows you to gradually update your target version to allow stepped upgrades of Chef Infra Client such as 12.something -> 12.latest -> 13.latest -> 14.lastest -> 15.latest.

Example .rubocop.yml config specifying a TargetChefVersion of 14.0:

```yaml
AllCops:
  TargetChefVersion: 14.0
```

## Getting Involved

We'd love to have your help in developing Cookstyle. See our [Contributing Guide](https://github.com/chef/chef/blob/master/CONTRIBUTING.md) for more information on contributing to Chef projects. There's also a [Developer Guide](./DEVELOPER_GUIDE.md) for Cookstyle that outlines how the configs work and how you can upgrade the RuboCop engine.

## License and Copyright

Copyright 2016-2019, Chef Software, Inc.

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
