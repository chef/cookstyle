# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Modernize::NodeInitPackage, :config do
  it "registers an offense with ::File.open('/proc/1/comm').gets.chomp" do
    expect_offense(<<~RUBY)
      ::File.open('/proc/1/comm').gets.chomp == 'systemd'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['init_package'] to check for systemd instead of reading the contents of '/proc/1/comm'
    RUBY

    expect_correction(<<~RUBY)
      node['init_package'] == 'systemd'
    RUBY
  end

  it "registers an offense with File.open('/proc/1/comm').gets.chomp" do
    expect_offense(<<~RUBY)
      File.open('/proc/1/comm').gets.chomp == 'systemd'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['init_package'] to check for systemd instead of reading the contents of '/proc/1/comm'
    RUBY

    expect_correction(<<~RUBY)
      node['init_package'] == 'systemd'
    RUBY
  end

  it "registers an offense with IO.read('/proc/1/comm').chomp == 'systemd'" do
    expect_offense(<<~RUBY)
      IO.read('/proc/1/comm').chomp == 'systemd'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['init_package'] to check for systemd instead of reading the contents of '/proc/1/comm'
    RUBY

    expect_correction(<<~RUBY)
      node['init_package'] == 'systemd'
    RUBY
  end

  it "registers an offense with ::IO.read('/proc/1/comm').chomp == 'systemd'" do
    expect_offense(<<~RUBY)
      ::IO.read('/proc/1/comm').chomp == 'systemd'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['init_package'] to check for systemd instead of reading the contents of '/proc/1/comm'
    RUBY

    expect_correction(<<~RUBY)
      node['init_package'] == 'systemd'
    RUBY
  end

  it "registers an offense with ::IO.read('/proc/1/comm').gets.chomp == 'systemd'" do
    expect_offense(<<~RUBY)
      ::IO.read('/proc/1/comm').gets.chomp == 'systemd'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['init_package'] to check for systemd instead of reading the contents of '/proc/1/comm'
    RUBY

    expect_correction(<<~RUBY)
      node['init_package'] == 'systemd'
    RUBY
  end

  it "registers an offense with File.exist?('/proc/1/comm') && File.open('/proc/1/comm').chomp == 'systemd'" do
    expect_offense(<<~RUBY)
      File.exist?('/proc/1/comm') && File.open('/proc/1/comm').chomp == 'systemd'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['init_package'] to check for systemd instead of reading the contents of '/proc/1/comm'
    RUBY

    expect_correction(<<~RUBY)
      node['init_package'] == 'systemd'
    RUBY
  end

  it "registers an offense with File.open('/proc/1/comm').chomp" do
    expect_offense(<<~RUBY)
      File.open('/proc/1/comm').chomp == 'systemd'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['init_package'] to check for systemd instead of reading the contents of '/proc/1/comm'
    RUBY

    expect_correction(<<~RUBY)
      node['init_package'] == 'systemd'
    RUBY
  end

  it "registers an offense with only_if 'test -f /bin/systemctl && /bin/systemctl'" do
    expect_offense(<<~RUBY)
      only_if 'test -f /bin/systemctl && /bin/systemctl'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['init_package'] to check for systemd instead of reading the contents of '/proc/1/comm'
    RUBY

    expect_correction(<<~RUBY)
      only_if { node['init_package'] == 'systemd' }
    RUBY
  end

  it "registers an offense with not_if 'test -f /bin/systemctl && /bin/systemctl'" do
    expect_offense(<<~RUBY)
      not_if 'test -f /bin/systemctl && /bin/systemctl'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['init_package'] to check for systemd instead of reading the contents of '/proc/1/comm'
    RUBY

    expect_correction(<<~RUBY)
      not_if { node['init_package'] == 'systemd' }
    RUBY
  end

  it "does not register an offense when comparing a non-systemd value in '/proc/1/comm'" do
    expect_no_offenses(<<~RUBY)
      ::File.open('/proc/1/comm').gets.chomp == 'foo'
    RUBY
  end
end
