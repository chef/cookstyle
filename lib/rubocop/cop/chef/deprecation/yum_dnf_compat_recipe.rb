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
        # Don't include the deprecated yum DNF compatibility recipe, which is no longer necessary
        # as Chef Infra Client includes DNF package support
        #
        # @example
        #
        #   # bad
        #   include_recipe 'yum::dnf_yum_compat'
        #
        class IncludingYumDNFCompatRecipe < Cop
          MSG = 'Do not include the deprecated yum::dnf_yum_compat default recipe to install yum on dnf systems. Chef Infra Client now includes built in support for DNF packages.'.freeze

          def_node_matcher :yum_dnf_compat_recipe_usage?, <<-PATTERN
            (send nil? :include_recipe (str "yum::dnf_yum_compat"))
          PATTERN

          def on_send(node)
            yum_dnf_compat_recipe_usage?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.remove(node.loc.expression)
            end
          end
        end
      end
    end
  end
end
