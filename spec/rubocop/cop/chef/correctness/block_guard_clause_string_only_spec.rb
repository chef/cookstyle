# frozen_string_literal: true

#
# Copyright:: Copyright 2019, Chef Software Inc.
# Author:: Tim Smith (<tsmith84@gmail.com>)
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

describe RuboCop::Cop::Chef::Correctness::BlockGuardWithOnlyString, :config do
  it 'registers an offense with a block guard that contains only a string' do
    expect_offense(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
        only_if { 'test -f /etc/foo' }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A resource guard (not_if/only_if) that is a string should not be wrapped in {}. Wrapping a guard string in {} causes it to be executed as Ruby code which will always return true instead of a shell command that will actually run.
      end
    RUBY

    expect_correction(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
        only_if 'test -f /etc/foo'
      end
    RUBY
  end

  it 'does not register an offense with a valid block guard' do
    expect_no_offenses(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
        only_if { ::File.exist?('/etc/chef/client.rb') }
      end
    RUBY
  end

  it 'does not register an offense with a valid string guard' do
    expect_no_offenses(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
        only_if 'test -f /etc/foo'
      end
    RUBY
  end
end
