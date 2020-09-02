# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefRedundantCode::CustomResourceWithAllowedActions, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense with a resource that uses allowed_actions method' do
    expect_offense(<<~RUBY)
      allowed_actions [:create, :remove]
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ It is not necessary to set `actions` or `allowed_actions` in custom resources as Chef Infra Client determines these automatically from the set of all actions defined in the resource

      action :foo do
        # action stuff
      end
    RUBY

    expect_correction(<<~RUBY)


      action :foo do
        # action stuff
      end
    RUBY
  end

  it 'registers an offense with a resource that uses actions method' do
    expect_offense(<<~RUBY)
      actions [:create, :remove]
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ It is not necessary to set `actions` or `allowed_actions` in custom resources as Chef Infra Client determines these automatically from the set of all actions defined in the resource

      action :foo do
        # action stuff
      end
    RUBY

    expect_correction(<<~RUBY)


      action :foo do
        # action stuff
      end
    RUBY
  end

  it 'does not register an offense when in a LWRP resource' do
    expect_no_offenses(<<~RUBY)
      actions [:create, :remove]
      allowed_actions [:create, :remove]
    RUBY
  end

  it 'does not register an offense when in a Poise resource' do
    expect_no_offenses(<<~RUBY)
      require 'poise'

      actions [:create, :remove]
      allowed_actions [:create, :remove]

      action :foo do
        # action stuff
      end
    RUBY
  end

  it 'does not register an offense when calling actions method on another object' do
    expect_no_offenses(<<~RUBY)
      action :create do
        template ::File.join(apache_dir, 'mods-available', 'actions.conf') do
          source 'mods/actions.conf.erb'
          cookbook 'apache2'
          variables(actions: new_resource.actions)
        end
      end
    RUBY
  end
end
