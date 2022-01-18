# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
# Author:: Tim Smith (<tsmith@chef.io>)
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

describe RuboCop::Cop::Chef::Deprecations::NamePropertyWithDefaultValue, :config do
  it 'registers an offense when a resource property is both a name_property and has a default' do
    expect_offense(<<~RUBY)
      property :foo, String, name_property: true, default: 'foo'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A resource property can't be marked as a name_property and also have a default value. This will fail in Chef Infra Client 13 or later.
    RUBY

    expect_correction(<<~RUBY)
      property :foo, String, name_property: true
    RUBY
  end

  it 'registers an offense when a resource attribute is both a name_attribute and has a default' do
    expect_offense(<<~RUBY)
      attribute :foo, String, name_attribute: true, default: 'foo'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A resource property can't be marked as a name_property and also have a default value. This will fail in Chef Infra Client 13 or later.
    RUBY

    expect_correction(<<~RUBY)
      attribute :foo, String, name_attribute: true
    RUBY
  end

  it "doesn't register an offense with non-name_property property with a default" do
    expect_no_offenses(<<~RUBY)
      property :foo, String, default: 'foo'
    RUBY
  end

  it "doesn't register an offense with name_property that does not have a default" do
    expect_no_offenses(<<~RUBY)
      property :foo, String, name_property: true
    RUBY
  end
end
