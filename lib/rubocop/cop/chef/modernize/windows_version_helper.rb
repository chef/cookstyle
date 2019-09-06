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
        # Use node['platform_version] data instead of the Windows::VersionHelper helper from the Windows cookbook.
        #
        # @example
        #
        #   # bad
        #   Windows::VersionHelper.nt_version
        #
        #   # good
        #   node['platform_version].to_i
        #
        class WindowsVersionHelper < Cop
          MSG = "Use node['platform_version'] data instead of the Windows::VersionHelper helper from the Windows cookbook.".freeze

          def_node_matcher :windows_helper?, <<-PATTERN
            (send ( const ( const {nil? cbase} :Windows ) :VersionHelper ) ... )
          PATTERN

          def on_send(node)
            windows_helper?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
