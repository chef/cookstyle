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

describe RuboCop::Cop::Chef::Deprecations::DeprecatedChefSpecPlatform, :config do
  it "registers an offense when spec calls for Ubuntu 14.04, but doesn't autocorrect" do
    expect_offense(<<~RUBY)
      let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') }
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use currently supported platforms in ChefSpec listed at https://github.com/chef/fauxhai/blob/main/PLATFORMS.md. Fauxhai / ChefSpec will perform fuzzy matching on platform version so it's always best to be less specific i.e. 10 instead of 10.3
    RUBY

    expect_no_corrections
  end

  it 'registers an offense when spec calls for CentOS 7.1 and autocorrects to CentOS 7' do
    expect_offense(<<~RUBY)
      let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'centos', version: '7.1') }
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use currently supported platforms in ChefSpec listed at https://github.com/chef/fauxhai/blob/main/PLATFORMS.md. Fauxhai / ChefSpec will perform fuzzy matching on platform version so it's always best to be less specific i.e. 10 instead of 10.3
    RUBY

    expect_correction("let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'centos', version: '7') }\n")
  end

  it 'registers an offense when using ChefSpec::SoloRunner as well' do
    expect_offense(<<~RUBY)
      let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.1') }
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use currently supported platforms in ChefSpec listed at https://github.com/chef/fauxhai/blob/main/PLATFORMS.md. Fauxhai / ChefSpec will perform fuzzy matching on platform version so it's always best to be less specific i.e. 10 instead of 10.3
    RUBY

    expect_correction("let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7') }\n")
  end

  it "doesn't register a major version as being the .0 point release and alert" do
    expect_no_offenses(<<~RUBY)
      let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'centos', version: '7') }
    RUBY
  end

  it "doesn't register an offense with a modern platform" do
    expect_no_offenses(<<~RUBY)
      let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'centos', version: '200') }
    RUBY
  end

  it "registers an offense when spec calls for Amazon 2018.03, but doesn't autocorrect" do
    expect_offense(<<~RUBY)
      let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'amazon', version: '2018.03') }
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use currently supported platforms in ChefSpec listed at https://github.com/chef/fauxhai/blob/main/PLATFORMS.md. Fauxhai / ChefSpec will perform fuzzy matching on platform version so it's always best to be less specific i.e. 10 instead of 10.3
    RUBY

    expect_no_corrections
  end

  it "doesn't register an offense with Amazon Linux 2022" do
    expect_no_offenses(<<~RUBY)
      let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'amazon', version: '2002') }
    RUBY
  end
end
