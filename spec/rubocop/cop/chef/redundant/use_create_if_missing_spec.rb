# frozen_string_literal: true
#
# Copyright:: 2020-2022, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::RedundantCode::UseCreateIfMissing, :config do
  %w(cookbook_file file remote_directory cron_d remote_file template).each do |cb|
    it "registers an offense when #{cb} has a not_if that checks if the file exists" do
      expect_offense(<<~RUBY)
        #{cb} '/logs/foo/error.log' do
          source 'error.log'
          owner 'root'
          group 'root'
          mode '0644'
          not_if { ::File.exists?('/logs/foo/error.log') }
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the :create_if_missing action instead of not_if with a ::File.exist(FOO) check.
        end
      RUBY

      expect_correction(<<~RUBY)
        #{cb} '/logs/foo/error.log' do
          source 'error.log'
          owner 'root'
          group 'root'
          mode '0644'
          action :create_if_missing
        end
      RUBY
    end

    it "registers an offense when #{cb} has a path property and a not_if that checks if the file exists" do
      expect_offense(<<~RUBY)
        #{cb} 'Some file thing' do
          path '/logs/foo/error.log'
          source 'error.log'
          owner 'root'
          group 'root'
          mode '0644'
          not_if { ::File.exists?('/logs/foo/error.log') }
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the :create_if_missing action instead of not_if with a ::File.exist(FOO) check.
        end
      RUBY

      expect_correction(<<~RUBY)
        #{cb} 'Some file thing' do
          path '/logs/foo/error.log'
          source 'error.log'
          owner 'root'
          group 'root'
          mode '0644'
          action :create_if_missing
        end
      RUBY
    end
  end

  it 'registers an offense when the resource name is not a string but matches the not_if' do
    expect_offense(<<~RUBY)
      remote_file 'foo' + '/addons/war/alfresco.war' do
        owner 'root'
        group 'root'
        mode '0644'
        not_if { ::File.exist?('foo' + '/addons/war/alfresco.war') }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the :create_if_missing action instead of not_if with a ::File.exist(FOO) check.
      end
    RUBY

    expect_correction(<<~RUBY)
      remote_file 'foo' + '/addons/war/alfresco.war' do
        owner 'root'
        group 'root'
        mode '0644'
        action :create_if_missing
      end
    RUBY
  end

  it "doesn't register when a file like resource uses not_if to check for a *different* file" do
    expect_no_offenses(<<~RUBY)
      cookbook_file '/logs/foo/error.log' do
        source 'error.log'
        owner 'root'
        group 'root'
        mode '0644'
        not_if { ::File.exists?('/a/different/file.log') }
      end
    RUBY
  end

  it "doesn't register when a file like resource uses not_if to check for the file and the action is not :create" do
    expect_no_offenses(<<~RUBY)
      cookbook_file '/logs/foo/error.log' do
        source 'error.log'
        owner 'root'
        group 'root'
        mode '0644'
        action :remove
        not_if { ::File.exists?('/logs/foo/error.log') }
      end
    RUBY
  end

  it "doesn't register when a file like resource uses not_if without a ruby block" do
    expect_no_offenses(<<~RUBY)
      cookbook_file "#{'foo' + 'bar'}/baz" do
        source 'error.log'
        owner 'root'
        group 'root'
        mode '0644'
        action :remove
        not_if "test -f #{'foo' + 'bar'}/baz"
      end
    RUBY
  end
end
