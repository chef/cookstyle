#
# Copyright:: Copyright 2019, Chef Software Inc.
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
        # Chef Infra Client provides the :nothing action by default for every resource. There is no need to define a :nothing action in your resource code.
        #
        # @example
        #
        #   # bad
        #   action :nothing
        #     # let's do nothing
        #   end
        #
        class ResourceWithNothingAction < Cop
          MSG = 'There is no need to define a :nothing action in your resource as Chef Infra Client provides the :nothing action by default for every resource.'.freeze

          def_node_matcher :nothing_action?, <<-PATTERN
            (block (send nil? :action (sym :nothing)) (args) ... )
          PATTERN

          def on_block(node)
            nothing_action?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
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
