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

describe RuboCop::Cop::Chef::ChefModernize::AllowedActionsFromInitialize, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense with a resource that sets the @allowed_actions variable in an initializer' do
    expect_offense(<<~RUBY)
      def initialize(*args)
        super
        @allowed_actions = [:create, :remove]
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The allowed actions of a resource can be set with the "allowed_actions" helper instead of using the initialize method.
      end
    RUBY

    expect_correction(<<~RUBY)
      allowed_actions [:create, :remove]

      def initialize(*args)
        super
      end
    RUBY
  end

  it 'registers an offense with a resource that sets the @actions variable in an initializer' do
    expect_offense(<<~RUBY)
      def initialize(*args)
        super
        @actions = [:create, :remove]
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The allowed actions of a resource can be set with the "allowed_actions" helper instead of using the initialize method.
      end
    RUBY

    expect_correction(<<~RUBY)
      allowed_actions [:create, :remove]

      def initialize(*args)
        super
      end
    RUBY
  end

  it 'does not register an offense with a poise resource' do
    expect_no_offenses(<<~RUBY)
      require 'poise'

      module MyCookbook
        module Resource
          class MyResource < Chef::Resource
            include Poise(inversion: true)
            provides(:consul_installation)
            actions(:create, :remove)
          end
        end
      end
    RUBY
  end

  it 'does not register an offense when adding actions to the parent class' do
    expect_no_offenses(<<~RUBY)
      def initialize(name, run_context=nil)
        super(name, run_context)
        @action = :install
        @allowed_actions += [:install]
        @resource_name = :chef_bundle
        @compile_time = Chef::Config[:chef_gem_compile_time]
        @gemfile = nil
        @options = []
      end
    RUBY
  end

  it 'does not register an offense with a resource that does not have an initialize method' do
    expect_no_offenses(<<~RUBY)
      property :something, String

      action :create do
        # some action code
      end
    RUBY
  end

  it 'does not register an offense with when an initializer is empty' do
    expect_no_offenses(<<~RUBY)
      def initialize(*args)
      end
    RUBY
  end

  it 'does not register an offense with when an initializer containing other variables' do
    expect_no_offenses(<<~RUBY)
      def initialize(*args)
        super
        @action = :create
      end
    RUBY
  end
end
