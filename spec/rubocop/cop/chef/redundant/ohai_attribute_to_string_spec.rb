# frozen_string_literal: true

#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::RedundantCode::OhaiAttributeToString, :config do
  it "registers an offense with node['platform'].to_s" do
    expect_offense(<<~RUBY)
      node['platform'].to_s
      ^^^^^^^^^^^^^^^^^^^^^ This Ohai node attribute is already a string and doesn't need to be converted
    RUBY

    expect_correction(<<~RUBY)
      node['platform']
    RUBY
  end

  it "registers an offense with node['platform_family'].to_s" do
    expect_offense(<<~RUBY)
      node['platform_family'].to_s
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ This Ohai node attribute is already a string and doesn't need to be converted
    RUBY

    expect_correction(<<~RUBY)
      node['platform_family']
    RUBY
  end

  it "registers an offense with node['platform_version'].to_s" do
    expect_offense(<<~RUBY)
      node['platform_version'].to_s
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ This Ohai node attribute is already a string and doesn't need to be converted
    RUBY

    expect_correction(<<~RUBY)
      node['platform_version']
    RUBY
  end

  it "registers an offense with node['fqdn'].to_s" do
    expect_offense(<<~RUBY)
      node['fqdn'].to_s
      ^^^^^^^^^^^^^^^^^ This Ohai node attribute is already a string and doesn't need to be converted
    RUBY

    expect_correction(<<~RUBY)
      node['fqdn']
    RUBY
  end

  it "registers an offense with node['os'].to_s" do
    expect_offense(<<~RUBY)
      node['os'].to_s
      ^^^^^^^^^^^^^^^ This Ohai node attribute is already a string and doesn't need to be converted
    RUBY

    expect_correction(<<~RUBY)
      node['os']
    RUBY
  end

  it "registers an offense with node['hostname'].to_s" do
    expect_offense(<<~RUBY)
      node['hostname'].to_s
      ^^^^^^^^^^^^^^^^^^^^^ This Ohai node attribute is already a string and doesn't need to be converted
    RUBY

    expect_correction(<<~RUBY)
      node['hostname']
    RUBY
  end

  it "registers an offense with node['name'].to_s" do
    expect_offense(<<~RUBY)
      node['name'].to_s
      ^^^^^^^^^^^^^^^^^ This Ohai node attribute is already a string and doesn't need to be converted
    RUBY

    expect_correction(<<~RUBY)
      node['name']
    RUBY
  end

  it "doesn't register an offense when using a node attribute directly" do
    expect_no_offenses(<<~RUBY)
      node['platform']
    RUBY
  end

  it "doesn't register an offense when using .to_s on any old attribute" do
    expect_no_offenses(<<~RUBY)
      node['platform']['foo'].to_s
    RUBY
  end
end
