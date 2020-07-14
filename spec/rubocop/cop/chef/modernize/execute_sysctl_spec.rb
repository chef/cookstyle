# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefModernize::ExecuteSysctl, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when loading a sysctl config with an execute resource' do
    expect_offense(<<~RUBY)
      execute 'sysctl -p /etc/sysctl.d/ipv6.conf' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 14.0 and later includes a sysctl resource that should be used to idempotently load sysctl values instead of templating files and using execute to load them.
        action :run
      end
    RUBY
  end

  it 'registers an offense when loading a sysctl config with an execute resource with a command property' do
    expect_offense(<<~RUBY)
      execute 'Set IPV6 sysctl vals' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 14.0 and later includes a sysctl resource that should be used to idempotently load sysctl values instead of templating files and using execute to load them.
        command 'sysctl -p /etc/sysctl.d/ipv6.conf'
        action :run
      end
    RUBY
  end

  it 'registers an offense when loading a sysctl config with an execute resource with a command property using /sbin/sysctl' do
    expect_offense(<<~RUBY)
      execute 'Set IPV6 sysctl vals' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 14.0 and later includes a sysctl resource that should be used to idempotently load sysctl values instead of templating files and using execute to load them.
        command '/sbin/sysctl -p /etc/sysctl.d/ipv6.conf'
        action :run
      end
    RUBY
  end

  it "doesn't register an offense when using the sysctl resource" do
    expect_no_offenses(<<~RUBY)
      sysctl 'net.ipv4.ip_local_port_range' do
        value '9000 65500'
      end
    RUBY
  end
end
