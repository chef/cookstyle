# frozen_string_literal: true
#
# Copyright:: Copyright 2020, Chef Software Inc.
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

describe RuboCop::Cop::Chef::Correctness::LazyInResourceGuard, :config do
  it 'registers an offense with a resource guard uses lazy' do
    expect_offense(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
        only_if { lazy { ::File.exists?('foo') } }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Using `lazy {}` within a resource guard (not_if/only_if) will cause failures and is unnecessary as resource guards are always lazily evaluated.
      end
    RUBY

    expect_correction(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
        only_if { ::File.exists?('foo') }
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
