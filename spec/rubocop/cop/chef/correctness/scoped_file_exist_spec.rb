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

describe RuboCop::Cop::Chef::Correctness::ScopedFileExist, :config do
  it 'registers an offense when not scoping File.exist? in a only_if block' do
    expect_offense(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        only_if { File.exist?('foo/bar') }
                  ^^^^ Scope file exist to access the correct File class by using ::File.exist? not File.exist?.
      end
    RUBY

    expect_correction(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        only_if { ::File.exist?('foo/bar') }
      end
    RUBY
  end

  it 'registers an offense when not scoping File.exist? in a not_if block' do
    expect_offense(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        not_if { File.exist?('foo/bar') }
                 ^^^^ Scope file exist to access the correct File class by using ::File.exist? not File.exist?.
      end
    RUBY

    expect_correction(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        not_if { ::File.exist?('foo/bar') }
      end
    RUBY
  end

  it 'does not register an offense with a properly scoped File.exist? in a conditional' do
    expect_no_offenses(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        only_if { ::File.exist?('/etc/chef/client.rb') }
      end
    RUBY
  end
end
