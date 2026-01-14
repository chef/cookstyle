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

describe RuboCop::Cop::Chef::Sharing::IncludePropertyDescriptions, :config do
  it 'registers an offense when a property does not include a description' do
    expect_offense(<<~RUBY)
      property :different_prop, String, description: 'this one has a description'
      property :foo, String, name_property: true
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Resource properties should include description fields to allow automated documentation. Requires Chef Infra Client 13.9 or later.
    RUBY
  end

  it 'registers an offense when a property does not include a description or any other hash items' do
    expect_offense(<<~RUBY)
      property :foo, String
      ^^^^^^^^^^^^^^^^^^^^^ Resource properties should include description fields to allow automated documentation. Requires Chef Infra Client 13.9 or later.
    RUBY
  end

  it "doesn't register an offense when a property contains a description" do
    expect_no_offenses(<<~RUBY)
      property :foo, String, description: 'foo'
    RUBY
  end

  it "doesn't register an offense when an attribute doesn't contain a description" do
    expect_no_offenses(<<~RUBY)
      attribute :foo, String
    RUBY
  end
end
