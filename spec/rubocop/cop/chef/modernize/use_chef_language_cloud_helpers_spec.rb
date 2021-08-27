# frozen_string_literal: true
#
# Copyright:: 2021, Chef Software, Inc.
# Author:: Tim Smith (<tsmith@chef.io>)
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

describe RuboCop::Cop::Chef::Modernize::UseChefLanguageCloudHelpers, :config do
  subject(:cop) { described_class.new(config) }

  it "registers an offense when using node['cloud']['provider'] == 'ec2' in a cookbook" do
    expect_offense(<<~RUBY)
      if node['cloud']['provider'] == 'ec2'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include cloud helpers to make detecting instances that run on public and private clouds easier.
        foo
      end
    RUBY

    expect_correction(<<~RUBY)
      if ec2?
        foo
      end
    RUBY
  end

  it "registers an offense when using node['cloud']['provider'] == 'azure' in a cookbook" do
    expect_offense(<<~RUBY)
      if node['cloud']['provider'] == 'azure'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include cloud helpers to make detecting instances that run on public and private clouds easier.
        foo
      end
    RUBY

    expect_correction(<<~RUBY)
      if azure?
        foo
      end
    RUBY
  end

  it "registers an offense when using node['cloud']['provider'] == 'softlayer' in a cookbook" do
    expect_offense(<<~RUBY)
      if node['cloud']['provider'] == 'softlayer'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include cloud helpers to make detecting instances that run on public and private clouds easier.
        foo
      end
    RUBY

    expect_correction(<<~RUBY)
      if softlayer?
        foo
      end
    RUBY
  end

  it "detect node['cloud'] if checked in conjunction with the cloud provider" do
    expect_offense(<<~RUBY)
      if node['cloud']['provider'] == 'digital_ocean'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include cloud helpers to make detecting instances that run on public and private clouds easier.
        foo
      end
    RUBY

    expect_correction(<<~RUBY)
      if digital_ocean?
        foo
      end
    RUBY
  end

  it "registers an offense when using node['cloud']['provider'] == 'digital_ocean' in a cookbook" do
    expect_offense(<<~RUBY)
      if node['cloud']['provider'] == 'digital_ocean'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include cloud helpers to make detecting instances that run on public and private clouds easier.
        foo
      end
    RUBY

    expect_correction(<<~RUBY)
      if digital_ocean?
        foo
      end
    RUBY
  end

  it "registers an offense when using node['cloud']['provider'] == 'openstack' in a cookbook" do
    expect_offense(<<~RUBY)
      if node['cloud']['provider'] == 'openstack'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include cloud helpers to make detecting instances that run on public and private clouds easier.
        foo
      end
    RUBY

    expect_correction(<<~RUBY)
      if openstack?
        foo
      end
    RUBY
  end

  it "registers an offense when using node['cloud']['provider'] == 'alibaba' in a cookbook" do
    expect_offense(<<~RUBY)
      if node['cloud']['provider'] == 'alibaba'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include cloud helpers to make detecting instances that run on public and private clouds easier.
        foo
      end
    RUBY

    expect_correction(<<~RUBY)
      if alibaba?
        foo
      end
    RUBY
  end

  it "registers an offense when using node['cloud']['provider'] == 'gce' in a cookbook" do
    expect_offense(<<~RUBY)
      if node['cloud']['provider'] == 'gce'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include cloud helpers to make detecting instances that run on public and private clouds easier.
        foo
      end
    RUBY

    expect_correction(<<~RUBY)
      if gce?
        foo
      end
    RUBY
  end

  it 'does not alert when not using a comparison with the provider data' do
    expect_no_offenses(<<~RUBY)
      if node['cloud']['provider']
        foo
      end
    RUBY
  end
end
