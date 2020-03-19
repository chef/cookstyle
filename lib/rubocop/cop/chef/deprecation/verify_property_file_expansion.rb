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
        # In Chef Infra Client 13 the "file" variable for use within the verify property was replaced with the "path" variable.
        #
        # @example
        #
        #   # bad
        #   file '/etc/nginx.conf' do
        #     verify 'nginx -t -c %{file}'
        #   end
        #
        #   # good
        #   file '/etc/nginx.conf' do
        #     verify 'nginx -t -c %{path}'
        #   end
        #
        class VerifyPropertyUsesFileExpansion < Cop
          include RuboCop::Chef::CookbookHelpers

          MSG = "Use the 'path' variable in the verify property and not the 'file' variable which was removed in Chef Infra Client 13.".freeze

          def on_block(node)
            match_property_in_resource?(nil, 'verify', node) do |verify|
              add_offense(verify, location: :expression, message: MSG, severity: :warning) if verify.source.match?(/%{file}/)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, node.loc.expression.source.gsub('%{file}', '%{path}'))
            end
          end
        end
      end
    end
  end
end
