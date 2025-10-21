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

describe RuboCop::Cop::Chef::Modernize::ClassEvalActionClass, :config do
  it 'registers an offense when running class_eval on an action_class block' do
    expect_offense(<<~RUBY)
      action_class.class_eval do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ In Chef Infra Client 12.9 and later it is no longer necessary to call the class_eval method on the action class block.
        some_ruby_method
      end
    RUBY

    expect_correction(<<~RUBY)
      action_class do
        some_ruby_method
      end
    RUBY
  end

  it 'does not register an offense when just using action_class' do
    expect_no_offenses(<<~RUBY)
      action_class do
        some_ruby_method
      end
    RUBY
  end
end
