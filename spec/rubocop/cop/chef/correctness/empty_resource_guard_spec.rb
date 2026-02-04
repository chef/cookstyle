# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# Author:: Sumedha (<https://github.com/sumedha-lolur>)
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

describe RuboCop::Cop::Chef::Correctness::EmptyResourceGuard, :config do
  it 'registers an offense when a resource has an empty string only_if guard' do
    expect_offense(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
        only_if ''
        ^^^^^^^^^^ Resource guards (not_if/only_if) should not be empty strings as empty strings will always evaluate to true.
      end
    RUBY
  end

  it 'registers an offense when a resource has an empty string not_if guard' do
    expect_offense(<<~RUBY)
      cookbook_file '/logs/foo/error.log' do
        source 'error.log'
        not_if ''
        ^^^^^^^^^ Resource guards (not_if/only_if) should not be empty strings as empty strings will always evaluate to true.
      end
    RUBY
  end

  it 'registers an offense when a resource has an empty string only_if guard in a block' do
    expect_offense(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
        only_if { '' }
        ^^^^^^^^^^^^^^ Resource guards (not_if/only_if) should not be empty strings as empty strings will always evaluate to true.
      end
    RUBY
  end

  it 'registers an offense when a resource has an empty string not_if guard in a block' do
    expect_offense(<<~RUBY)
      cookbook_file '/logs/foo/error.log' do
        source 'error.log'
        not_if { '' }
        ^^^^^^^^^^^^^ Resource guards (not_if/only_if) should not be empty strings as empty strings will always evaluate to true.
      end
    RUBY
  end

  it 'does not register an offense when a resource has a valid string guard' do
    expect_no_offenses(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
        only_if 'test -f /etc/foo'
      end
    RUBY
  end

  it 'does not register an offense when a resource has a valid block guard' do
    expect_no_offenses(<<~RUBY)
      cookbook_file '/logs/foo/error.log' do
        source 'error.log'
        not_if { ::File.exist?('/logs/foo/error.log') }
      end
    RUBY
  end

  it 'does not register an offense when a resource has a valid string in a block guard' do
    expect_no_offenses(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
        only_if { 'test -f /etc/foo' }
      end
    RUBY
  end

  it 'does not register an offense when a resource has no guards' do
    expect_no_offenses(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
      end
    RUBY
  end
end
