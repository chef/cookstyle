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
      module ChefDeprecations
        # Use 'shell_out!' instead of the legacy 'run_command' helper for shelling out. The run_command helper was removed in Chef Infra Client 13.
        #
        # @example
        #
        #   # bad
        #   run_command('/bin/foo')
        #
        #   # good
        #   shell_out!('/bin/foo')
        #
        class UsesRunCommandHelper < Cop
          MSG = "Use 'shell_out!' instead of the legacy 'run_command' helper for shelling out. The run_command helper was removed in Chef Infra Client 13.".freeze

          def_node_matcher :calls_run_command?, '(send nil? :run_command ...)'
          def_node_search :defines_run_command?, '(def :run_command ...)'

          def on_send(node)
            calls_run_command?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor) unless defines_run_command?(processed_source.ast)
            end
          end
        end
      end
    end
  end
end
