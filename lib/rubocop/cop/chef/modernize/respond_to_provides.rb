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
        # In Chef Infra Client 12+ is is no longer necessary to gate the use of the provides methods in resouces by appending either `if respond_to?(:provides)` or `if defined? provides`.
        #
        # @example
        #
        #   # bad
        #   provides :foo if respond_to?(:provides)
        #
        #   provides :foo if defined? provides
        #
        #   # good
        #   provides :foo
        #
        class RespondToProvides < Cop
          MSG = 'Using `respond_to?(:provides)` or `if defined? provides` in resources is no longer necessary in Chef Infra Client 12+.'.freeze

          def on_if(node)
            if_respond_to_provides?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def_node_matcher :if_respond_to_provides?, <<~PATTERN
          (if
            {
            (send nil? :respond_to?
              (sym :provides))

            (:defined?
              (send nil? :provides))
            }
            (send nil? :provides
              (sym _)) ... )
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
