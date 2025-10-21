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

describe RuboCop::Cop::Chef::Modernize::ActionMethodInResource, :config do
  it 'registers an offense when defining an action using a method' do
    expect_offense(<<~RUBY)
      def action_run
      ^^^^^^^^^^^^^^ Use the custom resource language's `action :my_action` blocks instead of creating actions with methods.
        some_ruby_method
      end
    RUBY

    expect_correction(<<~RUBY)
      action :run do
        some_ruby_method
      end
    RUBY
  end

  it 'does not register an offense if the action method takes arguments' do
    expect_no_offenses(<<~RUBY)
      def action_run(nope)
        some_ruby_method
      end
    RUBY
  end

  it 'does not register an offense if the action method is in a poise resource' do
    expect_no_offenses(<<~RUBY)
      include Poise

      def action_run
        some_ruby_method
      end
    RUBY
  end
end
