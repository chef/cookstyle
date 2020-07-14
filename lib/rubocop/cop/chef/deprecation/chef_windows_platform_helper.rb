# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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
      module ChefDeprecations
        # Use `platform?('windows')` instead of the legacy `Chef::Platform.windows?` helper
        #
        # @example
        #
        #   # bad
        #   Chef::Platform.windows?
        #
        #   # good
        #   platform?('windows')
        #   platform_family?('windows')
        #
        class ChefWindowsPlatformHelper < Cop
          MSG = "Use `platform?('windows')` instead of the legacy `Chef::Platform.windows?` helper."

          def_node_matcher :chef_platform_windows?, <<-PATTERN
            (send
              (const
                (const nil? :Chef) :Platform) :windows?)
          PATTERN

          def on_send(node)
            chef_platform_windows?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :warning)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, "platform?('windows')")
            end
          end
        end
      end
    end
  end
end
