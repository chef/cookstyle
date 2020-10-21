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

describe RuboCop::Cop::Chef::Modernize::ChefGemNokogiri, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense with a non-block chef_gem nokogiri install' do
    expect_offense(<<~RUBY)
      chef_gem 'nokogiri'
      ^^^^^^^^^^^^^^^^^^^ The nokogiri gem ships in Chef Infra Client 12+ and does not need to be installed before being used.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense with a block form chef_gem nokogiri install' do
    expect_offense(<<~RUBY)
      chef_gem 'nokogiri' do
      ^^^^^^^^^^^^^^^^^^^ The nokogiri gem ships in Chef Infra Client 12+ and does not need to be installed before being used.
        compile_time true
      end
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense with chef_gem installing nokogiri with the package_name property' do
    expect_offense(<<~RUBY)
      chef_gem 'Install nokogiri gem' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The nokogiri gem ships in Chef Infra Client 12+ and does not need to be installed before being used.
        package_name 'nokogiri'
      end
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense on a non-rewind chef_gem install" do
    expect_no_offenses(<<~RUBY)
      chef_gem 'aws-sdk'
    RUBY
  end
end
