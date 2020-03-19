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

describe RuboCop::Cop::Chef::ChefDeprecations::ResourceWithoutNameOrProvides, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a Resource derived HWRP does not define a resource_name or provides' do
    expect_offense(<<~RUBY)
    class Chef
      class Resource
        class UlimitRule < Chef::Resource
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ In Chef Infra Client 16 and later legacy HWRP resources must use either `resource_name` or `provides` to define the resource name.
          property :type, [Symbol, String], required: true
          property :item, [Symbol, String], required: true

          # additional resource code
        end
      end
    end
    RUBY
  end

  it "doesn't register an offense when a Resource derived HWRP uses resource_name" do
    expect_no_offenses(<<~RUBY)
      class Chef
        class Resource
          class UlimitRule < Chef::Resource
            resource_name :ulimit_rule

            property :type, [Symbol, String], required: true
            property :item, [Symbol, String], required: true

            # additional resource code
          end
        end
      end
    RUBY
  end

  it "doesn't register an offense when a Resource derived HWRP uses provides" do
    expect_no_offenses(<<~RUBY)
      class Chef
        class Resource
          class UlimitRule < Chef::Resource
            provides :ulimit_rule

            property :type, [Symbol, String], required: true
            property :item, [Symbol, String], required: true

            # additional resource code
          end
        end
      end
    RUBY
  end
end
