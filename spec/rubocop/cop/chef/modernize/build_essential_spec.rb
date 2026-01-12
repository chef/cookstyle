# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

describe RuboCop::Cop::Chef::Modernize::UseBuildEssentialResource, :config do
  it 'registers an offense when including the "build-essential" recipe' do
    expect_offense(<<~RUBY)
      include_recipe 'build-essential'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the build_essential resource instead of the legacy build-essential recipe. This resource ships in the build-essential cookbook v5.0+ and is built into Chef Infra Client 14+
    RUBY

    expect_correction(<<~RUBY)
      build_essential 'install compilation tools'
    RUBY
  end

  it 'registers an offense when including the "build-essential::default" recipe' do
    expect_offense(<<~RUBY)
      include_recipe 'build-essential::default'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the build_essential resource instead of the legacy build-essential recipe. This resource ships in the build-essential cookbook v5.0+ and is built into Chef Infra Client 14+
    RUBY

    expect_correction(<<~RUBY)
      build_essential 'install compilation tools'
    RUBY
  end

  it "doesn't register an offense when using the build_essential resource" do
    expect_no_offenses(<<~RUBY)
      build_essential 'install some tools!'
    RUBY
  end
end
