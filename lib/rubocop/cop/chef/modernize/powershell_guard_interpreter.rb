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
        # PowerShell is already set as the default guard interpreter for powershell_script resources in Chef Infra Client 13 and later and does not need to be specified.
        #
        # @example
        #
        #   # bad
        #   powershell_script 'whatever' do
        #     code "mkdir test_dir"
        #     guard_interpreter :powershell_script
        #   end
        #
        #   # good
        #   powershell_script 'whatever' do
        #     code "mkdir test_dir"
        #   end
        #
        class PowerShellGuardInterpreter < Cop
          include RuboCop::Chef::CookbookHelpers
          include RangeHelp

          MSG = 'PowerShell is already set as the default guard interpreter for powershell_script resources in Chef Infra Client 13 and later and does not need to be specified.'.freeze

          def on_block(node)
            match_property_in_resource?(:powershell_script, 'guard_interpreter', node) do |interpreter|
              if interpreter.arguments.first.source == ':powershell_script'
                add_offense(interpreter, location: :expression, message: MSG, severity: :refactor)
              end
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.remove(range_with_surrounding_space(range: node.loc.expression, side: :left))
            end
          end
        end
      end
    end
  end
end
