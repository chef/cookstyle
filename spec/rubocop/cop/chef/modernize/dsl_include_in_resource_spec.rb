# frozen_string_literal: true

#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Modernize::DslIncludeInResource, :config do
  it 'registers an error when including "Chef::DSL::Recipe"' do
    expect_offense(<<~RUBY)
      include Chef::DSL::Recipe
      ^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 12.4+ includes the Chef::DSL::Recipe in the resource and provider classed by default so there is no need to include this DSL in your resources or providers.
    RUBY

    expect_correction("\n")
  end

  it 'registers an error when including "Chef::DSL::IncludeRecipe"' do
    expect_offense(<<~RUBY)
      include Chef::DSL::IncludeRecipe
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 12.4+ includes the Chef::DSL::Recipe in the resource and provider classed by default so there is no need to include this DSL in your resources or providers.
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when including Chef::DSL::Foo" do
    expect_no_offenses('include Chef::DSL::Foo')
  end
end
