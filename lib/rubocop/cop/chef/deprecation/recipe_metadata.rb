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
        # The recipe metadata.rb method is not used and is unnecessary in cookbooks. Recipes should be documented
        # in the README.md file instead.
        #
        # @example
        #
        #   # bad
        #   recipe 'openldap::default', 'Install and configure OpenLDAP'
        #
        #
        class RecipeMetadata < Cop
          MSG = 'The recipe metadata.rb method is not used and is unnecessary in cookbooks. Recipes should be documented in the README.md file instead.'.freeze

          def on_send(node)
            add_offense(node, location: :expression, message: MSG, severity: :refactor) if node.method_name == :recipe
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.remove(node.loc.expression)
            end
          end
        end
      end
    end
  end
end
