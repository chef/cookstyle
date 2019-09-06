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
        # The local resource's lc_all property has been deprecated and will be removed in Chef Infra Client 16
        #
        # @example
        #
        #   # bad
        #   locale 'set locale' do
        #     lang 'en_gb.utf-8'
        #     lc_all 'en_gb.utf-8'
        #   end
        #
        class LocaleDeprecatedLcAllProperty < Cop
          include RuboCop::Chef::CookbookHelpers

          MSG = "The local resource's lc_all property has been deprecated and will be removed in Chef Infra Client 16".freeze

          def on_block(node)
            match_property_in_resource?(:locale, 'lc_all', node) do |property|
              add_offense(property, location: :expression, message: MSG, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
