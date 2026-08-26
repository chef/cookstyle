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

describe RuboCop::Cop::Chef::Correctness::ChefApplicationFatal, :config do
  it 'registers an offense when Chef::Application.fatal! is called' do
    expect_offense(<<~RUBY)
      Chef::Application.fatal!('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use raise to force Chef Infra Client to fail instead of using Chef::Application.fatal
    RUBY

    expect_correction(<<~RUBY)
      raise('foo')
    RUBY
  end

  it 'registers an offense when ::Chef::Application.fatal! is called' do
    expect_offense(<<~RUBY)
      ::Chef::Application.fatal!('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use raise to force Chef Infra Client to fail instead of using Chef::Application.fatal
    RUBY

    expect_correction(<<~RUBY)
      raise('foo')
    RUBY
  end

  it 'registers an offense when Chef::Application.fatal! is called with an exit code' do
    expect_offense(<<~RUBY)
      Chef::Application.fatal!('foo', 1)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use raise to force Chef Infra Client to fail instead of using Chef::Application.fatal
    RUBY

    expect_no_corrections
  end

  it 'registers an offense when ::Chef::Application.fatal! is called with an exit code' do
    expect_offense(<<~'RUBY')
      ::Chef::Application.fatal!("Unable to configure #{node['foo']['bar']}", 2)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use raise to force Chef Infra Client to fail instead of using Chef::Application.fatal
    RUBY

    expect_no_corrections
  end

  it 'registers an offense when Chef::Application.fatal! is called without any arguments' do
    expect_offense(<<~RUBY)
      Chef::Application.fatal!
      ^^^^^^^^^^^^^^^^^^^^^^^^ Use raise to force Chef Infra Client to fail instead of using Chef::Application.fatal
    RUBY

    expect_no_corrections
  end

  it "doesn't register an offense when fatal! is called on another class" do
    expect_no_offenses(<<~RUBY)
      MyApp::Application.fatal!('foo', 1)
    RUBY
  end

  it "doesn't register an offense when Chef::Log.fatal is called" do
    expect_no_offenses(<<~RUBY)
      Chef::Log.fatal('foo')
    RUBY
  end
end
