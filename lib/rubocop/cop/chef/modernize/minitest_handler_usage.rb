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
        # Use Chef InSpec for testing instead of the Minitest Handler cookbook pattern.
        #
        # @example
        #
        #   # bad
        #   depends 'minitest-handler'
        #
        class MinitestHandlerUsage < Cop
          MSG = 'Use Chef InSpec for testing instead of the Minitest Handler cookbook pattern.'.freeze

          def_node_matcher :minitest_depends?, <<-PATTERN
            (send nil? :depends (str "minitest-handler"))
          PATTERN

          def on_send(node)
            minitest_depends?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
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
