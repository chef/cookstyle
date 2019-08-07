#
# Copyright:: 2019, Chef Software, Inc.
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
      # Detect chef_handler resources uses the deprecated supports property instead
      # of the newer type resource
      #
      # @example
      #
      #   # bad
      #   chef_handler 'whatever' do
      #     supports 'foo'
      #   end0
      #
      #   # good
      #   chef_handler 'whatever' do
      #     type 'foo'
      #   end
      #
      class ChefHandlerUsesSupports < Cop
        MSG = 'Use the type property instead of the deprecated supports property in the chef_handler resource'.freeze

        def on_block(node)
          match_property_in_resource?('chef_handler', 'supports', node) do |prop_node|
            add_offense(prop_node, location: :expression, message: MSG, severity: :refactor)
          end
        end
      end
    end
  end
end
