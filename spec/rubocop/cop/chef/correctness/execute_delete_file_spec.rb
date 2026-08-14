# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

describe RuboCop::Cop::Chef::Correctness::ExecuteDeleteFile, :config do
  it 'registers an offense when execute uses a command property to rm a path' do
    expect_offense(<<~RUBY)
      execute 'delete the thing' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `file` or `directory` resources built into Chef Infra Client with the :delete action to remove files/directories instead of shelling out to rm
        command 'rm -rf /opt/thing'
      end
    RUBY
  end

  it 'registers an offense when the execute resource name is the rm command' do
    expect_offense(<<~RUBY)
      execute 'rm -rf /opt/thing'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `file` or `directory` resources built into Chef Infra Client with the :delete action to remove files/directories instead of shelling out to rm
    RUBY
  end

  it 'registers an offense for a bare rm without flags' do
    expect_offense(<<~RUBY)
      execute 'rm /etc/foo.conf'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `file` or `directory` resources built into Chef Infra Client with the :delete action to remove files/directories instead of shelling out to rm
    RUBY
  end

  it 'registers an offense when a bash resource rms a path' do
    expect_offense(<<~RUBY)
      bash 'delete the thing' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `file` or `directory` resources built into Chef Infra Client with the :delete action to remove files/directories instead of shelling out to rm
        code 'rm -rf /opt/thing'
      end
    RUBY
  end

  it 'registers an offense for an absolute path to rm' do
    expect_offense(<<~RUBY)
      execute '/bin/rm -f /etc/foo.conf'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `file` or `directory` resources built into Chef Infra Client with the :delete action to remove files/directories instead of shelling out to rm
    RUBY
  end

  it "doesn't register an offense when the command uses a glob" do
    expect_no_offenses(<<~RUBY)
      execute 'delete the things' do
        command 'rm -rf /opt/thing/*'
      end
    RUBY
  end

  it "doesn't register an offense when the command chains other work" do
    expect_no_offenses(<<~RUBY)
      execute 'delete and rebuild' do
        command 'rm -rf /opt/thing && make install'
      end
    RUBY
  end

  it "doesn't register an offense when the command pipes into rm" do
    expect_no_offenses(<<~RUBY)
      execute 'delete the things' do
        command 'find /opt -name "*.tmp" | xargs rm -f'
      end
    RUBY
  end

  it "doesn't register an offense for an unrelated command" do
    expect_no_offenses(<<~RUBY)
      execute 'build the thing' do
        command 'make install'
      end
    RUBY
  end

  it "doesn't register an offense when the file resource is already used" do
    expect_no_offenses(<<~RUBY)
      directory '/opt/thing' do
        recursive true
        action :delete
      end
    RUBY
  end

  it "doesn't register an offense when the target uses shell command substitution" do
    expect_no_offenses(<<~'RUBY')
      execute 'delete the thing' do
        command 'rm -rf $(cat /tmp/target)'
      end
    RUBY
  end

  it "doesn't register an offense when the target uses backticks" do
    expect_no_offenses(<<~'RUBY')
      execute 'delete the thing' do
        command 'rm -rf `cat /tmp/target`'
      end
    RUBY
  end

  it "doesn't register an offense when the target is a shell variable" do
    expect_no_offenses(<<~'RUBY')
      execute 'delete the thing' do
        command 'rm -rf ${TARGET}'
      end
    RUBY
  end
end
