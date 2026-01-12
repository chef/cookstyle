# frozen_string_literal: true
#
# Copyright:: 2016, Chris Henry
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

describe RuboCop::Cop::Chef::RedundantCode::UnnecessaryNameProperty, :config do
  it 'registers an offense when a resource has a property called name' do
    expect_offense(<<~RUBY)
      property :name, String
      ^^^^^^^^^^^^^^^^^^^^^^ There is no need to define a property or attribute named :name in a resource as Chef Infra defines this on all resources by default.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when a resource has an attribute called name' do
    expect_offense(<<~RUBY)
      attribute :name, kind_of: String
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to define a property or attribute named :name in a resource as Chef Infra defines this on all resources by default.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when a resource has a property called name that is a name_property' do
    expect_offense(<<~RUBY)
      property :name, String, name_property: true
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to define a property or attribute named :name in a resource as Chef Infra defines this on all resources by default.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when a resource has a attribute called name that is a name_attribute' do
    expect_offense(<<~RUBY)
      attribute :name, kind_of: String, name_attribute: true
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to define a property or attribute named :name in a resource as Chef Infra defines this on all resources by default.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when a resource has a attribute called name that is a name_attribute in non-standard order' do
    expect_offense(<<~RUBY)
      attribute :name, name_attribute: true, kind_of: String
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to define a property or attribute named :name in a resource as Chef Infra defines this on all resources by default.
    RUBY

    expect_correction("\n")
  end

  it 'does not register an offense when when a resource defined the name property with a default value' do
    expect_no_offenses(<<~RUBY)
      property :name, String, default: ''
    RUBY
  end
end
