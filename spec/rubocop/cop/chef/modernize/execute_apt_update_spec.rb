# frozen_string_literal: true
#
# Copyright:: 2019-2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Modernize::ExecuteAptUpdate, :config do
  it 'registers an offense when using execute to run apt-get update' do
    expect_offense(<<~RUBY)
      execute 'apt-get update' do
      ^^^^^^^^^^^^^^^^^^^^^^^^ Use the apt_update resource instead of the execute resource to run an apt-get update package cache update
        action :nothing
      end
    RUBY
  end

  it 'registers an offense when using execute to run apt-get update -y' do
    expect_offense(<<~RUBY)
      execute 'apt-get update -y' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the apt_update resource instead of the execute resource to run an apt-get update package cache update
        action :nothing
      end
    RUBY
  end

  it 'registers an offense when using execute to run apt-get -y update' do
    expect_offense(<<~RUBY)
      execute 'apt-get -y update' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the apt_update resource instead of the execute resource to run an apt-get update package cache update
        action :nothing
      end
    RUBY
  end

  it "registers an offense when a resource notifies 'execute[apt-get update]'" do
    expect_offense(<<~RUBY)
      execute 'some execute resource' do
        notifies :run, 'execute[apt-get update]', :immediately
                       ^^^^^^^^^^^^^^^^^^^^^^^^^ Use the apt_update resource instead of the execute resource to run an apt-get update package cache update
      end
    RUBY
  end

  it "registers an offense when an execute resource's command property run's apt-get update" do
    expect_offense(<<~RUBY)
      execute 'some execute resource' do
        command 'apt-get update'
        ^^^^^^^^^^^^^^^^^^^^^^^^ Use the apt_update resource instead of the execute resource to run an apt-get update package cache update
      end
    RUBY
  end

  it "doesn't register an offense when running another command in an execute resource" do
    expect_no_offenses(<<~RUBY)
      execute 'foo' do
        command 'bar'
      end
    RUBY
  end

  it "doesn't register an offense when a resource notifies any old resource" do
    expect_no_offenses(<<~RUBY)
      execute 'some execute resource' do
        notifies :run, 'execute[foo]', :immediately
      end
    RUBY
  end
end
