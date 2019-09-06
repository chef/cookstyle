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
        # Use the :remove action in the chocolatey_package resource instead of :uninstall which was removed in Chef Infra Client 14+
        #
        # @example
        #
        #   # bad
        #   chocolatey_package 'nginx' do
        #     action :uninstall
        #   end
        #
        #   # good
        #   chocolatey_package 'nginx' do
        #     action :remove
        #   end
        #
        class ChocolateyPackageUninstallAction < Cop
          include RuboCop::Chef::CookbookHelpers

          MSG = 'Use the :remove action in the chocolatey_package resource instead of :uninstall which was removed in Chef Infra Client 14+'.freeze

          def on_block(node)
            match_property_in_resource?(:chocolatey_package, 'action', node) do |choco_action|
              choco_action.arguments.each do |action|
                add_offense(action, location: :expression, message: MSG, severity: :refactor) if action.source == ':uninstall'
              end
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, ':remove')
            end
          end
        end
      end
    end
  end
end
