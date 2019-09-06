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
        # In HWRPs and LWRPs it was necessary to define the allowed actions within the resource.
        # In custom resources this is no longer necessary as Chef will determine it based on the
        # actions defined in the resource.
        #
        # @example
        #
        #   # bad
        #   property :something, String
        #
        #   allowed_actions [:create, :remove]
        #   action :create do
        #     # some action code because we're in a custom resource
        #   end
        #
        #   # also bad
        #   property :something, String
        #
        #   actions [:create, :remove]
        #   action :create do
        #     # some action code because we're in a custom resource
        #   end
        #
        #   # good
        #   property :something, String
        #
        #   action :create do
        #     # some action code because we're in a custom resource
        #   end
        #
        class CustomResourceWithAllowedActions < Cop
          MSG = "Custom Resources don't need to define the allowed actions with allowed_actions or actions methods".freeze

          def_node_matcher :allowed_actions?, <<-PATTERN
            (send nil? {:allowed_actions :actions} ... )
          PATTERN

          def_node_search :resource_actions?, <<-PATTERN
            (block (send nil? :action ... ) ... )
          PATTERN

          def on_send(node)
            allowed_actions?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor) if resource_actions?(processed_source.ast)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.remove(node.loc.expression)
            end
          end
        end
      end
    end
  end
end
