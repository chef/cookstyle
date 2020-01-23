#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefDeprecations::DeprecatedChefSpecPlatform, :config do
  subject(:cop) { described_class.new(config) }

  it "registers an offense when spec calls for Ubuntu 14.04, but doesn't autocorrect" do
    expect_offense(<<~RUBY)
      let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') }
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use currently supported platforms in ChefSpec listed at https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md. Fauxhai / ChefSpec will perform fuzzy matching on platform version so it's always best to be less specific ie. 10 instead of 10.3
    RUBY

    expect_correction("let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') }\n")
  end

  it 'registers an offense when spec calls for CentOS 7.1 and autocorrects to CentOS 7' do
    expect_offense(<<~RUBY)
      let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'centos', version: '7.1') }
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use currently supported platforms in ChefSpec listed at https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md. Fauxhai / ChefSpec will perform fuzzy matching on platform version so it's always best to be less specific ie. 10 instead of 10.3
    RUBY

    expect_correction("let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'centos', version: '7') }\n")
  end

  it 'registers an offense when using ChefSpec::SoloRunner as well' do
    expect_offense(<<~RUBY)
      let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.1') }
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use currently supported platforms in ChefSpec listed at https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md. Fauxhai / ChefSpec will perform fuzzy matching on platform version so it's always best to be less specific ie. 10 instead of 10.3
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
end
