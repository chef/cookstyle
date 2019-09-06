#
# Copyright:: 2019, Chef Software Inc.
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
      module ChefCorrectness
        # The :nothing action is often typo'd as :none
        #
        # @example
        #
        #   # bad
        #   service 'foo' do
        #    action :none
        #   end
        #
        #   # good
        #   service 'foo' do
        #    action :nothing
        #   end
        #
        class ResourceWithNoneAction < Cop
          include RuboCop::Chef::CookbookHelpers

          MSG = 'Resource uses the nonexistent :none action instead of the :nothing action'.freeze

          def on_block(node)
            match_property_in_resource?(nil, 'action', node) do |action_node|
              action_node.arguments.each do |action|
                add_offense(action, location: :expression, message: MSG, severity: :refactor) if action.source == ':none'
              end
            end
          end
        end
      end
    end
  end
end
