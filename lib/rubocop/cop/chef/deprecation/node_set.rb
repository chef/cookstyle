# frozen_string_literal: true
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
      module Deprecations
        # The `node.set` method has been removed in Chef Infra Client 13 and usage must be replaced with `node.normal`.
        #
        # This cop will autocorrect code to use node.normal, which is functionally identical to node.set, but we also discourage the use of that method as normal level attributes persist on the node even if the code setting the attribute is later removed.
        #
        # @example
        #
        #   ### incorrect
        #   node.set['foo'] = true
        #
        #   ### correct
        #   node.normal['foo'] = true
        #
        class NodeSet < Base
          extend AutoCorrector

          MSG = 'Do not use node.set. Replace with node.normal to keep identical behavior.'
          RESTRICT_ON_SEND = [:set].freeze

          def_node_matcher :node_set?, <<-PATTERN
            (send (send _ :node) $:set)
          PATTERN

          def on_send(node)
            node_set?(node) do
              add_offense(node.loc.selector, severity: :warning) do |corrector|
                corrector.replace(node.loc.selector, 'normal')
              end
            end
          end
        end
      end
    end
  end
end
