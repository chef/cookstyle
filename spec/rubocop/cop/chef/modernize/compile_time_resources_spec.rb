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

describe RuboCop::Cop::Chef::Modernize::ResourceForcingCompileTime, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when build_essential resources set an action on the block' do
    expect_offense(<<~RUBY)
      build_essential 'install build tools' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Set 'compile_time true' in resources when available instead of forcing resources to run at compile time by setting an action on the block.
        action :nothing
      end.run_action(:install)
    RUBY
  end

  it 'registers an offense when hostname resources set an action on the block' do
    expect_offense(<<~RUBY)
      hostname 'tim.example.com' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Set 'compile_time true' in resources when available instead of forcing resources to run at compile time by setting an action on the block.
        action :nothing
      end.run_action(:set)
    RUBY
  end

  it 'registers an offense when chef_gem resources set an action on the block' do
    expect_offense(<<~RUBY)
      chef_gem 'community_cookbook_releaser' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Set 'compile_time true' in resources when available instead of forcing resources to run at compile time by setting an action on the block.
        action :nothing
      end.run_action(:install)
    RUBY
  end

  it 'registers an offense when ohai_hint resources set an action on the block' do
    expect_offense(<<~RUBY)
      ohai_hint 'pdx_datacenter' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Set 'compile_time true' in resources when available instead of forcing resources to run at compile time by setting an action on the block.
        content 'true'
        action :nothing
      end.run_action(:install)
    RUBY
  end

  it 'does not register an offense when a resource sets compile_time true' do
    expect_no_offenses(<<~RUBY)
      chef_gem 'community_cookbook_releaser' do
        compile_time true
      end
    RUBY
  end
end
