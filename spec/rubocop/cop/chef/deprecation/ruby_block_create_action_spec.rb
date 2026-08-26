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

describe RuboCop::Cop::Chef::Deprecations::RubyBlockCreateAction, :config do
  it 'registers an offense when ruby_block uses the :create action' do
    expect_offense(<<~RUBY)
      ruby_block 'my special ruby block' do
        block do
          puts 'running'
        end
        action :create
               ^^^^^^^ Use the :run action in the ruby_block resource instead of the deprecated :create action
      end
    RUBY

    expect_correction(<<~RUBY)
      ruby_block 'my special ruby block' do
        block do
          puts 'running'
        end
        action :run
      end
    RUBY
  end

  it "doesn't register an offense when ruby_block uses the :run action" do
    expect_no_offenses(<<~RUBY)
      ruby_block 'my special ruby block' do
        block do
          puts 'running'
        end
        action :run
      end
    RUBY
  end

  it 'registers an offense when a notification uses the :create action on a ruby_block' do
    expect_offense(<<~RUBY)
      template '/etc/foo.conf' do
        source 'foo.conf.erb'
        notifies :create, 'ruby_block[foo]', :immediately
                 ^^^^^^^ Use the :run action in the ruby_block resource instead of the deprecated :create action
      end
    RUBY

    expect_correction(<<~RUBY)
      template '/etc/foo.conf' do
        source 'foo.conf.erb'
        notifies :run, 'ruby_block[foo]', :immediately
      end
    RUBY
  end

  it 'registers an offense when a notification omits the timing' do
    expect_offense(<<~RUBY)
      template '/etc/foo.conf' do
        notifies :create, 'ruby_block[foo]'
                 ^^^^^^^ Use the :run action in the ruby_block resource instead of the deprecated :create action
      end
    RUBY

    expect_correction(<<~RUBY)
      template '/etc/foo.conf' do
        notifies :run, 'ruby_block[foo]'
      end
    RUBY
  end

  it 'registers an offense when a subscription uses the :create action on a ruby_block' do
    expect_offense(<<~RUBY)
      template '/etc/foo.conf' do
        subscribes :create, 'ruby_block[foo]', :immediately
                   ^^^^^^^ Use the :run action in the ruby_block resource instead of the deprecated :create action
      end
    RUBY

    expect_correction(<<~RUBY)
      template '/etc/foo.conf' do
        subscribes :run, 'ruby_block[foo]', :immediately
      end
    RUBY
  end

  it 'registers an offense when the notified ruby_block name is interpolated' do
    expect_offense(<<~'RUBY')
      template '/etc/foo.conf' do
        notifies :create, "ruby_block[#{node['foo']['name']}]", :delayed
                 ^^^^^^^ Use the :run action in the ruby_block resource instead of the deprecated :create action
      end
    RUBY

    expect_correction(<<~'RUBY')
      template '/etc/foo.conf' do
        notifies :run, "ruby_block[#{node['foo']['name']}]", :delayed
      end
    RUBY
  end

  it "doesn't register an offense when a notification uses :create on another resource" do
    expect_no_offenses(<<~RUBY)
      template '/etc/foo.conf' do
        notifies :create, 'template[/etc/bar.conf]', :immediately
      end
    RUBY
  end

  it "doesn't register an offense when a notification uses :run on a ruby_block" do
    expect_no_offenses(<<~RUBY)
      template '/etc/foo.conf' do
        notifies :run, 'ruby_block[foo]', :immediately
      end
    RUBY
  end

  it "doesn't register an offense when the notified resource type is interpolated" do
    expect_no_offenses(<<~'RUBY')
      template '/etc/foo.conf' do
        notifies :create, "#{node['foo']['type']}[bar]", :immediately
      end
    RUBY
  end

  it 'registers an offense when ruby_block uses :create in a %i array' do
    expect_offense(<<~RUBY)
      ruby_block 'a' do
        action %i(create)
                  ^^^^^^ Use the :run action in the ruby_block resource instead of the deprecated :create action
      end
    RUBY

    expect_correction(<<~RUBY)
      ruby_block 'a' do
        action %i(run)
      end
    RUBY
  end

  it 'registers an offense when ruby_block uses :create in a bracketed array' do
    expect_offense(<<~RUBY)
      ruby_block 'a' do
        action [:create, :nothing]
                ^^^^^^^ Use the :run action in the ruby_block resource instead of the deprecated :create action
      end
    RUBY

    expect_correction(<<~RUBY)
      ruby_block 'a' do
        action [:run, :nothing]
      end
    RUBY
  end
end
