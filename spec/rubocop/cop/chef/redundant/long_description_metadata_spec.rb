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

describe RuboCop::Cop::Chef::RedundantCode::LongDescriptionMetadata, :config do
  it 'registers an offense when metadata uses "long_description"' do
    expect_offense(<<~RUBY)
      description 'foo'
      long_description 'foo'
      ^^^^^^^^^^^^^^^^^^^^^^ The long_description metadata.rb method is not used and is unnecessary in cookbooks.
      version '1.0.0'
    RUBY

    expect_correction("description 'foo'\nversion '1.0.0'\n")
  end

  it 'properly autocorrects long_description with a heredoc' do
    expect_offense(<<~RUBY)
      description 'foo'
      long_description <<-EOH
      ^^^^^^^^^^^^^^^^^^^^^^^ The long_description metadata.rb method is not used and is unnecessary in cookbooks.
      Chef Sugar is a Gem & Chef Recipe that includes series of helpful syntactic
      sugars on top of the Chef core and other resources to make a cleaner, more lean
      recipe DSL, enforce DRY principles, and make writing Chef recipes an awesome and
      fun experience!

      For the most up-to-date information and documentation, please visit the [Chef
      Sugar project page on GitHub](https://github.com/chef/chef-sugar).
      EOH
      version '1.0.0'
    RUBY

    expect_correction("description 'foo'\nversion '1.0.0'\n")
  end

  it "doesn't register an offense on normal metadata" do
    expect_no_offenses(<<~RUBY)
      depends 'foo'
    RUBY
  end
end
