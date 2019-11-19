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
        # Use the new-style notification syntax which allows you to notify resources defined later in a recipe or resource.
        #
        # @example
        #
        #   # bad
        #   template '/etc/www/configures-apache.conf' do
        #     notifies :restart, resources(service: 'apache')
        #   end
        #
        #   template '/etc/www/configures-apache.conf' do
        #     notifies :restart, resources(service: 'apache'), :immediately
        #   end
        #
        #   # good
        #   template '/etc/www/configures-apache.conf' do
        #     notifies :restart, 'service[apache]'
        #   end
        #
        #   template '/etc/www/configures-apache.conf' do
        #     notifies :restart, 'service[apache]', :immediately
        #   end
        #
        class LegacyNotifySyntax < Cop
          MSG = 'Use the new-style notification syntax which allows you to notify resources defined later in a recipe or resource.'.freeze

          def_node_matcher :legacy_notify?, <<-PATTERN
            (send nil? :notifies $(sym _) (send nil? :resources (hash (pair $(sym _) $(...) ) ) ) $... )
          PATTERN

          def on_send(node)
            legacy_notify?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              legacy_notify?(node) do |action, type, name, timing|
                new_val = "notifies #{action.source}, '#{type.source}[#{name.str_type? ? name.value : name.source}]'"
                new_val << ", #{timing.first.source}" unless timing.empty?
                corrector.replace(node.loc.expression, new_val)
              end
            end
          end
        end
      end
    end
  end
end
