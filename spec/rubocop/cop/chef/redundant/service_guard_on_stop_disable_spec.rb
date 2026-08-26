# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# Author:: Tim Smith (<tsmith84@proton.me>)
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

describe RuboCop::Cop::Chef::RedundantCode::ServiceGuardOnStopDisable, :config do
  it 'registers an offense when a service that stops and disables guards on the rc.d script' do
    expect_offense(<<~RUBY)
      service 'snmpd' do
        action %i(stop disable)
        only_if { ::File.exist?('/usr/local/etc/rc.d/snmpd') }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A service resource that only stops or disables a service does not need a guard checking for the init script or unit file. Chef Infra Client already skips these actions when the service does not exist, and hardcoding a single path can silently skip services installed elsewhere.
      end
    RUBY

    expect_correction(<<~RUBY)
      service 'snmpd' do
        action %i(stop disable)
      end
    RUBY
  end

  it 'registers an offense when a service only stops and guards on the init.d script' do
    expect_offense(<<~RUBY)
      service 'apache2' do
        action :stop
        only_if { File.exist?('/etc/init.d/apache2') }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A service resource that only stops or disables a service does not need a guard checking for the init script or unit file. Chef Infra Client already skips these actions when the service does not exist, and hardcoding a single path can silently skip services installed elsewhere.
      end
    RUBY

    expect_correction(<<~RUBY)
      service 'apache2' do
        action :stop
      end
    RUBY
  end

  it 'registers an offense when a service only disables and guards on a systemd unit file' do
    expect_offense(<<~RUBY)
      service 'chronyd' do
        action :disable
        only_if { ::File.exist?('/usr/lib/systemd/system/chronyd.service') }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A service resource that only stops or disables a service does not need a guard checking for the init script or unit file. Chef Infra Client already skips these actions when the service does not exist, and hardcoding a single path can silently skip services installed elsewhere.
      end
    RUBY

    expect_correction(<<~RUBY)
      service 'chronyd' do
        action :disable
      end
    RUBY
  end

  it 'registers an offense with a not_if guard' do
    expect_offense(<<~RUBY)
      service 'snmpd' do
        action [:stop, :disable]
        not_if { ::File.exist?('/etc/rc.d/snmpd') }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A service resource that only stops or disables a service does not need a guard checking for the init script or unit file. Chef Infra Client already skips these actions when the service does not exist, and hardcoding a single path can silently skip services installed elsewhere.
      end
    RUBY

    expect_correction(<<~RUBY)
      service 'snmpd' do
        action [:stop, :disable]
      end
    RUBY
  end

  it 'registers an offense when the guarded path is interpolated' do
    expect_offense(<<~'RUBY')
      service 'snmpd' do
        action %i(stop disable)
        only_if { ::File.exist?("/etc/init.d/#{node['snmpd']['service_name']}") }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A service resource that only stops or disables a service does not need a guard checking for the init script or unit file. Chef Infra Client already skips these actions when the service does not exist, and hardcoding a single path can silently skip services installed elsewhere.
      end
    RUBY

    expect_correction(<<~'RUBY')
      service 'snmpd' do
        action %i(stop disable)
      end
    RUBY
  end

  it 'registers an offense when the guard uses ::File.exists? or ::File.executable?' do
    expect_offense(<<~RUBY)
      service 'snmpd' do
        action :stop
        only_if { ::File.exists?('/etc/init.d/snmpd') }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A service resource that only stops or disables a service does not need a guard checking for the init script or unit file. Chef Infra Client already skips these actions when the service does not exist, and hardcoding a single path can silently skip services installed elsewhere.
      end

      service 'sshd' do
        action :disable
        only_if { ::File.executable?('/usr/local/etc/rc.d/sshd') }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A service resource that only stops or disables a service does not need a guard checking for the init script or unit file. Chef Infra Client already skips these actions when the service does not exist, and hardcoding a single path can silently skip services installed elsewhere.
      end
    RUBY

    expect_correction(<<~RUBY)
      service 'snmpd' do
        action :stop
      end

      service 'sshd' do
        action :disable
      end
    RUBY
  end

  it 'removes only the guard and leaves the other properties alone' do
    expect_offense(<<~RUBY)
      service 'snmpd' do
        service_name 'snmpd'
        supports status: true
        action %i(stop disable)
        only_if { ::File.exist?('/usr/local/etc/rc.d/snmpd') }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ A service resource that only stops or disables a service does not need a guard checking for the init script or unit file. Chef Infra Client already skips these actions when the service does not exist, and hardcoding a single path can silently skip services installed elsewhere.
      end
    RUBY

    expect_correction(<<~RUBY)
      service 'snmpd' do
        service_name 'snmpd'
        supports status: true
        action %i(stop disable)
      end
    RUBY
  end

  it "doesn't register an offense when the actions include :start" do
    expect_no_offenses(<<~RUBY)
      service 'snmpd' do
        action %i(enable start)
        only_if { ::File.exist?('/usr/local/etc/rc.d/snmpd') }
      end
    RUBY
  end

  it "doesn't register an offense when the actions include :restart alongside :stop" do
    expect_no_offenses(<<~RUBY)
      service 'snmpd' do
        action %i(stop restart)
        only_if { ::File.exist?('/usr/local/etc/rc.d/snmpd') }
      end
    RUBY
  end

  it "doesn't register an offense on a systemd_unit resource" do
    expect_no_offenses(<<~RUBY)
      systemd_unit 'snmpd.service' do
        action %i(stop disable)
        only_if { ::File.exist?('/etc/systemd/system/snmpd.service') }
      end
    RUBY
  end

  it "doesn't register an offense when no action is specified" do
    expect_no_offenses(<<~RUBY)
      service 'snmpd' do
        only_if { ::File.exist?('/usr/local/etc/rc.d/snmpd') }
      end
    RUBY
  end

  it "doesn't register an offense when the guard checks something other than an init script" do
    expect_no_offenses(<<~RUBY)
      service 'snmpd' do
        action %i(stop disable)
        only_if { ::File.exist?('/etc/snmp/snmpd.conf') }
      end
    RUBY
  end

  it "doesn't register an offense when the guard is a shell command" do
    expect_no_offenses(<<~RUBY)
      service 'snmpd' do
        action %i(stop disable)
        only_if 'test -f /usr/local/etc/rc.d/snmpd'
      end
    RUBY
  end

  it "doesn't register an offense when the guard does more than check for the init script" do
    expect_no_offenses(<<~RUBY)
      service 'snmpd' do
        action %i(stop disable)
        only_if do
          ::File.exist?('/usr/local/etc/rc.d/snmpd') && node['snmpd']['manage']
        end
      end
    RUBY
  end

  it "doesn't register an offense when the guard checks the service with a shell_out" do
    expect_no_offenses(<<~RUBY)
      service 'snmpd' do
        action %i(stop disable)
        only_if { shell_out('service snmpd status').exitstatus == 0 }
      end
    RUBY
  end
end
