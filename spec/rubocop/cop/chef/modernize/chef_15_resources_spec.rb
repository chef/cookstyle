# frozen_string_literal: true

#
# Copyright:: 2021, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Modernize::UnnecessaryDependsChef15, :config do
  it 'registers an offense when a cookbook depends on "libarchive"' do
    expect_offense(<<~RUBY)
      depends 'libarchive'
      ^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 15.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  it 'registers an offense when a cookbook depends on "windows_dns"' do
    expect_offense(<<~RUBY)
      depends 'windows_dns'
      ^^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 15.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  it 'registers an offense when a cookbook depends on "windows_uac"' do
    expect_offense(<<~RUBY)
      depends 'windows_uac'
      ^^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 15.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  it 'registers an offense when a cookbook depends on "windows_dfs"' do
    expect_offense(<<~RUBY)
      depends 'windows_dfs'
      ^^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 15.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  it "doesn't register an offense when depending on any old cookbook" do
    expect_no_offenses(<<~RUBY)
      depends 'build-essentially'
    RUBY
  end

  it 'registers an offense when a cookbook depends on "windows_dfs" and specifies a version constraint' do
    expect_offense(<<~RUBY)
      depends 'windows_dfs', '>= 8.0.1'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 15.0+. These community cookbooks contain resources that are now included in Chef Infra Client itself.
    RUBY
  end

  context 'with TargetChefVersion set to 14' do
    let(:config) { target_chef_version(14) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        depends 'windows_dfs', '>= 8.0.1'
      RUBY
    end
  end
end
