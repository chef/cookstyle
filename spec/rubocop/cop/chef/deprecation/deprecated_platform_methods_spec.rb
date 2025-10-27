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

describe RuboCop::Cop::Chef::Deprecations::DeprecatedPlatformMethods, :config do
  it 'registers an offense when calling Chef::Platform.find_provider_for_node' do
    expect_offense(<<~RUBY)
      resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
      provider = Chef::Platform.find_provider_for_node(node, resource)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use provider_for_action or provides instead of the deprecated Chef::Platform methods in resources, which were removed in Chef Infra Client 13.
    RUBY
  end

  it 'registers an offense when calling Chef::Platform.find_provider' do
    expect_offense(<<~RUBY)
      resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
      provider = Chef::Platform.find_provider("ubuntu", "16.04", resource)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use provider_for_action or provides instead of the deprecated Chef::Platform methods in resources, which were removed in Chef Infra Client 13.
    RUBY
  end

  it 'registers an offense when calling Chef::Platform.provider_for_resource' do
    expect_offense(<<~RUBY)
      resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
      provider = Chef::Platform.provider_for_resource(resource, :create)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use provider_for_action or provides instead of the deprecated Chef::Platform methods in resources, which were removed in Chef Infra Client 13.
    RUBY
  end

  it 'registers an offense when calling Chef::Platform.set' do
    expect_offense(<<~RUBY)
      Chef::Platform.set :platform => :mac_os_x, :resource => :package, :provider => Chef::Provider::Package::Homebrew
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use provider_for_action or provides instead of the deprecated Chef::Platform methods in resources, which were removed in Chef Infra Client 13.
    RUBY
  end

  it 'does not register an offense with when calling other random Chef::Platform methods' do
    expect_no_offenses(<<~RUBY)
      Chef::Platform.foo
    RUBY
  end

  it 'does not register an offense with when calling #provider_for_action' do
    expect_no_offenses(<<~RUBY)
      resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
      provider = resource.provider_for_action(:create)
    RUBY
  end
end
