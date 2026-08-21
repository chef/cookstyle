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

describe RuboCop::Cop::Chef::Modernize::ExecuteUpdateAlternatives, :config do
  it 'registers an offense when execute uses a command property to install an alternative' do
    expect_offense(<<~RUBY)
      execute 'install java alternative' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 16.0 and later includes an alternatives resource that should be used to manage alternatives links instead of shelling out to update-alternatives or alternatives
        command 'update-alternatives --install /usr/bin/java java /usr/lib/jvm/jre-11/bin/java 1'
      end
    RUBY
  end

  it 'registers an offense when the execute resource name is the alternatives command' do
    expect_offense(<<~RUBY)
      execute 'alternatives --set java /usr/lib/jvm/jre-11/bin/java'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 16.0 and later includes an alternatives resource that should be used to manage alternatives links instead of shelling out to update-alternatives or alternatives
    RUBY
  end

  it 'registers an offense for the RHEL alternatives command' do
    expect_offense(<<~RUBY)
      execute 'set the java alternative' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 16.0 and later includes an alternatives resource that should be used to manage alternatives links instead of shelling out to update-alternatives or alternatives
        command 'alternatives --auto java'
      end
    RUBY
  end

  it 'registers an offense for an absolute path to the binary' do
    expect_offense(<<~RUBY)
      execute 'remove the java alternative' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 16.0 and later includes an alternatives resource that should be used to manage alternatives links instead of shelling out to update-alternatives or alternatives
        command '/usr/sbin/update-alternatives --remove java /usr/lib/jvm/jre-11/bin/java'
      end
    RUBY
  end

  it 'registers an offense when a bash resource manages alternatives' do
    expect_offense(<<~RUBY)
      bash 'install java alternative' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 16.0 and later includes an alternatives resource that should be used to manage alternatives links instead of shelling out to update-alternatives or alternatives
        code 'update-alternatives --install /usr/bin/java java /usr/lib/jvm/jre-11/bin/java 1'
      end
    RUBY
  end

  it "doesn't register an offense for a read only alternatives query" do
    expect_no_offenses(<<~RUBY)
      execute 'check the java alternative' do
        command 'update-alternatives --display java'
      end
    RUBY
  end

  it "doesn't register an offense for the interactive config subcommand" do
    expect_no_offenses(<<~RUBY)
      execute 'configure the java alternative' do
        command 'update-alternatives --config java'
      end
    RUBY
  end

  it "doesn't register an offense for --remove-all, which the resource cannot express" do
    expect_no_offenses(<<~RUBY)
      execute 'remove all java alternatives' do
        command 'update-alternatives --remove-all java'
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

  it "doesn't register an offense for a script that merely contains the word alternatives" do
    expect_no_offenses(<<~RUBY)
      execute 'run the helper' do
        command '/opt/scripts/list-alternatives.sh --install'
      end
    RUBY
  end

  it "doesn't register an offense when the alternatives resource is already used" do
    expect_no_offenses(<<~RUBY)
      alternatives 'java' do
        link '/usr/bin/java'
        path '/usr/lib/jvm/jre-11/bin/java'
        priority 1
        action :install
      end
    RUBY
  end

  context 'with TargetChefVersion set to 15' do
    let(:config) { target_chef_version(15) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        execute 'install java alternative' do
          command 'update-alternatives --install /usr/bin/java java /usr/lib/jvm/jre-11/bin/java 1'
        end
      RUBY
    end
  end
end
