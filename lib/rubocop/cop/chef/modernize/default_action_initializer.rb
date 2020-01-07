#
# Copyright:: 2019, Chef Software Inc.
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
        # The default actions can now be specified using the `default_action` helper instead of using the @action variable in the resource provider initialize method. In general we recommend against writing HWRPs, but if HWRPs are necessary you should utilize as much of the resource DSL as possible.
        #
        # @example
        #
        #   # bad
        #   def initialize(*args)
        #     super
        #     @action = :create
        #   end
        #
        #   # bad
        #   def initialize(*args)
        #     super
        #     @default_action = :create
        #   end
        #
        #  # good
        #  default_action :create

        class DefaultActionFromInitialize < Cop
          include RangeHelp

          MSG = 'The default action of a resource can be set with the "default_action" helper instead of using the initialize method.'.freeze

          def_node_matcher :action_in_initializer?, <<-PATTERN
            (def :initialize (args ...) <(begin ... $(ivasgn {:@action :@default_action} $(...)))> )
          PATTERN

          def_node_search :intialize_method, '(def :initialize ... )'

          def_node_search :default_action_method?, '(send nil? :default_action ... )'

          def on_def(node)
            action_in_initializer?(node) do |action, _val|
              add_offense(action, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              # insert the new default_action call above the initialize method, but not if one already exists (this is sadly common)
              unless default_action_method?(processed_source.ast)
                initialize_node = intialize_method(processed_source.ast).first
                corrector.insert_before(initialize_node.source_range, "default_action #{node.descendants.first.source}\n\n")
              end

              # remove the variable from the initialize method
              corrector.remove(range_with_surrounding_space(range: node.loc.expression, side: :left))
            end
          end
        end
      end
    end
  end
end
