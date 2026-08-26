# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# Author:: Tim Smith (<tsmith84@proton.me>)
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

describe RuboCop::Cop::Chef::Correctness::PlatformVersionStringComparison, :config do
  it 'registers an offense when platform_version is compared with >=' do
    expect_offense(<<~RUBY)
      node['platform_version'] >= '10'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Ohai version attributes are strings, so comparing them with an ordering operator compares them character by character. Use .to_i for a major version comparison, or Gem::Version to compare full versions.
    RUBY
  end

  it 'registers an offense when platform_version is compared with <' do
    expect_offense(<<~RUBY)
      node['platform_version'] < '7.4'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Ohai version attributes are strings, so comparing them with an ordering operator compares them character by character. Use .to_i for a major version comparison, or Gem::Version to compare full versions.
    RUBY
  end

  it 'registers an offense inside a conditional' do
    expect_offense(<<~RUBY)
      if node['platform_version'] > '8'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Ohai version attributes are strings, so comparing them with an ordering operator compares them character by character. Use .to_i for a major version comparison, or Gem::Version to compare full versions.
        package 'foo'
      end
    RUBY
  end

  it 'registers an offense on os_version' do
    expect_offense(<<~RUBY)
      node['os_version'] <= '3.10'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Ohai version attributes are strings, so comparing them with an ordering operator compares them character by character. Use .to_i for a major version comparison, or Gem::Version to compare full versions.
    RUBY
  end

  it "doesn't register an offense when the major version is converted first" do
    expect_no_offenses(<<~RUBY)
      node['platform_version'].to_i >= 10
    RUBY
  end

  it "doesn't register an offense when Gem::Version is used" do
    expect_no_offenses(<<~RUBY)
      Gem::Version.new(node['platform_version']) >= Gem::Version.new('7.4')
    RUBY
  end

  it "doesn't register an offense for an equality comparison" do
    expect_no_offenses(<<~RUBY)
      node['platform_version'] == '10'
    RUBY
  end

  it "doesn't register an offense on an unrelated node attribute" do
    expect_no_offenses(<<~RUBY)
      node['foo']['count'] >= '10'
    RUBY
  end
end
