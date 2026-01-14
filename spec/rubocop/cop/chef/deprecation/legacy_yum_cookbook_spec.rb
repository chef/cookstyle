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

describe RuboCop::Cop::Chef::Deprecations::LegacyYumCookbookRecipes, :config do
  it 'registers an offense when a cookbook includes "yum::elrepo"' do
    expect_offense(<<~RUBY)
      include_recipe 'yum::elrepo'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The elrepo, epel, ius, remi, and repoforge recipes were split into their own cookbooks and the yum recipe was renamed to be default with the release of yum cookbook 3.0 (Dec 2013).
    RUBY
  end

  it 'registers an offense when a cookbook includes "yum::epel"' do
    expect_offense(<<~RUBY)
      include_recipe 'yum::epel'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ The elrepo, epel, ius, remi, and repoforge recipes were split into their own cookbooks and the yum recipe was renamed to be default with the release of yum cookbook 3.0 (Dec 2013).
    RUBY
  end

  it 'registers an offense when a cookbook includes "yum::ius"' do
    expect_offense(<<~RUBY)
      include_recipe 'yum::ius'
      ^^^^^^^^^^^^^^^^^^^^^^^^^ The elrepo, epel, ius, remi, and repoforge recipes were split into their own cookbooks and the yum recipe was renamed to be default with the release of yum cookbook 3.0 (Dec 2013).
    RUBY
  end

  it 'registers an offense when a cookbook includes "yum::remi"' do
    expect_offense(<<~RUBY)
      include_recipe 'yum::remi'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ The elrepo, epel, ius, remi, and repoforge recipes were split into their own cookbooks and the yum recipe was renamed to be default with the release of yum cookbook 3.0 (Dec 2013).
    RUBY
  end

  it 'registers an offense when a cookbook includes "yum::repoforge"' do
    expect_offense(<<~RUBY)
      include_recipe 'yum::repoforge'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The elrepo, epel, ius, remi, and repoforge recipes were split into their own cookbooks and the yum recipe was renamed to be default with the release of yum cookbook 3.0 (Dec 2013).
    RUBY
  end

  it 'registers an offense when a cookbook includes "yum::yum"' do
    expect_offense(<<~RUBY)
      include_recipe 'yum::yum'
      ^^^^^^^^^^^^^^^^^^^^^^^^^ The elrepo, epel, ius, remi, and repoforge recipes were split into their own cookbooks and the yum recipe was renamed to be default with the release of yum cookbook 3.0 (Dec 2013).
    RUBY
  end

  it "doesn't register an offense when including yum::default" do
    expect_no_offenses(<<~RUBY)
      include_recipe 'yum::default'
    RUBY
  end
end
