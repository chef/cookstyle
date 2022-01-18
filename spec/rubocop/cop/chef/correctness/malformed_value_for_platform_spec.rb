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

describe RuboCop::Cop::Chef::Correctness::MalformedPlatformValueForPlatformHelper, :config do
  it 'registers an offense when passing 2+ different hashes' do
    expect_offense(<<~RUBY)
      value_for_platform(
      ^^^^^^^^^^^^^^^^^^^ Malformed value_for_platform helper argument. The value_for_platform helper takes a single hash of platforms as an argument.
        { %w(redhat oracle) => {
           'default' => 'foo',
         } },
          %w(debian ubuntu) => {
           'default' => 'bar',
         }
      )
    RUBY
  end

  it 'registers an offense when the platform contains a non-hash value' do
    expect_offense(<<~RUBY)
      value_for_platform(
        %w(redhat oracle) => 'baz'
                             ^^^^^ Malformed value_for_platform helper argument. The value for each platform in your hash must be a hash of either platform version strings or a value with a key of 'default'
      )
    RUBY
  end

  it "doesn't register an offense for passing a variable we can't inspect" do
    expect_no_offenses('value_for_platform(foo)')
  end

  it "doesn't register an offense when value_for_platform passes valid platforms" do
    expect_no_offenses(<<~RUBY)
      value_for_platform(
        %w(redhat mac_os_x) => { 'default' => 'foo' },
        %w(suse) => { 'default' => 'bar' }
      )
    RUBY
  end

  it "doesn't register an offense when there's a top level default" do
    expect_no_offenses(<<~RUBY)
      value_for_platform(
        %w(debian ubuntu) => {
          'default' => 'bar',
        },
        'default' => 'baz'
      )
    RUBY
  end
end
