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

describe RuboCop::Cop::Chef::Sharing::EmptyPropertyDescription, :config do
  it 'registers an offense when a property has an empty description' do
    expect_offense(<<~RUBY)
      property :site_name, String,
               name_property: true,
               description: ''
               ^^^^^^^^^^^^^^^ Resource properties should not set an empty `description`. Either describe the property or leave the field off entirely.
    RUBY
  end

  it 'registers an offense when a property has an empty double quoted description' do
    expect_offense(<<~RUBY)
      property :site_name, String, description: ""
                                   ^^^^^^^^^^^^^^^ Resource properties should not set an empty `description`. Either describe the property or leave the field off entirely.
    RUBY
  end

  it 'registers an offense when a property has a whitespace only description' do
    expect_offense(<<~RUBY)
      property :site_name, String, description: '   '
                                   ^^^^^^^^^^^^^^^^^^ Resource properties should not set an empty `description`. Either describe the property or leave the field off entirely.
    RUBY
  end

  it "doesn't register an offense when a property has a description" do
    expect_no_offenses(<<~RUBY)
      property :site_name, String, description: 'The name of the site'
    RUBY
  end

  it "doesn't register an offense when a property has no description" do
    expect_no_offenses(<<~RUBY)
      property :site_name, String, name_property: true
    RUBY
  end

  it "doesn't register an offense when the description is built from a variable" do
    expect_no_offenses(<<~'RUBY')
      property :site_name, String, description: "The name of #{thing}"
    RUBY
  end

  it "doesn't register an offense on an empty value for another property field" do
    expect_no_offenses(<<~RUBY)
      property :site_name, String, default: ''
    RUBY
  end

  it "doesn't register an offense on an empty description outside a property" do
    expect_no_offenses(<<~RUBY)
      thing :site_name, description: ''
    RUBY
  end

  it "doesn't register an offense on an empty description nested in another option's value" do
    expect_no_offenses(<<~RUBY)
      property :site_name, Hash, default: { description: '' }
    RUBY
  end

  it "doesn't register an offense on an empty description nested several levels deep" do
    expect_no_offenses(<<~RUBY)
      property :site_name, Hash, default: { nested: { description: '' } }
    RUBY
  end

  it 'registers an offense only for the property description when a nested one is also empty' do
    expect_offense(<<~RUBY)
      property :site_name, Hash, description: '', default: { description: '' }
                                 ^^^^^^^^^^^^^^^ Resource properties should not set an empty `description`. Either describe the property or leave the field off entirely.
    RUBY
  end
end
