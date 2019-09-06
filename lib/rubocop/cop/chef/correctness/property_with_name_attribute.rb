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
        # When using properties in a custom resource you should use name_property not
        # the legacy name_attribute from the days of attributes
        #
        # @example
        #
        #   # bad
        #   property :bob, String, name_attribute: true
        #
        #   # good
        #   property :bob, String, name_property: true
        #
        class PropertyWithNameAttribute < Cop
          MSG = 'Resource property sets name_attribute not name_property'.freeze

          def on_send(node)
            add_offense(node, location: :expression, message: MSG, severity: :refactor) if attribute_method_mix?(node)
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, node.source.gsub('name_attribute', 'name_property'))
            end
          end

          private

          def attribute_method_mix?(node)
            if node.method_name == :property
              node.arguments.each do |arg|
                if arg.type == :hash
                  return true if arg.source.match?(/name_attribute:/)
                end
              end
              false # no name_attribute found
            end
          end
        end
      end
    end
  end
end
