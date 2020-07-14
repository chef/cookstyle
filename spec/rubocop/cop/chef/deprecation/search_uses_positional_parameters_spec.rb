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

describe RuboCop::Cop::Chef::ChefDeprecations::SearchUsesPositionalParameters, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when search has 3+ args and uses positional params' do
    expect_offense(<<~RUBY)
      search(:node, '*:*', 0)
      ^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated positional parameters in cookbook search queries.
    RUBY

    expect_correction("search(:node, '*:*', start: 0)\n")
  end

  it 'corrects Integer like String positional parameters to be Integers' do
    expect_offense(<<~RUBY)
      search(:node, '*:*', "0")
      ^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated positional parameters in cookbook search queries.
    RUBY

    expect_correction("search(:node, '*:*', start: 0)\n")
  end

  it 'Removes the legacy sort parameter from search queries' do
    expect_offense(<<~RUBY)
      search(:node, "*:*", 'X_CHEF_id_CHEF_X asc', 1)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated positional parameters in cookbook search queries.
    RUBY

    expect_correction("search(:node, \"*:*\", start: 1)\n")
  end

  it "Removes the legacy sort parameter from search queries if it's a nil value" do
    expect_offense(<<~RUBY)
    search(:node, "*:*", nil, 0)
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated positional parameters in cookbook search queries.
    RUBY

    expect_correction("search(:node, \"*:*\", start: 0)\n")
  end

  it "doesn't register an offense with the search method in another class" do
    expect_no_offenses(<<~RUBY)
      Foo.search(:node, '*:*', 0)
    RUBY
  end

  it "doesn't register an offense with a 3+ arg search that has named params" do
    expect_no_offenses(<<~RUBY)
      search(:node, '*:*', start: 0)
    RUBY
  end

  it "doesn't register an offense with a 2 arg search" do
    expect_no_offenses(<<~RUBY)
      search(:node, '*:*')
    RUBY
  end
end
