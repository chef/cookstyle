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

describe RuboCop::Cop::Chef::RedundantCode::RecipeMetadata, :config do
  it 'registers an offense when metadata uses "recipe"' do
    expect_offense(<<~RUBY)
      name 'foo'
      recipe 'chef-client::config', 'Configures the client.rb from a template.'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The recipe metadata.rb method is not used and is unnecessary in cookbooks. Recipes should be documented in the cookbook's README.md file instead.
      depends 'bar'
    RUBY

    expect_correction(<<~RUBY)
      name 'foo'
      depends 'bar'
    RUBY
  end

  it 'properly autocorrects metadata using "recipe" with a heredoc' do
    expect_offense(<<~RUBY)
      name 'foo'
      recipe 'foo::bar', <<-EOH
      ^^^^^^^^^^^^^^^^^^^^^^^^^ The recipe metadata.rb method is not used and is unnecessary in cookbooks. Recipes should be documented in the cookbook's README.md file instead.
      Stuff!!
      More Stuff!!
      Even More Stuff!!
      EOH
      depends 'bar'
    RUBY

    expect_correction(<<~RUBY)
      name 'foo'
      depends 'bar'
    RUBY
  end

  it "doesn't register an offense on normal metadata" do
    expect_no_offenses(<<~RUBY)
      depends 'foo'
    RUBY
  end
end
