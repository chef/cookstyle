#
# Copyright:: Copyright 2019, Chef Software Inc.
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
        # The node.deep_fetch method has been removed from Chef-Sugar, and must be replaced by
        # the node.read API.
        #
        # @example
        #
        #   # bad
        #   node.deep_fetch("foo")
        #
        #   # good
        #   node.read("foo")
        #
        #   # bad
        #   node.deep_fetch!("foo")
        #
        #   # good
        #   node.read!("foo")
        #
        class NodeDeepFetch < Cop
          MSG = 'Do not use node.deep_fetch. Replace with node.read to keep identical behavior.'.freeze
          MSG2 = 'Do not use node.deep_fetch!. Replace with node.read! to keep identical behavior.'.freeze

          def_node_matcher :node_deep_fetch?, <<-PATTERN
            (send (send _ :node) $:deep_fetch _)
          PATTERN

          def_node_matcher :node_deep_fetch_bang?, <<-PATTERN
            (send (send _ :node) $:deep_fetch! _)
          PATTERN

          def on_send(node)
            node_deep_fetch?(node) do
              add_offense(node, location: :selector, message: MSG, severity: :warning)
            end

            node_deep_fetch_bang?(node) do
              add_offense(node, location: :selector, message: MSG2, severity: :warning)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.selector, fix_name(node.method_name))
            end
          end

          private

          def fix_name(name)
            return 'read!' if name == :deep_fetch!
            return 'read' if name == :deep_fetch
            name.to_s
          end
        end
      end
    end
  end
end
