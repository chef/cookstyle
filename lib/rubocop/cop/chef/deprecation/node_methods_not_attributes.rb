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
      module ChefDeprecations
        # Use node attributes to access data provided by Ohai instead of using node methods to access that data.
        #
        # @example
        #
        #   # bad
        #   node.fqdn
        #   node.platform
        #   node.platform_family
        #   node.platform_version
        #   node.hostname
        #
        #   # good
        #   node['fqdn']
        #   node['platform']
        #   node['platform_family']
        #   node['platform_version']
        #   node['hostname']
        #
        class NodeMethodsInsteadofAttributes < Base
          extend AutoCorrector

          MSG = 'Use node attributes to access Ohai data instead of node methods, which were deprecated in Chef Infra Client 13.'

          def_node_matcher :node_ohai_methods?, <<-PATTERN
            (send (send nil? :node) #non_nested_ohai_attribute?)
          PATTERN

          def on_send(node)
            node_ohai_methods?(node) do
              add_offense(node.loc.selector, message: MSG, severity: :warning) do |corrector|
                corrector.replace(node.loc.expression, "node['#{node.method_name}']")
              end
            end
          end

          private

          def non_nested_ohai_attribute?(attribute)
            %i(
              current_user
              domain
              fqdn
              hostname
              ip6address
              ipaddress
              macaddress
              machinename
              ohai_time
              os
              os_version
              platform
              platform_build
              platform_family
              platform_version
              root_group
              shard_seed
              uptime
              uptime_seconds).include?(attribute)
          end
        end
      end
    end
  end
end
