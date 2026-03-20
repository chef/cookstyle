# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

describe RuboCop::Cop::Chef::Modernize::UnnecessaryDependsChef14, :config do
  it 'registers an offense when a cookbook depends on "build-essential"' do
    expect_offense(<<~RUBY)
      depends 'build-essential'
      ^^^^^^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  it 'registers an offense when a cookbook depends on "chef_handler"' do
    expect_offense(<<~RUBY)
      depends 'chef_handler'
      ^^^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  it 'registers an offense when a cookbook depends on "chef_hostname"' do
    expect_offense(<<~RUBY)
      depends 'chef_hostname'
      ^^^^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  it 'registers an offense when a cookbook depends on "dmg"' do
    expect_offense(<<~RUBY)
      depends 'dmg'
      ^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  it 'registers an offense when a cookbook depends on "mac_os_x"' do
    expect_offense(<<~RUBY)
      depends 'mac_os_x'
      ^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  it 'registers an offense when a cookbook depends on "swap"' do
    expect_offense(<<~RUBY)
      depends 'swap'
      ^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  it 'registers an offense when a cookbook depends on "sysctl"' do
    expect_offense(<<~RUBY)
      depends 'sysctl'
      ^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  it "doesn't register an offense when depending on any old cookbook" do
    expect_no_offenses(<<~RUBY)
      depends 'build-essentially'
    RUBY
  end

  it 'registers an offense when a cookbook depends on "build-essential" and specifies a version constraint' do
    expect_offense(<<~RUBY)
      depends 'build-essential', '>= 8.0.1'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  context 'with TargetChefVersion set to 13' do
    let(:config) { target_chef_version(13) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        depends 'build-essential', '>= 8.0.1'
      RUBY
    end
  end
end
