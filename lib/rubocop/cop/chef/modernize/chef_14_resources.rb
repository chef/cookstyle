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
      # Don't depend on cookbooks made obsolete by Chef 14
      #
      # @example
      #
      #   # bad
      #   depends 'dmg'
      #   depends 'sysctl'
      #   depends 'mac_os_x'
      #   depends 'chef_handler'
      #   depends 'swap'
      #   depends 'chef_hostname'
      #
      class UnnecessaryDependsChef14 < Cop
        MSG = "Don't depend on cookbooks made obsolete by Chef 14".freeze

        def_node_matcher :legacy_depends?, <<-PATTERN
          (send nil? :depends (str {"build-essential" "sysctl" "mac_os_x" "chef_handler" "swap" "chef_hostname"}))
        PATTERN

        def on_send(node)
          legacy_depends?(node) do
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
