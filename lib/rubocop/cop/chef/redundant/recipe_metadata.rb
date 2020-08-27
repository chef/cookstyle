# frozen_string_literal: true
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
      module ChefRedundantCode
        # The recipe metadata.rb method is not used and is unnecessary in cookbooks. Recipes should be documented in the cookbook's README.md file instead.
        #
        # @example
        #
        #   # bad
        #   recipe 'openldap::default', 'Install and configure OpenLDAP'
        #
        #
        class RecipeMetadata < Base
          include RangeHelp
          include RuboCop::Chef::AutocorrectHelpers
          extend AutoCorrector

          MSG = "The recipe metadata.rb method is not used and is unnecessary in cookbooks. Recipes should be documented in the cookbook's README.md file instead."

          def on_send(node)
            return unless node.method_name == :recipe

            add_offense(node, message: MSG, severity: :refactor) do |corrector|
              corrector.remove(range_with_surrounding_space(range: expression_including_heredocs(node), side: :left))
            end
          end
        end
      end
    end
  end
end
