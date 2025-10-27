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

describe RuboCop::Cop::Chef::Deprecations::FoodcriticTesting, :config do
  it 'registers an offense when a foodcritic is required in code' do
    expect_offense(<<~RUBY)
      require 'foodcritic'
      ^^^^^^^^^^^^^^^^^^^^ The Foodcritic cookbook linter has been deprecated and should no longer be used for validating cookbooks.
    RUBY
  end

  it 'registers an offense when the foodcritic gem is required' do
    expect_offense(<<~RUBY)
      gem 'foodcritic'
      ^^^^^^^^^^^^^^^^ The Foodcritic cookbook linter has been deprecated and should no longer be used for validating cookbooks.
    RUBY
  end

  it "doesn't register an offense when requiring other code" do
    expect_no_offenses(<<~RUBY)
      require 'cookstyle'
    RUBY
  end

  it "doesn't register an offense when requiring another gem" do
    expect_no_offenses(<<~RUBY)
      gem 'cookstyle'
    RUBY
  end
end
