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
        # Don't call the deprecated updated= method in a resource to set the resource to updated. This method was removed from Chef Infra Client 13 and this will now cause an error. Instead wrap code that updated the state of the node in a converge_by block. Documentation on using the converge_by block can be found at https://docs.chef.io/custom_resources.html.
        #
        # @example
        #
        #   # bad
        #   action :foo do
        #     updated = true
        #   end
        #
        #   # good
        #   action :foo do
        #     converge_by('resource did something) do
        #       # code that causes the resource to converge
        #     end
        #
        class ResourceUsesUpdatedMethod < Cop
          MSG = "Don't use updated = true/false to update resource state. This will cause failures in Chef Infra Client 13 and later.".freeze

          def on_lvasgn(node)
            add_offense(node, location: :expression, message: MSG, severity: :refactor) if node.node_parts.first == :updated
          end

          # potential autocorrect is new_resource.updated_by_last_action true, but we need to actually see what class we were called from
          # this might not be worth it yet based on the number of these we'd run into and the false auto correct potential
        end
      end
    end
  end
end
