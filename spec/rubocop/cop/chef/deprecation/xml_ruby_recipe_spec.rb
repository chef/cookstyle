# frozen_string_literal: true
#
# Copyright:: 2019-2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Deprecations::IncludingXMLRubyRecipe, :config do
  it 'registers an offense when including the "xml::ruby" recipe' do
    expect_offense(<<~RUBY)
      include_recipe 'xml::ruby'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not include the deprecated xml::ruby recipe to install the nokogiri gem. Chef Infra Client 12 and later ships with nokogiri included.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when including the "xml::ruby" recipe with a conditional' do
    expect_offense(<<~RUBY)
      include_recipe 'xml::ruby' unless platform_family?('windows')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not include the deprecated xml::ruby recipe to install the nokogiri gem. Chef Infra Client 12 and later ships with nokogiri included.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when including the "xml::ruby" recipe but skips non-inline conditional' do
    expect_offense(<<~RUBY)
      if foo == bar
        baz
        include_recipe 'xml::ruby' unless platform_family?('windows')
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not include the deprecated xml::ruby recipe to install the nokogiri gem. Chef Infra Client 12 and later ships with nokogiri included.
      end
    RUBY

    expect_correction("if foo == bar\n  baz\n  \nend\n")
  end

  it "doesn't register an offense when including any other recipe" do
    expect_no_offenses(<<~RUBY)
      include_recipe 'xml::default'
    RUBY
  end
end
