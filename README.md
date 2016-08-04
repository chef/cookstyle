# Cookstyle - Version Pinned rubocop and sane defaults for Chef Cookbooks

[![Gem Version](https://badge.fury.io/rb/cookstyle.svg)](https://badge.fury.io/rb/cookstyle) [![Build Status](https://travis-ci.org/chef/cookstyle.svg?branch=master)](https://travis-ci.org/chef/cookstyle)

Pull Requests will not be accepted that assume unfunded mandates for other people to finish the work cleaning up various Chef owned cookbooks. Do not open PRs offering opinions or suggestions without offering to do the work.

The project itself is a derivative of [finstyle](https://github.com/fnichol/finstyle), but starts with all rules disabled. The active ruleset is in the [config/cookstyle.yml](https://github.com/chef/cookstyle/blob/master/config/cookstyle.yml) file.

## How It Works

This library has a direct dependency on one specific version of RuboCop (at a time), and [patches it][patch] to load the [upstream configuration][upstream] and [custom set][config] of rule updates. When a new RuboCop release comes out, this library can rev its pinned version dependency and [re-vendor][rakefile] the upstream configuration to determine if any breaking style or lint rules were added/dropped/reversed/etc.

## NOTE CAREFULLY ABOUT UPDATING COOKSTYLE

This is designed to allow bumping the rubocop engine while keeping backwards compatibility with the config and not requiring all the cookbooks to update.

The [cookstyle_base.yml](https://github.com/chef/cookstyle/blob/master/config/cookstyle_base.yml) file is (essentially) the enabled.yml file from 0.37.2 (as of this writing) which is applied on top of 0.42.0 with all the rules disabled. It pins the default enabled set to 0.37.2 compatibility while running under the 0.42.0 engine.

There is no rake task for updating the `cookstyle_base.yml` file. It was generated by hand -- the Description and other fields need to be dropped out of it.

It may be necessary to edit that file (again by hand) to resolve issues with later rubocop engines changing cop names (renaming, splitting up, etc).

Occasionally the `cookstyle_base.yml` file should be updated, which will generate a lot of work to fix every cookbook that cookstyle runs against.

When updating to a new engine the `rake vendor` task should still always be run in order to update the base set of cops and generate the default disabled.yml ruleset.

When editing the `cookstyle_base.yml` becomes too much of a PITA, it may be time to bump the engine, run `rake vendor` and then drop the new `enabled.yml` into `cookstyle_base.yml`, fix it up, and ship it and then deal with the fallout of all the new cops...

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cookstyle'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install cookstyle
```

## Usage

### Vanilla RuboCop

Run RuboCop as normal, simply add a `-r cookstyle` option when running:

```sh
rubocop -r cookstyle -D --format offenses
```

### cookstyle Command

Use this tool just as you would RuboCop, but invoke the `cookstyle` binary instead which patches RuboCop to load rules from the cookstyle gem. For example:

```sh
cookstyle -D --format offenses
```

### Rake

In a Rakefile, the setup is exactly the same, except you need to require the cookstyle library first:

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
