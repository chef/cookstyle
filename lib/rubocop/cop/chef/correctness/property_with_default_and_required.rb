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
        # When using properties in a custom resource you shouldn't set a property to
        # required and then provide a default value. If a property is required the
        # user will always pass in a value and the default will never be used. In Chef
        # Infra Client 13+ this became an error.
        #
        # @example
        #
        #   # bad
        #   property :bob, String, required: true, default: 'foo'
        #
        #   # good
        #   property :bob, String, required: true
        #
        class PropertyWithRequiredAndDefault < Cop
          MSG = 'Resource property should not be both required and have a default value. This will fail on Chef Infra Client 13+'.freeze

          def on_send(node)
            if required_property?(node) && property_has_default?(node)
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          private

          def required_property?(node)
            if node.method_name == :property
              node.arguments.each do |arg|
                if arg.type == :hash
                  return true if arg.source.match?(/required:\s*true/)
                end
              end
              false # no required: true found
            end
          end

          def property_has_default?(node)
            if node.method_name == :property
              node.arguments.each do |arg|
                if arg.type == :hash
                  return true if arg.source.match?(/default:/)
                end
              end
              false # no default: found
            end
          end
        end
      end
    end
  end
end
