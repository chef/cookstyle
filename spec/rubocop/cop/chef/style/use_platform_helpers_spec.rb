# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Style::UsePlatformHelpers, :config do
  it "registers an offense when checking platform using node['platform']" do
    expect_offense(<<~RUBY)
      if node['platform'] == 'redhat'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use platform? and platform_family? helpers to check a node's platform
      end
    RUBY

    expect_correction(<<~RUBY)
      if platform?('redhat')
      end
    RUBY
  end

  it "registers an offense when checking platform using node['platform'] for not equals" do
    expect_offense(<<~RUBY)
      if node['platform'] != 'redhat'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use platform? and platform_family? helpers to check a node's platform
      end
    RUBY

    expect_correction(<<~RUBY)
      if !platform?('redhat')
      end
    RUBY
  end

  it "registers an offense when checking platform family using node['platform_family']" do
    expect_offense(<<~RUBY)
      if node['platform_family'] == 'rhel'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use platform? and platform_family? helpers to check a node's platform
      end
    RUBY

    expect_correction(<<~RUBY)
      if platform_family?('rhel')
      end
    RUBY
  end

  it 'registers an offense when checking platform family with include? and an array of values' do
    expect_offense(<<~RUBY)
      if %w(rhel suse).include?(node['platform_family'])
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use platform? and platform_family? helpers to check a node's platform
      end
    RUBY

    expect_correction(<<~RUBY)
      if platform_family?('rhel', 'suse')
      end
    RUBY
  end

  it 'registers an offense when checking platform family with include? and a quoted array of values' do
    expect_offense(<<~RUBY)
      if ['rhel', some_variable].include?(node['platform_family'])
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use platform? and platform_family? helpers to check a node's platform
      end
    RUBY

    expect_correction(<<~RUBY)
      if platform_family?('rhel', some_variable)
      end
    RUBY
  end

  it "registers an offense when checking platform using node['platform'].eql?()" do
    expect_offense(<<~RUBY)
      if node['platform'].eql?('ubuntu')
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use platform? and platform_family? helpers to check a node's platform
      end
    RUBY

    expect_correction(<<~RUBY)
      if platform?('ubuntu')
      end
    RUBY
  end
end
