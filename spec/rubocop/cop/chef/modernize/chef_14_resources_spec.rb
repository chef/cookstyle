#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefModernize::UnnecessaryDependsChef14, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a cookbook depends on "build-essential"' do
    expect_offense(<<~RUBY)
      depends 'build-essential'
      ^^^^^^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14+
    RUBY
  end

  it 'registers an offense when a cookbook depends on "chef_handler"' do
    expect_offense(<<~RUBY)
      depends 'chef_handler'
      ^^^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14+
    RUBY
  end

  it 'registers an offense when a cookbook depends on "chef_hostname"' do
    expect_offense(<<~RUBY)
      depends 'chef_hostname'
      ^^^^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14+
    RUBY
  end

  it 'registers an offense when a cookbook depends on "dmg"' do
    expect_offense(<<~RUBY)
      depends 'dmg'
      ^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14+
    RUBY
  end

  it 'registers an offense when a cookbook depends on "mac_os_x"' do
    expect_offense(<<~RUBY)
      depends 'mac_os_x'
      ^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14+
    RUBY
  end

  it 'registers an offense when a cookbook depends on "swap"' do
    expect_offense(<<~RUBY)
      depends 'swap'
      ^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14+
    RUBY
  end

  it 'registers an offense when a cookbook depends on "sysctl"' do
    expect_offense(<<~RUBY)
      depends 'sysctl'
      ^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14+
    RUBY
  end

  it "doesn't register an offense when depending on any old cookbook" do
    expect_no_offenses(<<~RUBY)
      depends 'build-essentially'
    RUBY
  end

  it 'registers an offense when a cookbook depends on "build-essential" and specifies a version constraint' do
    expect_offense(<<~RUBY)
      depends 'build-essential', '>= 8.0.1'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't depend on cookbooks made obsolete by Chef Infra Client 14+
    RUBY
  end
end
