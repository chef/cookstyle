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
        # Use the platform?() and platform_family?() helpers instead of a case statement that only includes a single when statement.
        #
        # @example
        #
        #   # bad
        #   case node['platform']
        #   when 'ubuntu'
        #     log "We're on Ubuntu"
        #     apt_update
        #   end
        #
        #   # good
        #   if platform?('ubuntu')
        #     log "We're on Ubuntu"
        #     apt_update
        #   end
        #
        class UnnecessaryPlatformCaseStatement < Cop
          MSG = 'Use the platform?() and platform_family?() helpers instead of a case statement that only includes a single when statement.'.freeze

          def_node_matcher :platform_case?, <<-PATTERN
          ( case $( send (send nil? :node) :[] $(str {"platform" "platform_family"})) ... )
          PATTERN

          def on_case(node)
            platform_case?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor) if node&.when_branches&.count == 1
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              platform_case?(node) do |node_, type|
                condition_string = node.when_branches.first.conditions.map(&:source).join(', ')

                # single line bodies should be transformed into `X if platform?('ubuntu')` style statements
                # while multiline statements should just have the case and when bits replace with `if platform?('ubuntu')`
                if node.when_branches.first.body.multiline?
                  corrector.remove(node.loc.keyword) # case
                  corrector.remove(node_.loc.expression) # node['whatever']
                  corrector.remove(node.when_branches.first.loc.keyword) # when

                  conditional_range = node.when_branches.first.conditions[0].source_range.join(node.when_branches.first.conditions[-1].source_range.end)
                  corrector.replace(conditional_range, "if #{type.value}?(#{condition_string})")
                else
                  new_source = "#{node.when_branches.first.body.source} if #{type.value}?(#{condition_string})"
                  corrector.replace(node.loc.expression, new_source)
                end
              end
            end
          end
        end
      end
    end
  end
end
