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

describe RuboCop::Cop::Chef::Deprecations::ResourceWithoutUnifiedTrue, :config do
  it 'registers an offense when a custom resource does not define a unified_mode true' do
    expect_offense(<<~RUBY)
      resource_name :foo
      ^ Set `unified_mode true` in Chef Infra Client 15.3+ custom resources to ensure they work correctly in Chef Infra Client 18 (April 2022) when Unified Mode becomes the default.
      provides :foo

      action :create do
        # some code
      end
    RUBY

    expect_correction(<<~RUBY)
      resource_name :foo
      provides :foo
      unified_mode true

      action :create do
        # some code
      end
    RUBY
  end

  it 'autocorrects below resource_name if provides is not present' do
    expect_offense(<<~RUBY)
      resource_name :foo
      ^ Set `unified_mode true` in Chef Infra Client 15.3+ custom resources to ensure they work correctly in Chef Infra Client 18 (April 2022) when Unified Mode becomes the default.

      action :create do
        # some code
      end
    RUBY

    expect_correction(<<~RUBY)
      resource_name :foo
      unified_mode true

      action :create do
        # some code
      end
    RUBY
  end

  it "doesn't register an offense when a custom resource uses unified_mode" do
    expect_no_offenses(<<~RUBY)
      resource_name :foo
      provides :foo
      unified_mode
    RUBY
  end

  it "doesn't register an offense when the custom resource file is empty" do
    expect_no_offenses('')
  end

  context 'with TargetChefVersion set before 15.3' do
    let(:config) { target_chef_version(15.2) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        resource_name :foo
        provides :foo
      RUBY
    end
  end
end
