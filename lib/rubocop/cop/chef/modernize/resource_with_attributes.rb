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
        # In HWRPs and LWRPs you defined attributes, but custom resources changed the name to
        # be properties to avoid confusion with chef recipe attributes. When writing a custom resource
        # they should be called properties even though the two are aliased.
        #
        # @example
        #
        #   # bad
        #   attribute :something, String
        #
        #   action :create do
        #     # some action code because we're in a custom resource
        #   end
        #
        #   # good
        #   property :something, String
        #
        #   action :create do
        #     # some action code because we're in a custom resource
        #   end
        #
        class CustomResourceWithAttributes < Cop
          MSG = 'Custom Resources should contain properties not attributes'.freeze

          def_node_matcher :attribute?, <<-PATTERN
            (send nil? $:attribute ... )
          PATTERN

          def_node_search :resource_actions?, <<-PATTERN
            (block (send nil? :action ... ) ... )
          PATTERN

          def on_send(node)
            attribute?(node) do
              add_offense(node, location: :selector, message: MSG, severity: :refactor) if resource_actions?(processed_source.ast)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.selector, 'property')
            end
          end
        end
      end
    end
  end
end
