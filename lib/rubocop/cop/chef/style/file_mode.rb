#
# Copyright:: 2016, Noah Kantrowitz
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
        # Check the file modes are given as strings instead of integers.
        #
        # @example
        #
        #   # bad
        #   mode 644
        #   mode 0644
        #
        #   # good
        #   mode '644'
        #
        class FileMode < Cop
          MSG = 'Use strings for file modes'.freeze

          def_node_matcher :resource_mode?, <<-PATTERN
            (send nil? :mode $int)
          PATTERN

          def on_send(node)
            resource_mode?(node) do |mode_int|
              add_offense(mode_int, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              # If it was an octal literal, make sure we write out the right number.
              replacement_base = octal?(node) ? 8 : 10
              replacement_mode = node.children.first.to_s(replacement_base)
              corrector.replace(node.loc.expression, replacement_mode.inspect)
            end
          end

          private

          def octal?(node)
            node.source =~ /^0o?\d+/i
          end
        end
      end
    end
  end
end
