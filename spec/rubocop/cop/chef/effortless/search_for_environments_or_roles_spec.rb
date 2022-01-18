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

describe RuboCop::Cop::Chef::Effortless::SearchForEnvironmentsOrRoles, :config do
  it 'registers an offense when search query contains chef_environment' do
    expect_offense(<<~RUBY)
      search(:node, "chef_environment:bar")
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Cookbook uses search with a node query that looks for a role or environment
    RUBY
  end

  it 'registers an offense when search query contains role' do
    expect_offense(<<~RUBY)
      search(:node, "role:bar")
      ^^^^^^^^^^^^^^^^^^^^^^^^^ Cookbook uses search with a node query that looks for a role or environment
    RUBY
  end

  it "doesn't register an offense with a standard search" do
    expect_no_offenses(<<~RUBY)
      search(:node, "foo:bar")
    RUBY
  end
end
