#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefStyle::UnnecessaryOSCheck do
  subject(:cop) { described_class.new }

  it "registers an offense with node['os'] == 'darwin'" do
    expect_offense(<<~RUBY)
      node['os'] == 'darwin'
      ^^^^^^^^^^^^^^^^^^^^^^ Use the platform_family?() helpers instead of node['os] == 'foo' for platform_families that match 1:1 with OS values.
    RUBY

    expect_correction(<<~RUBY)
      platform_family?('mac_os_x')
    RUBY
  end

  it "registers an offense with node['os'] == 'windows'" do
    expect_offense(<<~RUBY)
      node['os'] == 'windows'
      ^^^^^^^^^^^^^^^^^^^^^^^ Use the platform_family?() helpers instead of node['os] == 'foo' for platform_families that match 1:1 with OS values.
    RUBY

    expect_correction(<<~RUBY)
      platform_family?('windows')
    RUBY
  end

  it "registers an offense with node['os'].eql?('aix')" do
    expect_offense(<<~RUBY)
      node['os'].eql?('aix')
      ^^^^^^^^^^^^^^^^^^^^^^ Use the platform_family?() helpers instead of node['os] == 'foo' for platform_families that match 1:1 with OS values.
    RUBY

    expect_correction(<<~RUBY)
      platform_family?('aix')
    RUBY
  end

  it "registers an offense with %w(netbsd openbsd freebsd).include?(node['os'])" do
    expect_offense(<<~RUBY)
    %w(netbsd openbsd freebsd).include?(node['os'])
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the platform_family?() helpers instead of node['os] == 'foo' for platform_families that match 1:1 with OS values.
    RUBY

    expect_correction(<<~RUBY)
      platform_family?('netbsd', 'openbsd', 'freebsd')
    RUBY
  end

  it "does not register an offense with node['os'] == 'linux'" do
    expect_no_offenses("node['os'] == 'linux'")
  end

  it "does not register an with node['os'].include? if any platforms aren't in our list of 1:1 matching platform families" do
    expect_no_offenses(<<~RUBY)
      %w(netbsd openbsd freebsd linux).include?(node['os'])
    RUBY
  end
end
