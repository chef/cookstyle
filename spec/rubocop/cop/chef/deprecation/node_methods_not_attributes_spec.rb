#
# Copyright:: Copyright 2019, Chef Software Inc.
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

describe RuboCop::Cop::Chef::NodeMethodsInsteadofAttributes, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using node.platform', :config do
    expect_offense(<<~RUBY)
      node.platform
           ^^^^^^^^ Use node attributes to access Ohai data instead of node methods, which were deprecated in Chef Infra Client 13.
    RUBY

    expect_correction(<<~RUBY)
    node['platform']
    RUBY
  end

  it 'registers an offense when using node.platform_family', :config do
    expect_offense(<<~RUBY)
      node.platform_family
           ^^^^^^^^^^^^^^^ Use node attributes to access Ohai data instead of node methods, which were deprecated in Chef Infra Client 13.
    RUBY

    expect_correction(<<~RUBY)
    node['platform_family']
    RUBY
  end

  it 'registers an offense when using node.platform_version', :config do
    expect_offense(<<~RUBY)
      node.platform_version
           ^^^^^^^^^^^^^^^^ Use node attributes to access Ohai data instead of node methods, which were deprecated in Chef Infra Client 13.
    RUBY

    expect_correction(<<~RUBY)
    node['platform_version']
    RUBY
  end

  it 'registers an offense when using node.fqdn', :config do
    expect_offense(<<~RUBY)
      node.fqdn
           ^^^^ Use node attributes to access Ohai data instead of node methods, which were deprecated in Chef Infra Client 13.
    RUBY

    expect_correction(<<~RUBY)
    node['fqdn']
    RUBY
  end

  it 'registers an offense when using node.hostname', :config do
    expect_offense(<<~RUBY)
      node.hostname
           ^^^^^^^^ Use node attributes to access Ohai data instead of node methods, which were deprecated in Chef Infra Client 13.
    RUBY

    expect_correction(<<~RUBY)
    node['hostname']
    RUBY
  end
end
