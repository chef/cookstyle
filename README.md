# Cookstyle - Version Pinned rubocop and sane defaults for Chef Cookbooks

Pull requests to this repo will not be accepted without corresponding
PRs into at least the chef-client and ohai codebases to clean the
code up.  PRs will not be accepted that assume unfunded mandates for
other people to finish the work.  Do not open PRs offering opinions
or suggestions without offering to do the work.

The project itself is a derivative of
[finstyle](https://github.com/fnichol/finstyle), but starts with all
rules disabled.  The active ruleset is in the
[config/cookstyle.yml](https://github.com/chef/cookstyle/blob/master/config/cookstyle.yml)
file.

## How It Works

This library has a direct dependency on one specific version of RuboCop (at a time), and [patches it][patch] to load the [upstream configuration][upstream] and [custom set][config] of rule updates. When a new RuboCop release comes out, this library can rev its pinned version dependency and [re-vendor][rakefile] the upstream configuration to determine if any breaking style or lint rules were added/dropped/reversed/etc.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cookstyle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cookstyle

## Usage

### Vanilla RuboCop

Run RuboCop as normal, simply add a `-r cookstyle` option when running:

```sh
rubocop -r cookstyle -D --format offenses
```

### cookstyle Command

Use this tool just as you would RuboCop, but invoke the `cookstyle` binary
instead which patches RuboCop to load rules from the cookstyle gem. For example:

```sh
cookstyle -D --format offenses
```

### Rake

In a Rakefile, the setup is exactly the same, except you need to require the
cookstyle library first:

```ruby
require "cookstyle"
require "rubocop/rake_task"
RuboCop::RakeTask.new do |task|
  task.options << "--display-cop-names"
end
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

As with vanilla RuboCop, any custom settings can still be placed in a `.rubocop.yml` file in the root of your project.
