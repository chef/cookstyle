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

describe RuboCop::Cop::Chef::ChefDeprecations::NodeSet do
  subject(:cop) { described_class.new }

  it 'registers an offense on using node.set' do
    expect_offense(<<~RUBY)
      node.set[:foo]
           ^^^ Do not use node.set. Replace with node.normal to keep identical behavior.
    RUBY

    expect_correction(<<~RUBY)
      node.normal[:foo]
    RUBY
  end

  it 'registers an offense on using chef_run.node.set' do
    expect_offense(<<~RUBY)
      chef_run.node.set[:foo]
                    ^^^ Do not use node.set. Replace with node.normal to keep identical behavior.
    RUBY

    expect_correction(<<~RUBY)
      chef_run.node.normal[:foo]
    RUBY
  end

  it 'registers no offense on using chef_run.set' do
    expect_no_offenses(<<~RUBY)
      chef_run.set[:foo]
    RUBY
  end

  it 'registers no offense on using node.default' do
    expect_no_offenses(<<~RUBY)
      node.default[:foo]
    RUBY
  end

  include_examples 'autocorrect',
    'node.set[:foo]',
    'node.normal[:foo]'

  include_examples 'autocorrect',
    'chef_run.node.set[:foo]',
    'chef_run.node.normal[:foo]'
end
