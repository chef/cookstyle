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
      module ChefDeprecations
        # Make sure to use include_recipe instead of require_recipe
        #
        # @example
        #
        #   # bad
        #   require_recipe 'foo'
        #
        #   # good
        #   include_recipe 'foo'
        #
        class RequireRecipe < Cop
          MSG = 'Use include_recipe instead of the require_recipe method'.freeze

          def_node_matcher :require_recipe?, <<-PATTERN
            (send nil? :require_recipe $str)
          PATTERN

          def on_send(node)
            require_recipe?(node) { add_offense(node, location: :selector, message: MSG, severity: :refactor) }
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.selector, 'include_recipe')
            end
          end
        end
      end
    end
  end
end
