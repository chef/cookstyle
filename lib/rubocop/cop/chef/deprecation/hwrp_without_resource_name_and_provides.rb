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

module RuboCop
  module Cop
    module Chef
      module ChefDeprecations
        # Chef Infra Client 16 and later a legacy HWRP resource must use `provides` to define how the resource is called in recipes or other resources. To maintain compatibility with Chef Infra Client < 16 use both `resource_name` and `provides`.
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
        #   # bad
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
        #  # good when Chef Infra Client < 15 (but compatible with 16+ as well)
        #   class Chef
        #     class Resource
        #       class UlimitRule < Chef::Resource
        #         resource_name :ulimit_rule
        #         provides :ulimit_rule
        #
        #         property :type, [Symbol, String], required: true
        #         property :item, [Symbol, String], required: true
        #
        #         # additional resource code
        #       end
        #     end
        #   end
        #
        #  # good when Chef Infra Client 16+
        #   class Chef
        #     class Resource
        #       class UlimitRule < Chef::Resource
        #         provides :ulimit_rule
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
        class HWRPWithoutResourcenameAndProvides < Cop
          MSG = 'In Chef Infra Client 16 and later a legacy HWRP resource must use `provides` to define how the resource is called in recipes or other resources. To maintain compatibility with Chef Infra Client < 16 use both `resource_name` and `provides`.'.freeze

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

          def_node_search :provides, '(send nil? :provides (sym $_) ...)'
          def_node_search :resource_name, '(send nil? :resource_name (sym $_))'

          def on_class(node)
            HWRP?(node) do |inherit|
              add_offense(inherit, location: :expression, message: MSG, severity: :warning) unless has_resource_name_and_provides?
            end
          end

          def has_resource_name_and_provides?
            provides_ast = provides(processed_source.ast)
            return false unless provides_ast

            resource_ast = resource_name(processed_source.ast)
            return false unless resource_ast

            # since we have a resource and provides make sure the there is a provides that
            # matches the resource name
            provides_ast.include?(resource_ast.first)
          end
        end
      end
    end
  end
end
