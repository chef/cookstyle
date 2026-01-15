# frozen_string_literal: true
#
# Copyright:: 2026, Chef Software Inc.
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
      module Correctness
        # The execute resource can hang indefinitely if a command never completes.
        # It is a best practice to always set a timeout to prevent commands from hanging forever.
        #
        # @example
        #
        #   # bad
        #   execute 'run_script' do
        #     command 'sleep 100'
        #   end
        #
        #   # good
        #   execute 'run_script' do
        #     command 'sleep 100'
        #     timeout 30
        #   end
        #
        class ExecuteWithoutTimeout < Base
          MSG = 'Add a timeout to execute resources to avoid hanging commands.'

          def on_block(node)
            send_node, _args, body = *node
            return unless execute_resource?(send_node)
            return if timeout_present?(body)

            add_offense(node)
          end

          private

          def execute_resource?(send_node)
            send_node.method_name == :execute
          end

          def timeout_present?(body)
            return false unless body

            body.each_node(:send).any? do |send_node|
              send_node.method_name == :timeout
            end
          end
        end
      end
    end
  end
end
