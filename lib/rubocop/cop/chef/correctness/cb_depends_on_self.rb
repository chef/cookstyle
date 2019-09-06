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
      # Make sure a cookbook doesn't depend on itself. This will fail on Chef Infra Client 13+
      #
      # @example
      #
      #   # bad
      #   name 'foo'
      #   depends 'foo'
      #
      #   # good
      #   name 'foo'
      #
      module ChefCorrectness
        class CookbooksDependsOnSelf < Cop
          MSG = 'A cookbook cannot depend on itself. This will fail on Chef Infra Client 13+'.freeze

          def_node_search :dependencies, '(send nil? :depends str ...)'
          def_node_matcher :cb_name?, '(send nil? :name str ...)'

          def on_send(node)
            cb_name?(node) do
              dependencies(processed_source.ast).each do |dep|
                if dep.arguments == node.arguments
                  node = dep # set our dependency node as the node for autocorrecting later
                  add_offense(node, location: dep.source_range, message: MSG, severity: :refactor)
                end
              end
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.remove(node.source_range)
            end
          end
        end
      end
    end
  end
end
