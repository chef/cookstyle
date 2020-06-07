#
# Copyright:: Copyright (c) Chef Software Inc.
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

describe RuboCop::Cop::Chef::ChefDeprecations::HWRPWithoutResourcenameAndProvides, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a HWRP does not define a resource_name or provides' do
    expect_offense(<<~RUBY)
    class Chef
      class Resource
        class UlimitRule < Chef::Resource
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ In Chef Infra Client 16 and later a legacy HWRP resource must use `provides` to define how the resource is called in recipes or other resources. To maintain compatibility with Chef Infra Client < 16 use both `resource_name` and `provides`.
          property :type, [Symbol, String], required: true
          property :item, [Symbol, String], required: true

          # additional resource code
        end
      end
    end
    RUBY
  end

  it 'registers an offense when a HWRP does not define a provides' do
    expect_offense(<<~RUBY)
    class Chef
      class Resource
        class UlimitRule < Chef::Resource
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ In Chef Infra Client 16 and later a legacy HWRP resource must use `provides` to define how the resource is called in recipes or other resources. To maintain compatibility with Chef Infra Client < 16 use both `resource_name` and `provides`.
          resource_name :ulimit_rule

          property :type, [Symbol, String], required: true
          property :item, [Symbol, String], required: true

          # additional resource code
        end
      end
    end
    RUBY
  end

  it 'registers an offense when a HWRP defines a resource_name that does not match a provides' do
    expect_offense(<<~RUBY)
    class Chef
      class Resource
        class UlimitRule < Chef::Resource
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ In Chef Infra Client 16 and later a legacy HWRP resource must use `provides` to define how the resource is called in recipes or other resources. To maintain compatibility with Chef Infra Client < 16 use both `resource_name` and `provides`.
          resource_name :ulimit_rule
          provides :ulimit_something_else

          property :type, [Symbol, String], required: true
          property :item, [Symbol, String], required: true

          # additional resource code
        end
      end
    end
    RUBY
  end

  # This is for Chef <= 15 backwards compatibility, in Chef-16 this becomes an offense and the duplicate resource_name should be removed
  # When we assume everyone is on 16 then we'll
  it "doesn't register an offense when a HWRP uses both resource_name and provides" do
    expect_no_offenses(<<~RUBY)
      class Chef
        class Resource
          class UlimitRule < Chef::Resource
            resource_name :ulimit_rule
            provides :ulimit_rule

            property :type, [Symbol, String], required: true
            property :item, [Symbol, String], required: true

            # additional resource code
          end
        end
      end
    RUBY
  end

  # This is for Chef <= 15 backwards compatibility, in Chef-16 this becomes an offense and the duplicate resource_name should be removed
  it "doesn't register an offense when a HWRP uses both resource_name and provides (with the provides first)" do
    expect_no_offenses(<<~RUBY)
      class Chef
        class Resource
          class UlimitRule < Chef::Resource
            provides :ulimit_rule
            resource_name :ulimit_rule

            property :type, [Symbol, String], required: true
            property :item, [Symbol, String], required: true

            # additional resource code
          end
        end
      end
    RUBY
  end

  # This is for Chef <= 15 backwards compatibility, in Chef-16 this becomes an offense and the duplicate resource_name should be removed
  it "doesn't register an offense when a HWRP uses both resource_name and provides (with other provides)" do
    expect_no_offenses(<<~RUBY)
      class Chef
        class Resource
          class UlimitRule < Chef::Resource
            resource_name :ulimit_rule
            provides :ulimit_somethingelse
            provides :ulimit_rule

            property :type, [Symbol, String], required: true
            property :item, [Symbol, String], required: true

            # additional resource code
          end
        end
      end
    RUBY
  end

  # This is for Chef <= 15 backwards compatibility, in Chef-16 this becomes an offense and the duplicate resource_name should be removed
  it "doesn't register an offense when a HWRP uses both resource_name and provides (with other provides, and a platform constraint)" do
    expect_no_offenses(<<~RUBY)
      class Chef
        class Resource
          class UlimitRule < Chef::Resource
            resource_name :ulimit_rule
            provides :ulimit_somethingelse
            provides :ulimit_rule, platform: "windows"

            property :type, [Symbol, String], required: true
            property :item, [Symbol, String], required: true

            # additional resource code
          end
        end
      end
    RUBY
  end
end
