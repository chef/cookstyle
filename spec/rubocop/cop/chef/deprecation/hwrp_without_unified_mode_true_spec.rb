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

describe RuboCop::Cop::Chef::Deprecations::HWRPWithoutUnifiedTrue, :config do
  it 'registers an offense when a HWRP does not define a unified_mode true' do
    expect_offense(<<~RUBY)
      class Chef
        class Resource
          class UlimitRule < Chef::Resource
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Set `unified_mode true` in Chef Infra Client 15.3+ HWRP style custom resources to ensure they work correctly in Chef Infra Client 18 (April 2022) when Unified Mode becomes the default.
            property :type, [Symbol, String], required: true
            property :item, [Symbol, String], required: true

            # additional resource code
          end
        end
      end
    RUBY
  end

  it "doesn't register an offense when a HWRP uses unified_mode" do
    expect_no_offenses(<<~RUBY)
      class Chef
        class Resource
          class UlimitRule < Chef::Resource
            resource_name :ulimit_rule
            provides :ulimit_rule
            unified_mode true

            property :type, [Symbol, String], required: true
            property :item, [Symbol, String], required: true

            # additional resource code
          end
        end
      end
    RUBY
  end

  context 'with TargetChefVersion set before 15.3' do
    let(:config) { target_chef_version(15.2) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        class Chef
          class Resource
            class UlimitRule < Chef::Resource
              property :type, [Symbol, String], required: true
              property :item, [Symbol, String], required: true

              # additional resource code
            end
          end
        end
      RUBY
    end
  end
end
