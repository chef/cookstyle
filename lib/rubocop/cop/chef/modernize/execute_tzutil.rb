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
        # Instead of using the execute or powershell_script resources to to run the `tzutil` command, use
        # Chef Infra Client's built-in timezone resource which is available in Chef Infra Client 14.6 and later.
        #
        #   # bad
        #   execute 'set tz' do
        #     command 'tzutil.exe /s UTC'
        #   end
        #
        #   execute 'tzutil /s UTC'
        #
        #   powershell_script 'set windows timezone' do
        #     code "tzutil.exe /s UTC"
        #     not_if { shell_out('tzutil.exe /g').stdout.include?('UTC') }
        #   end
        #
        #   # good
        #   timezone 'UTC'
        #
        class ExecuteTzUtil < Cop
          include RuboCop::Chef::CookbookHelpers

          MSG = 'Use the timezone resource included in Chef Infra Client 14.6+ instead of shelling out to tzutil'.freeze

          def_node_matcher :execute_resource?, <<-PATTERN
            (send nil? :execute $str)
          PATTERN

          def on_send(node)
            execute_resource?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor) if node.arguments.first.value.match?(/^tzutil/i)
            end
          end

          def on_block(node)
            match_property_in_resource?(:execute, 'command', node) do |code_property|
              add_offense(node, location: :expression, message: MSG, severity: :refactor) if calls_tzutil?(code_property)
            end

            match_property_in_resource?(:powershell_script, 'code', node) do |code_property|
              add_offense(node, location: :expression, message: MSG, severity: :refactor) if calls_tzutil?(code_property)
            end
          end

          private

          def calls_tzutil?(ast_obj)
            property_data = method_arg_ast_to_string(ast_obj)
            return true if property_data && property_data.match?(/^tzutil/i)
          end
        end
      end
    end
  end
end
