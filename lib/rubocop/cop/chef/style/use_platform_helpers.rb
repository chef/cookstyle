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
        # Use the platform?() and platform_family?() helpers instead of node['platform] == 'foo'
        # and node['platform_family'] == 'bar'. These helpers are easier to read and can accept multiple
        # platform arguments, which greatly simplifies complex platform logic.
        #
        # @example
        #
        #   # bad
        #   node['platform'] == 'ubuntu'
        #
        #   # good
        #   platform?('ubuntu')
        #
        class UsePlatformHelpers < Cop
          MSG = 'Use platform? and platform_family? helpers for checking node platform'.freeze

          def_node_matcher :platform_check?, <<-PATTERN
            ( send (send (send nil? :node) :[] $(str {"platform" "platform_family"}) ) :== $str )
          PATTERN

          def on_send(node)
            platform_check?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              platform_check?(node) do |type, plat|
                corrector.replace(node.loc.expression, "#{type.value}?('#{plat.value}')")
              end
            end
          end
        end
      end
    end
  end
end
