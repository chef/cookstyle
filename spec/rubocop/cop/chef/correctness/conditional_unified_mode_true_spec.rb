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

describe RuboCop::Cop::Chef::Correctness::ConditionalUnifiedModeTrue, :config do
  it 'registers an offense when unified_mode true is guarded with respond_to?' do
    expect_offense(<<~RUBY)
      unified_mode true if respond_to?(:unified_mode)
      ^^^^^^^^^^^^^^^^^ Set `unified_mode true` unconditionally. Making it conditional gives you unified mode on newer Chef Infra Client releases and legacy mode on older ones, so the resource has to be tested and reasoned about both ways.
    RUBY

    expect_correction(<<~RUBY)
      unified_mode true
    RUBY
  end

  it 'registers an offense when unified_mode true is guarded with a multi-line if' do
    expect_offense(<<~RUBY)
      if respond_to?(:unified_mode)
        unified_mode true
        ^^^^^^^^^^^^^^^^^ Set `unified_mode true` unconditionally. Making it conditional gives you unified mode on newer Chef Infra Client releases and legacy mode on older ones, so the resource has to be tested and reasoned about both ways.
      end
    RUBY

    expect_correction(<<~RUBY)
      unified_mode true
    RUBY
  end

  it 'registers an offense when unified_mode true is guarded with unless' do
    expect_offense(<<~RUBY)
      unified_mode true unless Chef::VERSION.to_i < 16
      ^^^^^^^^^^^^^^^^^ Set `unified_mode true` unconditionally. Making it conditional gives you unified mode on newer Chef Infra Client releases and legacy mode on older ones, so the resource has to be tested and reasoned about both ways.
    RUBY

    expect_correction(<<~RUBY)
      unified_mode true
    RUBY
  end

  it 'registers an offense without autocorrecting when the branch does more than set unified_mode' do
    expect_offense(<<~RUBY)
      if respond_to?(:unified_mode)
        unified_mode true
        ^^^^^^^^^^^^^^^^^ Set `unified_mode true` unconditionally. Making it conditional gives you unified mode on newer Chef Infra Client releases and legacy mode on older ones, so the resource has to be tested and reasoned about both ways.
        provides :my_resource
      end
    RUBY

    expect_no_corrections
  end

  it 'registers an offense without autocorrecting when the if has an else branch' do
    expect_offense(<<~RUBY)
      if respond_to?(:unified_mode)
        unified_mode true
        ^^^^^^^^^^^^^^^^^ Set `unified_mode true` unconditionally. Making it conditional gives you unified mode on newer Chef Infra Client releases and legacy mode on older ones, so the resource has to be tested and reasoned about both ways.
      else
        provides :my_resource
      end
    RUBY

    expect_no_corrections
  end

  it "doesn't register an offense when unified_mode true is set unconditionally" do
    expect_no_offenses(<<~RUBY)
      unified_mode true
    RUBY
  end

  it "doesn't register an offense when unified_mode false is guarded with respond_to?" do
    expect_no_offenses(<<~RUBY)
      unified_mode false if respond_to?(:unified_mode)
    RUBY
  end

  it "doesn't register an offense when unified_mode false is set unconditionally" do
    expect_no_offenses(<<~RUBY)
      unified_mode false
    RUBY
  end

  it "doesn't register an offense on an unrelated conditional property" do
    expect_no_offenses(<<~RUBY)
      resource_name :foo if respond_to?(:resource_name)
    RUBY
  end

  context 'with TargetChefVersion set to 15.2' do
    let(:config) { target_chef_version(15.2) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        unified_mode true if respond_to?(:unified_mode)
      RUBY
    end
  end

  it 'registers an offense without autocorrecting when the guard is an elsif' do
    expect_offense(<<~RUBY)
      if node['platform'] == 'windows'
        provides :thing
      elsif respond_to?(:unified_mode)
        unified_mode true
        ^^^^^^^^^^^^^^^^^ Set `unified_mode true` unconditionally. Making it conditional gives you unified mode on newer Chef Infra Client releases and legacy mode on older ones, so the resource has to be tested and reasoned about both ways.
      end
    RUBY

    expect_no_corrections
  end
end
