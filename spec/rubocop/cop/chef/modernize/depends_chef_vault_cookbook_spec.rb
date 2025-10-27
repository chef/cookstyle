# frozen_string_literal: true

#
# Copyright:: 2021, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Modernize::DependsOnChefVaultCookbook, :config do
  it 'registers an offense when depending on the chef-vault cookbook' do
    expect_offense(<<~RUBY)
      depends 'chef-vault'
      ^^^^^^^^^^^^^^^^^^^^ Don't depend on the chef-vault cookbook made obsolete by Chef Infra Client 16.0. The chef-vault gem and helpers are now included in Chef Infra Client itself.
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when depending on other cookbooks" do
    expect_no_offenses(<<~RUBY)
      depends 'foo'
    RUBY
  end

  context 'with TargetChefVersion set to 15.x' do
    let(:config) { target_chef_version(15.99) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        depends 'chef-vault'
      RUBY
    end
  end
end
