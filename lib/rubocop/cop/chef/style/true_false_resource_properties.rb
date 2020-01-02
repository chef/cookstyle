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
      module ChefStyle
        # When setting the allowed types for a resource to accept either true or false values it's much simpler to use true and false instead of TrueClass and FalseClass.
        #
        # @example
        #
        #   # bad
        #   property :foo, [TrueClass, FalseClass]
        #   attribute :foo, kind_of: [TrueClass, FalseClass]
        #
        #   # good
        #   property :foo, [true, false]
        #   attribute :foo, kind_of: [true, false]
        #
        class TrueClassFalseClassResourceProperties < Cop
          MSG = "When setting the allowed types for a resource to accept either true or false values it's much simpler to use true and false instead of TrueClass and FalseClass.".freeze

          def_node_matcher :trueclass_falseclass_array?, <<-PATTERN
             (array (const nil? :TrueClass) (const nil? :FalseClass))
          PATTERN

          def_node_matcher :tf_in_kind_of_hash?, <<-PATTERN
            (hash (pair (sym :kind_of) #trueclass_falseclass_array? ))
          PATTERN

          def_node_matcher :trueclass_falseclass_property?, <<-PATTERN
            (send nil? {:property :attribute} (sym _)

            ${#tf_in_kind_of_hash? #trueclass_falseclass_array? } ... )
          PATTERN

          def on_send(node)
            trueclass_falseclass_property?(node) do |tf_match|
              add_offense(tf_match, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              replacement_text = node.hash_type? ? 'kind_of: [true, false]' : '[true, false]'
              corrector.replace(node.loc.expression, replacement_text)
            end
          end
        end
      end
    end
  end
end
