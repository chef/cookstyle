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

describe RuboCop::Cop::Chef::Modernize::LegacyBerksfileSource, :config do
  it 'registers an offense when using community.opscode.com' do
    expect_offense(<<~RUBY)
      source 'http://community.opscode.com/api/v3'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use legacy Berksfile community sources. Use Chef Supermarket instead.
    RUBY

    expect_correction(<<~RUBY)
      source 'https://supermarket.chef.io'
    RUBY
  end

  it 'registers an offense when using api.berkshelf.com' do
    expect_offense(<<~RUBY)
      source 'https://api.berkshelf.com'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use legacy Berksfile community sources. Use Chef Supermarket instead.
    RUBY

    expect_correction(<<~RUBY)
      source 'https://supermarket.chef.io'
    RUBY
  end

  it 'registers an offense when using supermarket.getchef.com' do
    expect_offense(<<~RUBY)
      source 'https://supermarket.getchef.com'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use legacy Berksfile community sources. Use Chef Supermarket instead.
    RUBY

    expect_correction(<<~RUBY)
      source 'https://supermarket.chef.io'
    RUBY
  end

  it 'registers an offense when using site :opscode' do
    expect_offense(<<~RUBY)
      site :opscode
      ^^^^^^^^^^^^^ Do not use legacy Berksfile community sources. Use Chef Supermarket instead.
    RUBY

    expect_correction(<<~RUBY)
      source 'https://supermarket.chef.io'
    RUBY
  end

  it "doesn't register an offense when using supermarket.chef.io" do
    expect_no_offenses(<<~RUBY)
      source 'https://supermarket.chef.io'
    RUBY
  end
end
