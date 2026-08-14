# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

describe RuboCop::Cop::Chef::Modernize::ExecuteArchiveExtract, :config do
  it 'registers an offense when an execute resource untars an archive' do
    expect_offense(<<~RUBY)
      execute 'extract archive' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of shelling out to tar or unzip
        command 'tar xzf /tmp/foo.tar.gz -C /opt/foo'
      end
    RUBY
  end

  it 'registers an offense when an execute resource unzips an archive' do
    expect_offense(<<~RUBY)
      execute 'extract archive' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of shelling out to tar or unzip
        command 'unzip -o /tmp/foo.zip -d /opt/foo'
      end
    RUBY
  end

  it 'registers an offense when the command is the execute resource name' do
    expect_offense(<<~RUBY)
      execute 'tar xzf /tmp/foo.tar.gz -C /opt/foo'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of shelling out to tar or unzip
    RUBY
  end

  it 'registers an offense when a bash resource untars an archive' do
    expect_offense(<<~RUBY)
      bash 'extract archive' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of shelling out to tar or unzip
        code 'tar --extract --file /tmp/foo.tar'
      end
    RUBY
  end

  it 'registers an offense when a script resource untars an archive' do
    expect_offense(<<~RUBY)
      script 'extract archive' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of shelling out to tar or unzip
        interpreter 'bash'
        code 'tar xzf /tmp/foo.tar.gz'
      end
    RUBY
  end

  it 'registers an offense when a zsh resource untars an archive' do
    expect_offense(<<~RUBY)
      zsh 'extract archive' do
      ^^^^^^^^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of shelling out to tar or unzip
        code 'tar xzf /tmp/foo.tar.gz'
      end
    RUBY
  end

  it 'registers an offense when the tar command is interpolated' do
    expect_offense(<<~'RUBY')
      execute 'extract archive' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of shelling out to tar or unzip
        command "tar xzf #{node['foo']['tarball']}"
      end
    RUBY
  end

  it "doesn't register an offense when tar creates an archive" do
    expect_no_offenses(<<~RUBY)
      execute 'create archive' do
        command 'tar czf /tmp/foo.tar.gz /opt/foo'
      end
    RUBY
  end

  it "doesn't register an offense when tar lists an archive" do
    expect_no_offenses(<<~RUBY)
      execute 'list archive' do
        command 'tar tzf /tmp/foo.tar.gz'
      end
    RUBY
  end

  it "doesn't register an offense when the extraction is part of a larger shell command" do
    expect_no_offenses(<<~RUBY)
      execute 'extract and build' do
        command 'tar xzf /tmp/foo.tar.gz && cd foo && make install'
      end
    RUBY
  end

  it "doesn't register an offense when a long option merely contains an x" do
    expect_no_offenses(<<~RUBY)
      execute 'create archive' do
        command 'tar --exclude=.git -czf /tmp/foo.tar.gz /opt/foo'
      end
    RUBY
  end

  it "doesn't register an offense when using an unrelated command" do
    expect_no_offenses(<<~RUBY)
      execute 'do a thing' do
        command 'systemctl daemon-reload'
      end
    RUBY
  end

  it "doesn't register an offense when already using archive_file" do
    expect_no_offenses(<<~RUBY)
      archive_file 'extract archive' do
        path '/tmp/foo.tar.gz'
        destination '/opt/foo'
      end
    RUBY
  end

  context 'with TargetChefVersion set to 14' do
    let(:config) { target_chef_version(14) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        execute 'extract archive' do
          command 'tar xzf /tmp/foo.tar.gz -C /opt/foo'
        end
      RUBY
    end
  end
end
