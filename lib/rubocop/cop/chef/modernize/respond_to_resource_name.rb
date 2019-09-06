#
# Copyright:: 2019, Chef Software, Inc.
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
      module ChefModernize
        # Chef 12.5 introduced the resource_name method for resources. Many cookbooks used
        # respond_to?(:resource_name) to provide backwards compatibility with older chef-client
        # releases. This backwards compatibility is no longer necessary.
        #
        # @example
        #
        #   # bad
        #   resource_name :foo if respond_to?(:resource_name)
        #
        #   # good
        #   resource_name :foo
        #
        class RespondToResourceName < Cop
          MSG = 'respond_to?(:resource_name) in resources is no longer necessary in Chef Infra Client 12.5+'.freeze

          def on_if(node)
            if_respond_to_resource_name?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def_node_matcher :if_respond_to_resource_name?, <<~PATTERN
          (if (send nil? :respond_to? ( :sym :resource_name ) ) ... )
          PATTERN

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, node.children[1].source)
            end
          end
        end
      end
    end
  end
end
