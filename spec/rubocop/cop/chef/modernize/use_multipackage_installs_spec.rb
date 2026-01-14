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

describe RuboCop::Cop::Chef::Modernize::UseMultipackageInstalls, :config do
  it 'registers an offense when iterating over an array of packages in a case statement' do
    expect_offense(<<~RUBY)
      case node['platform']
      when 'ubuntu'
        include_recipe 'apt'

        %w(bmon htop vim curl).each do |pkg|
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Pass an array of packages to package resources instead of iterating over an array of packages when using multi-package capable package subsystem such as apt, yum, chocolatey, dnf, or zypper. Multi-package installs are faster and simplify logs.
          package pkg do
            action :install
          end
        end
      end
    RUBY

    expect_correction(<<~RUBY)
      case node['platform']
      when 'ubuntu'
        include_recipe 'apt'

        package %w(bmon htop vim curl)
      end
    RUBY
  end

  it 'does not fail with an empty when statement' do
    expect_no_offenses(<<~RUBY)
      case node['platform_family']
      when 'debian'
        # nothing here
      end
    RUBY
  end

  it 'does not fail if the when is a regex' do
    expect_no_offenses(<<~RUBY)
      case node['platform_family']
      when /debian/
        package 'it-is-fine'
      end
    RUBY
  end

  it 'registers an offense when iterating over an array of packages in a case statement with a non-block package resource' do
    expect_offense(<<~RUBY)
      case node['platform']
      when 'ubuntu'
        %w(bmon htop vim curl).each do |pkg|
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Pass an array of packages to package resources instead of iterating over an array of packages when using multi-package capable package subsystem such as apt, yum, chocolatey, dnf, or zypper. Multi-package installs are faster and simplify logs.
          package pkg
        end
      end
    RUBY

    expect_correction(<<~RUBY)
      case node['platform']
      when 'ubuntu'
        package %w(bmon htop vim curl)
      end
    RUBY
  end

  it 'registers an offense when iterating over an array of packages in a platform? check with a non-block package resource' do
    expect_offense(<<~RUBY)
      if platform?('ubuntu')
        %w(bmon htop vim curl).each do |pkg|
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Pass an array of packages to package resources instead of iterating over an array of packages when using multi-package capable package subsystem such as apt, yum, chocolatey, dnf, or zypper. Multi-package installs are faster and simplify logs.
          package pkg
        end
      end
    RUBY

    expect_correction(<<~RUBY)
      if platform?('ubuntu')
        package %w(bmon htop vim curl)
      end
    RUBY
  end

  it 'registers an offense when iterating over an array of packages in a platform? check' do
    expect_offense(<<~RUBY)
      if platform?('ubuntu')
        %w(bmon htop vim curl).each do |pkg|
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Pass an array of packages to package resources instead of iterating over an array of packages when using multi-package capable package subsystem such as apt, yum, chocolatey, dnf, or zypper. Multi-package installs are faster and simplify logs.
          package pkg do
            action :install
          end
        end
      end
    RUBY

    expect_correction(<<~RUBY)
      if platform?('ubuntu')
        package %w(bmon htop vim curl)
      end
    RUBY
  end

  it "doesn't register an offense when iterating over packages in a case statement on a non-multi-package platform" do
    expect_no_offenses(<<~RUBY)
      case node['platform']
      when 'mac_os_x'
        %w(bmon htop vim curl).each do |pkg|
          package pkg do
            action :install
          end
        end
      end
    RUBY
  end

  it "doesn't register an offense when iterating over packages in a platform? check on a non-multi-package platform" do
    expect_no_offenses(<<~RUBY)
      if platform?('mac_os_x')
        %w(bmon htop vim curl).each do |pkg|
          package pkg do
            action :install
          end
        end
      end
    RUBY
  end
end
