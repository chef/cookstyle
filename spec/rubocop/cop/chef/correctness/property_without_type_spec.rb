# frozen_string_literal: true
#
# Copyright:: Copyright 2020, Chef Software Inc.
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

describe RuboCop::Cop::Chef::Correctness::PropertyWithoutType, :config do
  it 'registers an offense when an property has no type' do
    expect_offense(<<~RUBY)
      property :size, regex: /^\d+[KMGTP]$/
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Resource properties or attributes should always define a type to help users understand the correct allowed values.
    RUBY
  end

  it 'registers an offense when an property has no type and no hash options' do
    expect_offense(<<~RUBY)
      property :size
      ^^^^^^^^^^^^^^ Resource properties or attributes should always define a type to help users understand the correct allowed values.
    RUBY
  end

  it 'registers an offense when an attribute has no type' do
    expect_offense(<<~RUBY)
      attribute :size, regex: /^\d+[KMGTP]$/
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Resource properties or attributes should always define a type to help users understand the correct allowed values.
    RUBY
  end

  it 'registers an offense when an attribute has no type and no hash options' do
    expect_offense(<<~RUBY)
      attribute :size
      ^^^^^^^^^^^^^^^ Resource properties or attributes should always define a type to help users understand the correct allowed values.
    RUBY
  end

  it 'does not register an offense if a property uses kind_of option' do
    expect_no_offenses('property :size, regex: /^\d+[KMGTP]$/, kind_of: String')
  end

  it 'does not register an offense if an attribute uses kind_of option' do
    expect_no_offenses('attribute :size, regex: /^\d+[KMGTP]$/, kind_of: String')
  end

  it 'does not register an offense if a property has positional type' do
    expect_no_offenses('property :size, String, regex: /^\d+[KMGTP]$/')
  end
end
