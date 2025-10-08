# frozen_string_literal: true

#
# Copyright:: Copyright 2019, Chef Software Inc.
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

describe RuboCop::Cop::Chef::Correctness::NodeNormalUnless, :config do
  it 'registers an offense on using node.normal_unless' do
    expect_offense(<<~RUBY)
      node.normal_unless[:foo]
      ^^^^^^^^^^^^^^^^^^ Do not use node.normal_unless. Replace with default/override/force_default/force_override attribute levels.
    RUBY

    expect_no_corrections
  end

  it 'registers an offense on using chef_run.node.normal_unless' do
    expect_offense(<<~RUBY)
      chef_run.node.normal_unless[:foo]
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use node.normal_unless. Replace with default/override/force_default/force_override attribute levels.
    RUBY

    expect_no_corrections
  end

  it 'registers no offense on using chef_run.normal_unless' do
    expect_no_offenses(<<~RUBY)
      chef_run.normal_unless[:foo]
    RUBY
  end

  it 'registers no offense on using node.default_unless' do
    expect_no_offenses(<<~RUBY)
      node.default_unless[:foo]
    RUBY
  end
end
