# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Effortless::ChefVaultUsed, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when requiring chef-vault' do
    expect_offense(<<~RUBY)
      require 'chef-vault'
      ^^^^^^^^^^^^^^^^^^^^ Chef Vault usage is not supported in the Effortless pattern
    RUBY
  end

  it 'registers an offense when requiring chef-vault' do
    expect_offense(<<~RUBY)
      include_recipe 'chef-vault'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Vault usage is not supported in the Effortless pattern
    RUBY
  end

  it 'registers an offense when chef-vault is installed in a cookbook' do
    expect_offense(<<~RUBY)
      chef_gem 'chef-vault'
      ^^^^^^^^^^^^^^^^^^^^^ Chef Vault usage is not supported in the Effortless pattern
    RUBY
  end

  it 'registers an offense when ChefVault::Item constant is used' do
    expect_offense(<<~RUBY)
      ChefVault::Item.load
      ^^^^^^^^^^^^^^^ Chef Vault usage is not supported in the Effortless pattern
    RUBY
  end

  it 'registers an offense when #chef_vault_item is used' do
    expect_offense(<<~RUBY)
      chef_vault_item("secrets", "dbpassword")
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Vault usage is not supported in the Effortless pattern
    RUBY
  end

  it 'registers an offense when #chef_vault_item is used' do
    expect_offense(<<~RUBY)
      chef_vault_item_for_environment('secrets', 'passwords')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Vault usage is not supported in the Effortless pattern
    RUBY
  end
end
