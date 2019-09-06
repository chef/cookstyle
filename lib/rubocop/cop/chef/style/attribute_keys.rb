#
# Copyright:: 2016, Noah Kantrowitz
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
        # Check which style of keys are used to access node attributes.
        #
        # There are two supported styles: "symbols" and "strings".
        #
        # @example when configuration is `EnforcedStyle: symbols`
        #
        #   # bad
        #   node['foo']
        #   node["foo"]
        #
        #   # good
        #   node[:foo]
        #
        # @example when configuration is `EnforcedStyle: strings`
        #
        #   # bad
        #   node[:foo]
        #
        #   # good
        #   node['foo']
        #   node["foo"]
        #
        class AttributeKeys < Cop
          include RuboCop::Cop::ConfigurableEnforcedStyle

          MSG = 'Use %s to access node attributes'.freeze

          def_node_matcher :node_attribute_access?, <<-PATTERN
            (send (send _ :node) :[] _)
          PATTERN

          def_node_matcher :node_level_attribute_access?, <<-PATTERN
            (send (send {(send _ :node) nil} {:default :role_default :env_default :normal :override :role_override :env_override :force_override :automatic}) :[] _)
          PATTERN

          def on_send(node)
            if node_attribute_access?(node) || node_level_attribute_access?(node)
              # node is first child for #[], need to look for the outermost parent too.
              outer_node = node
              while outer_node.parent && outer_node.parent.type == :send && outer_node.parent.children[1] == :[]
                on_node_attribute_access(outer_node.children[2])
                outer_node = outer_node.parent
              end
              # One last time for the outer-most access.
              on_node_attribute_access(outer_node.children[2])
            end
          end

          def on_node_attribute_access(node)
            if node.type == :str
              style_detected(:strings)
              add_offense(node, location: :expression, message: MSG % style, severity: :refactor) if style == :symbols
            elsif node.type == :sym
              style_detected(:symbols)
              add_offense(node, location: :expression, message: MSG % style, severity: :refactor) if style == :strings
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              key_string = node.children.first.to_s
              key_replacement = if style == :symbols
                                  key_string.to_sym.inspect
                                else # strings
                                  key_string.inspect
                                end
              corrector.replace(node.loc.expression, key_replacement)
            end
          end
        end
      end
    end
  end
end
