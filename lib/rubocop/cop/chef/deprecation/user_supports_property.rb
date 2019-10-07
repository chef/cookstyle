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
      module ChefDeprecations
        # The supports property was removed in Chef Infra Client 13 in favor of individual 'manage_home' and 'non_unique' properties.
        #
        # @example
        #
        #   # bad
        #   user "betty" do
        #     supports({
        #       manage_home: true,
        #       non_unique: true
        #     })
        #   end
        #
        #   # good
        #   user "betty" do
        #     manage_home true
        #     non_unique true
        #   end
        #
        class UserDeprecatedSupportsProperty < Cop
          include RuboCop::Chef::CookbookHelpers

          MSG = "The supports property was removed in Chef Infra Client 13 in favor of individual 'manage_home' and 'non_unique' properties.".freeze

          def on_block(node)
            match_property_in_resource?(:user, 'supports', node) do |property|
              add_offense(property, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              new_text = []
              node.arguments.first.each_pair do |k, v|
                new_text << "#{k.source} #{v.source}"
              end

              corrector.replace(node.loc.expression, new_text.join("\n  "))
            end
          end
        end
      end
    end
  end
end
