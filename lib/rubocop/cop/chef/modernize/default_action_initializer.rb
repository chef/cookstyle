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
        #  # good
        #  default_action :create

        class DefaultActionFromInitialize < Cop
          include RangeHelp

          MSG = 'The default action of a resource can be set with the "default_action" helper instead of using the initialize method.'.freeze

          def on_def(node)
            return unless node.method_name == :initialize
            return if node.body.nil? # nil body is an empty initialize method

            node.body.each_node do |x|
              if x.assignment? && !x.node_parts.empty? && x.node_parts.first == :@action
                add_offense(x, location: :expression, message: MSG, severity: :refactor)
              end
            end
          end

          def_node_search :intialize_method, '(def :initialize ... )'

          def autocorrect(node)
            lambda do |corrector|
              # insert the new default_action call above the initialize method
              initialize_node = intialize_method(processed_source.ast).first
              corrector.insert_before(initialize_node.source_range, "default_action #{node.descendants.first.source}\n\n")

              # remove the variable from the initialize method
              corrector.remove(range_with_surrounding_space(range: node.loc.expression, side: :left))
            end
          end
        end
      end
    end
  end
end
