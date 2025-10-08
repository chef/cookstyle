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

describe RuboCop::Cop::Chef::Effortless::CookbookUsesEnvironments, :config do
  it 'registers an offense when node.environment is used' do
    expect_offense(<<~RUBY)
      node.environment == 'production'
      ^^^^^^^^^^^^^^^^ Cookbook uses environments, which cannot be used in Policyfiles or Effortless Infra
    RUBY
  end

  it 'registers an offense when node.chef_environment is used' do
    expect_offense(<<~RUBY)
      node.chef_environment == 'production'
      ^^^^^^^^^^^^^^^^^^^^^ Cookbook uses environments, which cannot be used in Policyfiles or Effortless Infra
    RUBY
  end

  it "doesn't register an offense when a cookbook uses another node method" do
    expect_no_offenses(<<~RUBY)
      node.save
    RUBY
  end
end
