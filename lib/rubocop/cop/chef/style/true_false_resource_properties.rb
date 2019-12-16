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
      module ChefStyle
        # When setting the allowed types for a resource to accept either true or false you should use the actual class names of TrueClass and FalseClass instead of true and false.
        #
        # @example
        #
        #   # bad
        #   property :foo, [true, false]
        #
        #   # good
        #   property :foo, [TrueClass, FalseClass]
        #
        class TrueFalseResourceProperties < Cop
          MSG = 'Use TrueClass and FalseClass in resource properties not true and false'.freeze

          def_node_matcher :true_false_property?, <<-PATTERN
            (send nil? {:property :attribute} (sym _) $(array (true) (false)) ... )
          PATTERN

          def on_send(node)
            true_false_property?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              true_false_property?(node) do |types|
                corrector.replace(types.loc.expression, '[TrueClass, FalseClass]')
              end
            end
          end
        end
      end
    end
  end
end
