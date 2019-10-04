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
      module ChefDeprecations
        # A custom resource property can't be marked as a name_property and also have a default value. The name property is a special property that is derived from the name of the resource block in and thus always has a value passed to the resource. For example if you define `my_resource 'foo'` in recipe, then the name property of `my_resource` will automatically be set to `foo`. Setting a property to be both a name_property and have a default value will cause Chef Infra Client failures in 13.0 and later releases.
        #
        # @example
        #
        #   # bad
        #   property :config_file, String, default: 'foo', name_property: true
        #
        #   # good
        #   property :config_file, String, name_property: true
        #
        class NamePropertyWithDefaultValue < Cop
          MSG = "A resource property can't be marked as a name_property and also have a default value. This will fail in Chef Infra Client 13 or later.".freeze

          def on_send(node)
            if default_value?(node) && property_is_name_property?(node)
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          private

          def property_is_name_property?(node)
            if node.method_name == :property
              node.arguments.each do |arg|
                if arg.type == :hash
                  return true if arg.source.match?(/name_property:\s*true/)
                end
              end
              false # no required: true found
            end
          end

          def default_value?(node)
            if node.method_name == :property
              node.arguments.each do |arg|
                if arg.type == :hash
                  return true if arg.source.match?(/default:\s/)
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
