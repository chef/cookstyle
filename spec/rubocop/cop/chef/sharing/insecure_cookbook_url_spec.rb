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

describe RuboCop::Cop::Chef::Sharing::InsecureCookbookURL, :config do
  it 'registers an offense when a cookbook sets its source_url to "http://github.com/something/something"' do
    expect_offense(<<~RUBY)
      source_url 'http://github.com/something/something'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Insecure http Github or Gitlab URLs for metadata source_url/issues_url fields
    RUBY

    expect_correction(<<~RUBY)
      source_url 'https://github.com/something/something'
    RUBY
  end

  it 'registers an offense when a cookbook sets its source_url to "http://www.github.com/something/something"' do
    expect_offense(<<~RUBY)
      source_url 'http://www.github.com/something/something'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Insecure http Github or Gitlab URLs for metadata source_url/issues_url fields
    RUBY

    expect_correction(<<~RUBY)
      source_url 'https://github.com/something/something'
    RUBY
  end

  it 'registers an offense when a cookbook sets its source_url to "http://gitlab.com/something/something"' do
    expect_offense(<<~RUBY)
      source_url 'http://gitlab.com/something/something'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Insecure http Github or Gitlab URLs for metadata source_url/issues_url fields
    RUBY

    expect_correction(<<~RUBY)
      source_url 'https://gitlab.com/something/something'
    RUBY
  end

  it 'also registers an offense when a cookbook sets its a bad issue_url' do
    expect_offense(<<~RUBY)
      issues_url 'http://gitlab.com/something/something'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Insecure http Github or Gitlab URLs for metadata source_url/issues_url fields
    RUBY

    expect_correction(<<~RUBY)
      issues_url 'https://gitlab.com/something/something'
    RUBY
  end

  it "doesn't register an offense with a valid GitHub non-www URL" do
    expect_no_offenses(<<~RUBY)
      source_url 'https://github.com/something/something'
    RUBY
  end

  it "doesn't register an offense with a valid GitHub www URL" do
    expect_no_offenses(<<~RUBY)
      source_url 'https://www.github.com/something/something'
    RUBY
  end

  it "doesn't register an offense with a valid Gitlab non-www URL" do
    expect_no_offenses(<<~RUBY)
      source_url 'https://gitlab.com/something/something'
    RUBY
  end

  it "doesn't register an offense with a valid Gitlab www URL" do
    expect_no_offenses(<<~RUBY)
      source_url 'https://www.gitlab.com/something/something'
    RUBY
  end
end
