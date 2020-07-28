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

describe RuboCop::Cop::Chef::ChefModernize::IncludingMixinShelloutInResources, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an error when requiring "chef/mixin/shell_out" in a resource' do
    expect_offense(<<~RUBY, '/foo/bar/cookbook/resources/foo.rb')
    require 'chef/mixin/shell_out'
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to include Chef::Mixin::ShellOut or Chef::Mixin::PowershellOut in resources or providers as this is already done by Chef Infra Client 12.4+.
    RUBY

    expect_correction("\n")
  end

  it 'registers an error when requiring "chef/mixin/shell_out" in a HWRP inheriting from Chef::Provider' do
    expect_offense(<<~RUBY, '/foo/bar/cookbook/libraries/foo.rb')
    require 'chef/mixin/shell_out'
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to include Chef::Mixin::ShellOut or Chef::Mixin::PowershellOut in resources or providers as this is already done by Chef Infra Client 12.4+.

    class Chef
      class Provider
        class LvmVolumeGroup < Chef::Provider
        end
      end
    end
    RUBY
  end

  it 'registers an error when requiring "chef/mixin/shell_out" in a HWRP inheriting from Chef::Provider::LWRPBase' do
    expect_offense(<<~RUBY, '/foo/bar/cookbook/libraries/foo.rb')
    require 'chef/mixin/shell_out'
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to include Chef::Mixin::ShellOut or Chef::Mixin::PowershellOut in resources or providers as this is already done by Chef Infra Client 12.4+.

    class Chef
      class Provider
        class LvmVolumeGroup < Chef::Provider::LWRPBase
        end
      end
    end
    RUBY
  end

  it 'registers an error when including "Chef::Mixin::ShellOut" in a resource' do
    expect_offense(<<~RUBY, '/foo/bar/cookbook/resources/foo.rb')
    include Chef::Mixin::ShellOut
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to include Chef::Mixin::ShellOut or Chef::Mixin::PowershellOut in resources or providers as this is already done by Chef Infra Client 12.4+.
    RUBY

    expect_correction("\n")
  end

  it 'registers an error when requiring "chef/mixin/powershell_out" in a resource' do
    expect_offense(<<~RUBY, '/foo/bar/cookbook/resources/foo.rb')
    require 'chef/mixin/powershell_out'
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to include Chef::Mixin::ShellOut or Chef::Mixin::PowershellOut in resources or providers as this is already done by Chef Infra Client 12.4+.
    RUBY

    expect_correction("\n")
  end

  it 'registers an error when including "Chef::Mixin::PowershellOut" in a resource' do
    expect_offense(<<~RUBY, '/foo/bar/cookbook/resources/foo.rb')
    include Chef::Mixin::PowershellOut
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to include Chef::Mixin::ShellOut or Chef::Mixin::PowershellOut in resources or providers as this is already done by Chef Infra Client 12.4+.
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when requiring \"chef/mixin/shell_out\" in a non-HWRP library" do
    expect_no_offenses(<<~RUBY, '/foo/bar/cookbook/libraries/foo.rb')
    require 'chef/mixin/shell_out'

    class MyCookbook
      class Helpers
      end
    end
    RUBY
  end

  it "doesn't register an offense when including Chef::Mixin::Foo" do
    expect_no_offenses(<<~RUBY)
    include Chef::Mixin::Foo
    RUBY
  end

  it "doesn't register an offense when requiring chef/mixin/foo" do
    expect_no_offenses(<<~RUBY)
    require 'chef/mixin/foo'
    RUBY
  end
end
