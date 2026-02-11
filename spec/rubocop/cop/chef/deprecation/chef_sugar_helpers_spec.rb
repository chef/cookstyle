# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# Author:: Tim Smith (<tsmith84@gmail.com>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

describe RuboCop::Cop::Chef::Deprecations::ChefSugarHelpers, :config do
  it 'registers an offense when using the vagrant_key? helper' do
    expect_offense(<<~RUBY)
      vagrant_key?
      ^^^^^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the opensolaris? helper' do
    expect_offense(<<~RUBY)
      opensolaris?
      ^^^^^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the nexentacore? helper' do
    expect_offense(<<~RUBY)
      nexentacore?
      ^^^^^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the opensolaris_platform? helper' do
    expect_offense(<<~RUBY)
      opensolaris_platform?
      ^^^^^^^^^^^^^^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the nexentacore_platform? helper' do
    expect_offense(<<~RUBY)
      nexentacore_platform?
      ^^^^^^^^^^^^^^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the dev_null helper' do
    expect_offense(<<~RUBY)
      dev_null
      ^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the wrlinux? helper' do
    expect_offense(<<~RUBY)
      wrlinux?
      ^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the includes_recipe? helper' do
    expect_offense(<<~RUBY)
      includes_recipe?('foo::bar')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the ruby_19? helper' do
    expect_offense(<<~RUBY)
      ruby_19?
      ^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the ruby_20? helper' do
    expect_offense(<<~RUBY)
      ruby_20?
      ^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the ios_xr? helper' do
    expect_offense(<<~RUBY)
      ios_xr?
      ^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the nexus? helper' do
    expect_offense(<<~RUBY)
      nexus?
      ^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the best_ip_for helper' do
    expect_offense(<<~RUBY)
      best_ip_for(node)
      ^^^^^^^^^^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the require_chef_gem helper' do
    expect_offense(<<~RUBY)
      require_chef_gem('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the vagrant_user? helper' do
    expect_offense(<<~RUBY)
      vagrant_user?
      ^^^^^^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end

  it 'registers an offense when using the vagrant_domain? helper' do
    expect_offense(<<~RUBY)
      vagrant_domain?
      ^^^^^^^^^^^^^^^ Do not use legacy chef-sugar helper methods, which will not be moved into Chef Infra Client itself. For a complete set of chef-sugar helpers now shipping in Chef Infra Client itself see https://github.com/chef/chef/tree/main/chef-utils#getting-started
    RUBY
  end
end
