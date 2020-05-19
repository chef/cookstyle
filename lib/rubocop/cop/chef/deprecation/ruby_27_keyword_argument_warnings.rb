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
        # Pass options to shell_out helpers without the brackets to avoid Ruby 2.7 deprecation warnings.
        #
        # @example
        #
        #   # bad
        #   shell_out!('hostnamectl status', { returns: [0, 1] })
        #   shell_out('hostnamectl status', { returns: [0, 1] })
        #
        #   # good
        #   shell_out!('hostnamectl status', returns: [0, 1])
        #   shell_out('hostnamectl status', returns: [0, 1])
        #
        class Ruby27KeywordArgumentWarnings < Cop
          include RuboCop::Chef::CookbookHelpers

          MSG = 'Pass options to shell_out helpers without the brackets to avoid Ruby 2.7 deprecation warnings.'.freeze

          def_node_matcher :positional_shellout?, <<-PATTERN
            (send nil? {:shell_out :shell_out!} ... $(hash ... ))
          PATTERN

          def on_send(node)
            positional_shellout?(node) do |h|
              add_offense(h, location: :expression, message: MSG, severity: :refactor) if h.braces?
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              # @todo when we drop ruby 2.4 support we can convert to to just delete_prefix delete_suffix
              corrector.replace(node.loc.expression, node.loc.expression.source.gsub(/^{/, '').gsub(/}$/, ''))
            end
          end
        end
      end
    end
  end
end
