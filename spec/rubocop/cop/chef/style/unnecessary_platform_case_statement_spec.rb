# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

describe RuboCop::Cop::Chef::Style::UnnecessaryPlatformCaseStatement, :config do
  it 'registers an offense when checking platform with a single condition case statement' do
    expect_offense(<<~RUBY)
      case node['platform']
      ^^^^^^^^^^^^^^^^^^^^^ Use the platform?() and platform_family?() helpers instead of a case statement that only includes a single when statement.
      when 'ubuntu'
        apt_update
      else
        log 'nothing to do'
      end
    RUBY

    expect_correction(<<~RUBY)
      if platform?('ubuntu')
        apt_update
      else
        log 'nothing to do'
      end
    RUBY
  end

  it 'autocorrects complex case platform checks to a single line if there is no else statement' do
    corrected = autocorrect_source(<<~RUBY)
      case node['platform']
      when 'ubuntu', 'debian'
        apt_update
      end
    RUBY

    expect(corrected).to eq "apt_update if platform?('ubuntu', 'debian')\n"
  end

  it "doesn't autocorrect complex case platform checks with no code in any when/else" do
    expect_offense(<<~RUBY)
      case node['platform']
      ^^^^^^^^^^^^^^^^^^^^^ Use the platform?() and platform_family?() helpers instead of a case statement that only includes a single when statement.
      when 'ubuntu', 'debian'
        # nothing here
      else
        # nothing here
      end
    RUBY

    expect_no_corrections
  end

  it 'handles spaces when setting values with case statements' do
    expect_offense(<<~RUBY)
      val = case node['platform_family']
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the platform?() and platform_family?() helpers instead of a case statement that only includes a single when statement.
            when 'debian'
              'openssl-dev'
            else
              'openssl-devel'
            end
    RUBY

    expect_correction(<<~RUBY)
      val = if platform_family?('debian')
              'openssl-dev'
            else
              'openssl-devel'
            end
    RUBY
  end

  it 'does not register an offense a platform case statement has multiple conditions' do
    expect_no_offenses(<<~RUBY)
      case node['platform']
      when 'ubuntu'
        apt_update
      when 'mac_os_x'
        brew_update
      else
        log 'nothing to do'
      end
    RUBY
  end
end
