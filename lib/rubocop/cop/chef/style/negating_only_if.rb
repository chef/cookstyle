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
      module ChefStyle
        # Use not_if instead of only_if that negates the Ruby statement with a !
        #
        # @example
        #
        #   # bad
        #   package 'legacy-sysv-deps' do
        #     only_if { !systemd }
        #   end
        #
        #   # good
        #   package 'legacy-sysv-deps' do
        #     not_if { systemd }
        #   end
        #
        class NegatingOnlyIf < Cop
          MSG = 'Use not_if instead of only_if that negates the Ruby statement with a !'.freeze

          def_node_matcher :negated_only_if?, <<-PATTERN
            (block
              $(send nil? :only_if)
              (args)
              $(send
                $(...) :!))
          PATTERN

          def on_block(node)
            negated_only_if?(node) do |_only_if, code|
              # the value was double negated to work around types: ex: !!systemd?
              return if code.descendants.first.send_type? &&
                        code.descendants.first.negation_method?

              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            negated_only_if?(node) do |only_if, code|
              lambda do |corrector|
                corrector.replace(code.loc.expression, code.source.gsub(/^!/, ''))
                corrector.replace(only_if.source_range, 'not_if')
              end
            end
          end
        end
      end
    end
  end
end
