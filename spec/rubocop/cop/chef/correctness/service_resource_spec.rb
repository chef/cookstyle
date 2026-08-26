# frozen_string_literal: true
#
# Copyright:: 2016, Chris Henry
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

describe RuboCop::Cop::Chef::Correctness::ServiceResource, :config do
  it 'registers an offense when starting a service in execute resource' do
    expect_offense(<<~RUBY)
      execute 'apache_start' do
        command '/etc/init.d/httpd start'
                ^^^^^^^^^^^^^^^^^^^^^^^^^ Use the service resource to manage services instead of shelling out to an init script, service, systemctl, or a similar tool
      end
    RUBY
  end

  [
    'service httpd start',
    '/sbin/service httpd restart',
    'systemctl restart httpd',
    'systemctl enable httpd',
    'systemctl --now enable httpd',
    'invoke-rc.d httpd reload',
    'initctl start httpd',
    'svcadm enable httpd',
    '/etc/rc.d/httpd start',
    'chkconfig httpd on',
    'update-rc.d httpd defaults',
    'launchctl load /Library/LaunchDaemons/foo.plist',
    'start httpd',
    'stop httpd',
    'net start httpd',
    'sc stop httpd',
  ].each do |command|
    it "registers an offense for the command #{command}" do
      carets = '^' * (command.length + 2) # the offense covers the quoted string
      expect_offense(<<~RUBY)
        execute 'manage the service' do
          command '#{command}'
                  #{carets} Use the service resource to manage services instead of shelling out to an init script, service, systemctl, or a similar tool
        end
      RUBY
    end
  end

  it 'registers an offense when the execute resource name is the service command' do
    expect_offense(<<~RUBY)
      execute 'systemctl restart httpd'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the service resource to manage services instead of shelling out to an init script, service, systemctl, or a similar tool
    RUBY
  end

  it 'registers an offense when a bash resource manages a service' do
    expect_offense(<<~RUBY)
      bash 'restart the service' do
        code 'systemctl restart httpd'
             ^^^^^^^^^^^^^^^^^^^^^^^^^ Use the service resource to manage services instead of shelling out to an init script, service, systemctl, or a similar tool
      end
    RUBY
  end

  it 'does not register an offense when running a normal command' do
    expect_no_offenses(<<~RUBY)
      execute 'apache_start' do
        command 'echo "not starting a service"'
      end
    RUBY
  end

  it 'does not register an offense for a systemctl status check' do
    expect_no_offenses(<<~RUBY)
      execute 'check the service' do
        command 'systemctl status httpd'
      end
    RUBY
  end

  it 'does not register an offense for systemctl daemon-reload' do
    expect_no_offenses(<<~RUBY)
      execute 'reload systemd' do
        command 'systemctl daemon-reload'
      end
    RUBY
  end

  it 'does not register an offense when the command does more than manage the service' do
    expect_no_offenses(<<~RUBY)
      execute 'restart and log' do
        command 'systemctl restart httpd && echo restarted'
      end
    RUBY
  end

  it 'does not register an offense for a script whose name merely starts with start' do
    expect_no_offenses(<<~RUBY)
      execute 'run the installer' do
        command 'start_my_app.sh'
      end
    RUBY
  end

  it 'does not register an offense for an unrelated binary under /usr/sbin' do
    expect_no_offenses(<<~RUBY)
      execute 'run the thing' do
        command '/usr/sbin/servicelike-tool --flag'
      end
    RUBY
  end
end
