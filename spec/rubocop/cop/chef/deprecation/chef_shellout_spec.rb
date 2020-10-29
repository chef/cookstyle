# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Deprecations::ChefShellout, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using Mixin::Shellout' do
    expect_offense(<<~RUBY)
      foo = Chef::ShellOut.new('foo')
            ^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated Chef::ShellOut which was removed in Chef Infra Client 13. Use Mixlib::ShellOut instead, which behaves identically.
    RUBY

    expect_correction(<<~RUBY)
      foo = Mixlib::ShellOut.new('foo')
    RUBY
  end

  it 'registers an offense when using methods in Mixin::Shellout' do
    expect_offense(<<~RUBY)
      Chef::ShellOut.new('foo').run_command
      ^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated Chef::ShellOut which was removed in Chef Infra Client 13. Use Mixlib::ShellOut instead, which behaves identically.
    RUBY

    expect_correction(<<~RUBY)
      Mixlib::ShellOut.new('foo').run_command
    RUBY
  end

  it 'registers an offense when requiring chef/shellout' do
    expect_offense(<<~RUBY)
      require 'chef/shellout'
      ^^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated Chef::ShellOut which was removed in Chef Infra Client 13. Use Mixlib::ShellOut instead, which behaves identically.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when including Chef::ShellOut' do
    expect_offense(<<~RUBY)
      include Chef::ShellOut
      ^^^^^^^^^^^^^^^^^^^^^^ Don't use deprecated Chef::ShellOut which was removed in Chef Infra Client 13. Use Mixlib::ShellOut instead, which behaves identically.
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when using Mixlib::ShellOut instead" do
    expect_no_offenses(<<~RUBY)
      include Mixlib::ShellOut
      require 'mixlib/shellout'
      Mixlib::ShellOut.new('some_command')
      Mixlib::ShellOut.new('some_command').run_command
    RUBY
  end
end
