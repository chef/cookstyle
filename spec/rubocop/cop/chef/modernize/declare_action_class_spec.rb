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

describe RuboCop::Cop::Chef::Modernize::DeclareActionClass, :config do
  it 'registers an offense when using declare_action_class' do
    expect_offense(<<~RUBY)
      declare_action_class do
      ^^^^^^^^^^^^^^^^^^^^ In Chef Infra Client 12.9 and later `action_class` can be used instead of `declare_action_class`.
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
