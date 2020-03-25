#
# Copyright:: 2019-2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefDeprecations::WindowsVersionHelpers, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using Windows::VersionHelper nt_version helper' do
    expect_offense(<<~RUBY)
    if Windows::VersionHelper.nt_version == 10
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['platform_version'] and node['kernel'] data introduced in Chef Infra Client 14 instead of the deprecated Windows::VersionHelper helpers from the Windows cookbook.
      puts 'Windows 10'
    end
    RUBY

    expect_correction(<<~RUBY)
    if node['platform_version'].to_f == 10
      puts 'Windows 10'
    end
    RUBY
  end

  it 'registers an offense when using Windows::VersionHelper server_version? helper' do
    expect_offense(<<~RUBY)
    if Windows::VersionHelper.server_version?
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['platform_version'] and node['kernel'] data introduced in Chef Infra Client 14 instead of the deprecated Windows::VersionHelper helpers from the Windows cookbook.
      puts 'Server Edition'
    end
    RUBY

    expect_correction(<<~RUBY)
    if node['kernel']['product_type'] == 'Server'
      puts 'Server Edition'
    end
    RUBY
  end

  it 'registers an offense when using Windows::VersionHelper core_version? helper' do
    expect_offense(<<~RUBY)
    if Windows::VersionHelper.core_version?
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['platform_version'] and node['kernel'] data introduced in Chef Infra Client 14 instead of the deprecated Windows::VersionHelper helpers from the Windows cookbook.
      puts 'Core Edition'
    end
    RUBY

    expect_correction(<<~RUBY)
    if node['kernel']['server_core']
      puts 'Core Edition'
    end
    RUBY
  end

  it 'registers an offense when using Windows::VersionHelper workstation_version? helper' do
    expect_offense(<<~RUBY)
    if Windows::VersionHelper.workstation_version?
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['platform_version'] and node['kernel'] data introduced in Chef Infra Client 14 instead of the deprecated Windows::VersionHelper helpers from the Windows cookbook.
      puts 'Workstation Edition'
    end
    RUBY

    expect_correction(<<~RUBY)
    if node['kernel']['product_type'] == 'Workstation'
      puts 'Workstation Edition'
    end
    RUBY
  end
end
