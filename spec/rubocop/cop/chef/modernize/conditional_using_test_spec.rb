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

describe RuboCop::Cop::Chef::ChefModernize::ConditionalUsingTest, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when an only_if uses test -f' do
    expect_offense(<<~RUBY)
      execute 'apt-get update' do
        only_if 'test -f /sbin/apt'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use ::File.exist?('/foo/bar') instead of the slower 'test -f /foo/bar' which requires shelling out
      end
    RUBY

    expect_correction(<<~RUBY)
      execute 'apt-get update' do
        only_if { ::File.exist?('/sbin/apt') }
      end
    RUBY
  end

  it 'registers an offense when a not_if uses test -f' do
    expect_offense(<<~RUBY)
      execute 'yum update' do
        not_if 'test -f /sbin/apt'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^ Use ::File.exist?('/foo/bar') instead of the slower 'test -f /foo/bar' which requires shelling out
      end
    RUBY

    expect_correction(<<~RUBY)
      execute 'yum update' do
        not_if { ::File.exist?('/sbin/apt') }
      end
    RUBY
  end

  it 'registers an offense with test -e as well' do
    expect_offense(<<~RUBY)
      execute 'yum update' do
        not_if 'test -e /sbin/apt'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^ Use ::File.exist?('/foo/bar') instead of the slower 'test -f /foo/bar' which requires shelling out
      end
    RUBY

    expect_correction(<<~RUBY)
      execute 'yum update' do
        not_if { ::File.exist?('/sbin/apt') }
      end
    RUBY
  end

  it "doesn't register an offense when test is used with a flag other than -e or -f" do
    expect_no_offenses(<<~RUBY)
      execute 'apt-get update' do
        only_if 'test -j /sbin/apt'
      end
    RUBY
  end
end
