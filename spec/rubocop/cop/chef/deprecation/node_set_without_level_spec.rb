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

describe RuboCop::Cop::Chef::Deprecations::NodeSetWithoutLevel, :config do
  it 'registers an offense when setting a node attribute without precedence' do
    expect_offense(<<~RUBY)
      node['foo'] = 'bar'
      ^^^^ When setting a node attribute in Chef Infra Client 11 and later you must specify the precedence level.
    RUBY
  end

  it 'registers an offense when setting a deep node attribute without precedence' do
    expect_offense(<<~RUBY)
      node['foo']['bar'] = 5
      ^^^^ When setting a node attribute in Chef Infra Client 11 and later you must specify the precedence level.
    RUBY
  end

  %w[+= -= <<].each do |op|
    it "registers an offense when appending a node attribute without precedence using #{op}" do
      expect_offense(<<~RUBY)
        node['foo'] #{op} 1
        ^^^^ When setting a node attribute in Chef Infra Client 11 and later you must specify the precedence level.
      RUBY
    end
  end

  it "doesn't register an offense when setting a node attribute with a precedence level" do
    expect_no_offenses(<<~RUBY)
      node.default['foo'] = 'bar'
    RUBY
  end

  it "doesn't register an offense when setting an attribute" do
    expect_no_offenses(<<~RUBY)
      default['foo'] = 'bar'
    RUBY
  end
end
