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
        # In Chef Infra Client 12.5 and later it is no longer necessary to set `actions` or `allowed_actions` as Chef Infra Client determines these automatically from the set of all actions defined in the resource.
        #
        # @example
        #
        #   # bad
        #   allowed_actions [:create, :remove]
        #
        #   # also bad
        #   actions [:create, :remove]
        #
        #   # don't do this either
        #   def initialize(*args)
        #     super
        #     @allowed_actions = [:create, :remove]
        #   end
        #
        #   # good
        #   property :something, String
        #
        class CustomResourceWithAllowedActions < Cop
          include RangeHelp

          MSG = 'Resources no longer need to define the allowed actions using the allowed_actions / actions helper methods or within an initialize method.'.freeze

          def_node_matcher :allowed_actions?, <<-PATTERN
            (send nil? {:allowed_actions :actions} ... )
          PATTERN

          def on_send(node)
            allowed_actions?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def on_def(node)
            if node.method_name == :initialize
              found_node = nil
              unless node.body.nil? # empty initialize methods
                node.body.each_node do |x|
                  found_node = x if x.assignment? && x.node_parts.first == :@allowed_actions
                end
              end

              add_offense(found_node, location: :expression, message: MSG, severity: :refactor) if found_node
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.remove(range_with_surrounding_space(range: node.loc.expression, side: :left))
            end
          end
        end
      end
    end
  end
end
