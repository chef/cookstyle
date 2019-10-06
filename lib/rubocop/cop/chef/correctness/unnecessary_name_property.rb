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
        # There is no need to define a property named :name in a resource as Chef Infra defines that property for all resources out of the box.
        #
        # @example
        #
        #   # bad
        #   property :name, String
        #   property :name, String, name_property: true
        #
        class UnnecessaryNameProperty < Cop
          MSG = 'There is no need to define a property named :name in a resource as Chef Infra defines that property for all resources out of the box.'.freeze

          def_node_matcher :name_property?, <<-PATTERN
            (send nil? :property (sym :name) (const nil? :String) $...)
          PATTERN

          def on_send(node)
            name_property?(node) do |hash_vals|
              if hash_vals.empty? || (hash_vals.first.keys.count == 1 && hash_vals.first.keys.first.source == 'name_property')
                add_offense(node, location: :expression, message: MSG, severity: :refactor)
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
