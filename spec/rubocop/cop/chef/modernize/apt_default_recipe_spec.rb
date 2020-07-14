# frozen_string_literal: true
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

describe RuboCop::Cop::Chef::ChefModernize::IncludingAptDefaultRecipe, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when including the "apt" recipe' do
    expect_offense(<<~RUBY)
      include_recipe 'apt'
      ^^^^^^^^^^^^^^^^^^^^ Do not include the Apt default recipe to update package cache. Instead use the apt_update resource, which is built into Chef Infra Client 12.7 and later.
    RUBY
  end

  it 'registers an offense when including the "apt::default" recipe' do
    expect_offense(<<~RUBY)
      include_recipe 'apt::default'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not include the Apt default recipe to update package cache. Instead use the apt_update resource, which is built into Chef Infra Client 12.7 and later.
    RUBY
  end

  it "doesn't register an offense when including any other recipe" do
    expect_no_offenses(<<~RUBY)
      include_recipe 'foo'
    RUBY
  end

  context 'with TargetChefVersion set to 12' do
    let(:config) { target_chef_version(12) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
      include_recipe 'apt::default'
      RUBY
    end
  end
end
