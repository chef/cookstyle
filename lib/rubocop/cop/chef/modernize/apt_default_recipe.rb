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
        # Don't include the apt default recipe to update apt's package cache when you can
        # use the apt_update resource built into Chef Infra Client 12.7 and later.
        #
        # @example
        #
        #   # bad
        #   include_recipe 'apt::default'
        #   include_recipe 'apt'
        #
        #   # good
        #   apt_update
        #
        class IncludingAptDefaultRecipe < Cop
          MSG = 'Do not include the Apt default recipe to update package cache. Instead use the apt_update resource, which is built into Chef Infra Client 12.7 and later.'.freeze

          def_node_matcher :apt_recipe_usage?, <<-PATTERN
            (send nil? :include_recipe (str {"apt" "apt::default"}))
          PATTERN

          def on_send(node)
            apt_recipe_usage?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
