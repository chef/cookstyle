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

describe RuboCop::Cop::Chef::Modernize::RespondToInMetadata, :config do
  subject(:cop) { described_class.new(config) }

  it "registers an offense when metadata includes the 'if respond_to?(:foo)' modifier" do
    expect_offense(<<~RUBY)
      chef_version '> 13' if respond_to?(:chef_version)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ It is no longer necessary to use respond_to? or defined? in metadata.rb in Chef Infra Client 12.15 and later
    RUBY

    expect_correction(<<~RUBY)
      chef_version '> 13'
    RUBY
  end

  it "registers an offense when metadata includes the 'if defined?(foo)' modifier" do
    expect_offense(<<~RUBY)
      chef_version '> 13' if defined?(chef_version)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ It is no longer necessary to use respond_to? or defined? in metadata.rb in Chef Infra Client 12.15 and later
    RUBY

    expect_correction(<<~RUBY)
      chef_version '> 13'
    RUBY
  end

  it "registers an offense when metadata includes the 'if defined?(foo)' as a multi-line conditional" do
    expect_offense(<<~RUBY)
      if defined?(chef_version)
      ^^^^^^^^^^^^^^^^^^^^^^^^^ It is no longer necessary to use respond_to? or defined? in metadata.rb in Chef Infra Client 12.15 and later
        chef_version '> 13'
      end
    RUBY

    expect_correction(<<~RUBY)
      chef_version '> 13'
    RUBY
  end

  it "registers an offense when metadata includes the 'unless defined?(Ridley::Chef::Cookbook::Metadata)' as a multi-line conditional" do
    expect_offense(<<~RUBY)
      unless defined?(Ridley::Chef::Cookbook::Metadata)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ It is no longer necessary to use respond_to? or defined? in metadata.rb in Chef Infra Client 12.15 and later
        source_url 'https://github.com/zpallin/cyclesafe_chef.git'
      end
    RUBY

    expect_correction(<<~RUBY)
      source_url 'https://github.com/zpallin/cyclesafe_chef.git'
    RUBY
  end

  it "doesn't register an offense when just calling the same method" do
    expect_no_offenses(<<~RUBY)
      chef_version '> 13'
    RUBY
  end

  context 'with TargetChefVersion set to 12.14' do
    let(:config) { target_chef_version(12.14) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        chef_version '> 13' if defined?(chef_version)
      RUBY
    end
  end
end
