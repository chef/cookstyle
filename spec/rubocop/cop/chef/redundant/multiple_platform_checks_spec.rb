# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::RedundantCode::MultiplePlatformChecks, :config do
  it 'registers an offense when using multiple platform? checks with an ||' do
    expect_offense(<<~RUBY)
      platform?('foo') || platform?('bar')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ You can pass multiple values to the platform? and platform_family? helpers instead of calling the helpers multiple times.
    RUBY

    expect_correction(<<~RUBY)
      platform?('foo', 'bar')
    RUBY
  end

  it 'registers an offense when using multiple platform_family? checks with an ||' do
    expect_offense(<<~RUBY)
      platform_family?('foo') || platform_family?('bar')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ You can pass multiple values to the platform? and platform_family? helpers instead of calling the helpers multiple times.
    RUBY

    expect_correction(<<~RUBY)
      platform_family?('foo', 'bar')
    RUBY
  end

  it 'properly autocorrects when helpers use variables as well' do
    expect_offense(<<~RUBY)
      platform_family?(foo) || platform_family?('bar')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ You can pass multiple values to the platform? and platform_family? helpers instead of calling the helpers multiple times.
    RUBY

    expect_correction(<<~RUBY)
      platform_family?(foo, 'bar')
    RUBY
  end

  it "doesn't register an offense when the platform checks don't match" do
    expect_no_offenses(<<~RUBY)
      platform_family?(foo) || platform?('bar')
    RUBY
  end
end
