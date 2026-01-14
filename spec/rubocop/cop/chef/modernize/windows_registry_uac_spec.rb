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

describe RuboCop::Cop::Chef::Modernize::WindowsRegistryUAC, :config do
  it 'registers an offense when a sets UAC config via registry_key' do
    expect_offense(<<~RUBY)
      registry_key 'HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.0 and later includes a windows_uac resource that should be used to set Windows UAC values instead of setting registry keys directly.
        values [{ name: 'EnableLUA', type: :dword, data: 0 }]
        action :create
      end
    RUBY
  end

  it 'registers an offense when a sets UAC config via the shortened form of the key' do
    expect_offense(<<~RUBY)
      registry_key 'HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.0 and later includes a windows_uac resource that should be used to set Windows UAC values instead of setting registry keys directly.
        values [{ name: 'EnableLUA', type: :dword, data: 0 }]
        action :create
      end
    RUBY
  end

  it 'registers an offense when a sets UAC config via registry_key using the key property' do
    expect_offense(<<~RUBY)
      registry_key 'Set UAC values' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.0 and later includes a windows_uac resource that should be used to set Windows UAC values instead of setting registry keys directly.
        key 'HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System'
        values [{ name: 'EnableLUA', type: :dword, data: 0 }]
        action :create
      end
    RUBY
  end

  it 'registers an offense when a sets UAC config via registry_key using a lowercase key' do
    expect_offense(<<~RUBY)
      registry_key 'hkey_local_machine\\software\\microsoft\\windows\\currentversion\\policies\\system' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.0 and later includes a windows_uac resource that should be used to set Windows UAC values instead of setting registry keys directly.
        values [{ name: 'EnableLUA', type: :dword, data: 0 }]
        action :create
      end
    RUBY
  end

  it 'registers an offense when a sets UAC config via registry_key using a shortened key' do
    expect_offense(<<~RUBY)
      registry_key 'HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.0 and later includes a windows_uac resource that should be used to set Windows UAC values instead of setting registry keys directly.
        values [{ name: 'EnableLUA', type: :dword, data: 0 }]
        action :create
      end
    RUBY
  end

  it 'does not register on registry_key within an inspec control' do
    expect_no_offenses(<<~RUBY)
      control 'windows-cis-2.3.17.8' do
        impact 1.0
        title "2.3.17.8 Ensure 'User Account Control: Switch to the secure desktop when prompting for elevation' is set to 'Enabled'"
        desc "Ensure 'User Account Control: Switch to the secure desktop when prompting for elevation' is set to 'Enabled'"
        describe registry_key('HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
          its('PromptOnSecureDesktop') { should eq 1 }
        end
      end
    RUBY
  end

  it 'does not register when using a non-UAC registry key' do
    expect_no_offenses(<<~RUBY)
      registry_key 'HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\SomethingElse' do
          values [{ name: 'EnableLUA', type: :dword, data: 0 }]
          action :create
        end
    RUBY
  end

  it 'does not register when using values not supported in windows_uac' do
    expect_no_offenses(<<~RUBY)
      registry_key 'HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System' do
          values [{ name: 'EnableLUA', type: :dword, data: 0 }, { name: 'Foo', type: :dword, data: 0 }]
          action :create
        end
    RUBY
  end

  it 'does not register when the values property is a variable or method we cant parse' do
    expect_no_offenses(<<~RUBY)
      registry_key 'HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System' do
          values we_cant_parse_this
          action :create
        end
    RUBY
  end

  it 'does not register when the hash contains a variable or method we cant parse' do
    expect_no_offenses(<<~RUBY)
      registry_key 'HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System' do
        values [{ name: who_knows_what_this_is, type: :dword, data: 0 }, { name: 'Foo', type: :dword, data: 0 }]
          action :create
        end
    RUBY
  end

  context 'with TargetChefVersion set to 14' do
    let(:config) { target_chef_version(14) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        registry_key 'HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System' do
          values [{ name: 'EnableLUA', type: :dword, data: 0 }]
          action :create
        end
      RUBY
    end
  end
end
