# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

describe RuboCop::Cop::Chef::Deprecations::ChefHandlerRecipe, :config do
  it 'registers an offense when using include_recipe "chef_handler::default"' do
    expect_offense(<<~RUBY)
      include_recipe "chef_handler::default"
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to include the empty and deprecated chef_handler::default recipe to use the chef_handler resource
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when using include_recipe "chef_handler"' do
    expect_offense(<<~RUBY)
      include_recipe "chef_handler"
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to include the empty and deprecated chef_handler::default recipe to use the chef_handler resource
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when including a different recipe" do
    expect_no_offenses("include_recipe 'yum'")
  end
end
