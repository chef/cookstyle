# frozen_string_literal: true
#
# Copyright:: 2026, Chef Software Inc.
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

describe RuboCop::Cop::Chef::Correctness::ExecuteWithoutTimeout, :config do
  it 'registers an offense when execute has no timeout' do
    expect_offense(<<~RUBY)
      execute 'run_script' do
      ^^^^^^^^^^^^^^^^^^^^^^^ Add a timeout to execute resources to avoid hanging commands.
        command 'sleep 100'
      end
    RUBY
  end

  it 'does not register an offense when timeout is present' do
    expect_no_offenses(<<~RUBY)
      execute 'run_script' do
        command 'sleep 100'
        timeout 30
      end
    RUBY
  end

  it 'does not register an offense when timeout is present with other properties' do
    expect_no_offenses(<<~RUBY)
      execute 'install_package' do
        command 'apt-get install -y package'
        
        notifies :restart, 'service[myservice]'
      end
    RUBY
  end

  it 'registers an offense for execute without timeout and multiple properties' do
    expect_offense(<<~RUBY)
      execute 'run_command' do
      ^^^^^^^^^^^^^^^^^^^^^^^^ Add a timeout to execute resources to avoid hanging commands.
        command 'long_running_script.sh'
        user 'root'
        group 'root'
      end
    RUBY
  end
end
