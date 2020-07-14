# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefDeprecations::ChefHandlerUsesSupports, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when chef_handler uses the supports property' do
    expect_offense(<<~RUBY)
    chef_handler 'Chef::Handler::ZookeeperHandler' do
      supports start: true, report: true, exception: true
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the type property instead of the deprecated supports property in the chef_handler resource. The supports property was removed in chef_handler cookbook version 3.0 (June 2017) and Chef Infra Client 14.0.
    end
    RUBY

    expect_correction(<<~RUBY)
    chef_handler 'Chef::Handler::ZookeeperHandler' do
      type start: true, report: true, exception: true
    end
    RUBY
  end

  it 'properly autocorrects when chef_handler uses supports(FOO)' do
    expect_offense(<<~RUBY)
    chef_handler 'Chef::Handler::ZookeeperHandler' do
      supports({:exception => true})
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the type property instead of the deprecated supports property in the chef_handler resource. The supports property was removed in chef_handler cookbook version 3.0 (June 2017) and Chef Infra Client 14.0.
    end
    RUBY

    expect_correction(<<~RUBY)
    chef_handler 'Chef::Handler::ZookeeperHandler' do
      type :exception => true
    end
    RUBY
  end

  it "doesn't register an offense when chef_handler uses the type action" do
    expect_no_offenses(<<~RUBY)
    chef_handler 'Chef::Handler::ZookeeperHandler' do
      type start: true, report: true, exception: true
    end
    RUBY
  end
end
