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

describe RuboCop::Cop::Chef::ChefDeprecations::UsesDeprecatedMixins, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when including Chef::Mixin::LanguageIncludeAttribute' do
    expect_offense(<<~RUBY)
      include Chef::Mixin::LanguageIncludeAttribute
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated Mixins no longer included in Chef Infra Client 14 and later.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when including Chef::Mixin::RecipeDefinitionDSLCore' do
    expect_offense(<<~RUBY)
      include Chef::Mixin::RecipeDefinitionDSLCore
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated Mixins no longer included in Chef Infra Client 14 and later.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when including Chef::Mixin::LanguageIncludeRecipe' do
    expect_offense(<<~RUBY)
      include Chef::Mixin::LanguageIncludeRecipe
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated Mixins no longer included in Chef Infra Client 14 and later.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when including Chef::Mixin::Language' do
    expect_offense(<<~RUBY)
      include Chef::Mixin::Language
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated Mixins no longer included in Chef Infra Client 14 and later.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when including Chef::DSL::Recipe::FullDSL' do
    expect_offense(<<~RUBY)
      include Chef::DSL::Recipe::FullDSL
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated Mixins no longer included in Chef Infra Client 14 and later.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when requiring chef/mixin/language' do
    expect_offense(<<~RUBY)
      require 'chef/mixin/language'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated Mixins no longer included in Chef Infra Client 14 and later.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when requiring chef/mixin/language_include_attribute' do
    expect_offense(<<~RUBY)
      require 'chef/mixin/language_include_attribute'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated Mixins no longer included in Chef Infra Client 14 and later.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when requiring chef/mixin/language_include_recipe' do
    expect_offense(<<~RUBY)
      require 'chef/mixin/language_include_recipe'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated Mixins no longer included in Chef Infra Client 14 and later.
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense on normal metadata" do
    expect_no_offenses(<<~RUBY)
      depends 'foo'
    RUBY
  end
end
