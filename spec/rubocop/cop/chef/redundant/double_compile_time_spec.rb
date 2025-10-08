# frozen_string_literal: true

#
# Copyright:: Copyright 2020, Chef Software Inc.
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

describe RuboCop::Cop::Chef::RedundantCode::DoubleCompileTime, :config do
  it 'registers an offense when a resource uses compile_time and run_action' do
    expect_offense(<<~RUBY)
      chef_gem 'deep_merge' do
        action :nothing
        compile_time true
      end.run_action(:install)
          ^^^^^^^^^^ If a resource includes the `compile_time` property there's no need to also use `.run_action(:some_action)` on the resource block.
    RUBY

    expect_correction(<<~RUBY)
      chef_gem 'deep_merge' do
        action :install
        compile_time true
      end
    RUBY
  end

  it 'does not register an offense if compile_time property is not present' do
    expect_no_offenses(<<~RUBY)
      chef_gem 'deep_merge' do
        compile_time true
      end.run_action(:install)
    RUBY
  end
end
