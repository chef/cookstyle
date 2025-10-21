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

describe RuboCop::Cop::Chef::Correctness::InvalidPlatformFamilyInCase, :config do
  it "registers an offense if case node['platform_family'] checks for an invalid platform_family" do
    expect_offense(<<~RUBY)
      case node['platform_family']
      when 'centos'
           ^^^^^^^^ Use valid platform family values in case statements.
        puts "I'm on a Red Hat like box!"
      end
    RUBY

    expect_correction(<<~RUBY)
      case node['platform_family']
      when 'rhel'
        puts "I'm on a Red Hat like box!"
      end
    RUBY
  end

  it 'does not add duplicate corrected values to the when condition' do
    expect_offense(<<~RUBY)
      case node['platform_family']
      when 'centos', 'rhel'
           ^^^^^^^^ Use valid platform family values in case statements.
        puts "I'm on a Red Hat like box!"
      end
    RUBY

    expect_correction(<<~RUBY)
      case node['platform_family']
      when 'rhel'
        puts "I'm on a Red Hat like box!"
      end
    RUBY
  end

  it 'does not leave a trailing comma behind when autocorrecting' do
    expect_offense(<<~RUBY)
      case node['platform_family']
      when 'rhel', 'centos'
                   ^^^^^^^^ Use valid platform family values in case statements.
        puts "I'm on a Red Hat box!"
      end
    RUBY

    expect_correction(<<~RUBY)
      case node['platform_family']
      when 'rhel'
        puts "I'm on a Red Hat box!"
      end
    RUBY
  end

  it "doesn't register an offense if case node['platform_family'] uses 'redhat'" do
    expect_no_offenses(<<~RUBY)
      case node['platform_family']
      when 'rhel'
        puts "I'm on a Red Hat box!"
      end
    RUBY
  end
end
