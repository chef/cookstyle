#
# Copyright:: 2020, Chef Software Inc.
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

module RuboCop
  module Cop
    module Chef
      module ChefDeprecations
        # In Chef Infra Client 16 and later a legacy HWRP resource must use either `resource_name` or `provides` to define the resource name.
        #
        # @example
        #
        #   # bad
        #   class Chef
        #     class Resource
        #       class UlimitRule < Chef::Resource
        #         property :type, [Symbol, String], required: true
        #         property :item, [Symbol, String], required: true
        #
        #         # additional resource code
        #       end
        #     end
        #   end
        #
        #  # good
        #   class Chef
        #     class Resource
        #       class UlimitRule < Chef::Resource
        #         resource_name :ulimit_rule
        #
        #         property :type, [Symbol, String], required: true
        #         property :item, [Symbol, String], required: true
        #
        #         # additional resource code
        #       end
        #     end
        #   end
        #
        #  # better
        #  Convert your legacy HWRPs to custom resources
        #
        class ResourceWithoutNameOrProvides < Cop
          MSG = 'In Chef Infra Client 16 and later legacy HWRP resources must use either `resource_name` or `provides` to define the resource name.'.freeze

          def_node_matcher :HWRP?, <<-PATTERN
          (class
            (const nil? :Chef) nil?
            (class
              (const nil? :Resource) nil?
              $(class
                (const nil? ... )
                (const
                  (const nil? :Chef) :Resource)
                  (begin ... ))))
          PATTERN

          def_node_search :provides_or_resource_name?, '(send nil? {:provides :resource_name} ...)'

          def on_class(node)
            HWRP?(node) do |inherit|
              add_offense(inherit, location: :expression, message: MSG, severity: :refactor) if provides_or_resource_name?(processed_source.ast).nil?
            end
          end
        end
      end
    end
  end
end
