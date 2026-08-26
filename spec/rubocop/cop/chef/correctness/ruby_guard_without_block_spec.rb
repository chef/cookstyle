# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# Author:: Tim Smith (<tsmith84@proton.me>)
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

describe RuboCop::Cop::Chef::Correctness::RubyGuardWithoutBlock, :config do
  it 'registers an offense when not_if is passed a File.exist? call' do
    expect_offense(<<~RUBY)
      execute 'foo' do
        not_if ::File.exist?('/etc/foo')
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A Ruby expression used as a resource guard has to be wrapped in a block. Passing it directly hands the guard the expression result, which raises at converge time or silently runs a shell command.
      end
    RUBY

    expect_correction(<<~RUBY)
      execute 'foo' do
        not_if { ::File.exist?('/etc/foo') }
      end
    RUBY
  end

  it 'registers an offense when only_if is passed a comparison' do
    expect_offense(<<~RUBY)
      execute 'foo' do
        only_if node['foo']['version'] == '1.0'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A Ruby expression used as a resource guard has to be wrapped in a block. Passing it directly hands the guard the expression result, which raises at converge time or silently runs a shell command.
      end
    RUBY

    expect_correction(<<~RUBY)
      execute 'foo' do
        only_if { node['foo']['version'] == '1.0' }
      end
    RUBY
  end

  it 'registers an offense when a guard is passed a negation' do
    expect_offense(<<~RUBY)
      execute 'foo' do
        only_if !node['foo']['enabled']
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A Ruby expression used as a resource guard has to be wrapped in a block. Passing it directly hands the guard the expression result, which raises at converge time or silently runs a shell command.
      end
    RUBY

    expect_correction(<<~RUBY)
      execute 'foo' do
        only_if { !node['foo']['enabled'] }
      end
    RUBY
  end

  it 'registers an offense when a guard is passed a boolean literal' do
    expect_offense(<<~RUBY)
      execute 'foo' do
        only_if true
        ^^^^^^^^^^^^ A Ruby expression used as a resource guard has to be wrapped in a block. Passing it directly hands the guard the expression result, which raises at converge time or silently runs a shell command.
      end
    RUBY

    expect_correction(<<~RUBY)
      execute 'foo' do
        only_if { true }
      end
    RUBY
  end

  it 'registers an offense when a guard is passed a compound expression' do
    expect_offense(<<~RUBY)
      execute 'foo' do
        only_if ::File.exist?('/etc/foo') && node['foo']['enabled']
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A Ruby expression used as a resource guard has to be wrapped in a block. Passing it directly hands the guard the expression result, which raises at converge time or silently runs a shell command.
      end
    RUBY

    expect_correction(<<~RUBY)
      execute 'foo' do
        only_if { ::File.exist?('/etc/foo') && node['foo']['enabled'] }
      end
    RUBY
  end

  it "doesn't register an offense when the guard is a block" do
    expect_no_offenses(<<~RUBY)
      execute 'foo' do
        not_if { ::File.exist?('/etc/foo') }
      end
    RUBY
  end

  it "doesn't register an offense when the guard is a shell command string" do
    expect_no_offenses(<<~RUBY)
      execute 'foo' do
        not_if 'test -f /etc/foo'
      end
    RUBY
  end

  it "doesn't register an offense when the guard is an interpolated string" do
    expect_no_offenses(<<~'RUBY')
      execute 'foo' do
        not_if "test -f #{node['foo']['path']}"
      end
    RUBY
  end

  it "doesn't register an offense when the guard is a variable holding a command" do
    expect_no_offenses(<<~RUBY)
      execute 'foo' do
        not_if guard_command
      end
    RUBY
  end

  it "doesn't register an offense when the guard is a local variable" do
    expect_no_offenses(<<~RUBY)
      cmd = 'test -f /etc/foo'
      execute 'foo' do
        not_if cmd
      end
    RUBY
  end
end
