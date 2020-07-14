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
        # Use provider_for_action instead of the deprecated Chef::Platform methods in resources, which were removed in Chef Infra Client 13.
        #
        # @example
        #
        #   # bad
        #   resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
        #   provider = Chef::Platform.provider_for_resource(resource, :create)
        #
        #   resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
        #   provider = Chef::Platform.find_provider("ubuntu", "16.04", resource)
        #
        #   resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
        #   provider = Chef::Platform.find_provider_for_node(node, resource)
        #
        #   # good
        #   resource = Chef::Resource::File.new("/tmp/foo.xyz", run_context)
        #   provider = resource.provider_for_action(:create)
        #
        class DeprecatedPlatformMethods < Cop
          MSG = 'Use provider_for_action instead of the deprecated Chef::Platform methods in resources, which were removed in Chef Infra Client 13.'

          def_node_matcher :platform_method?, <<-PATTERN
            (send (const (const nil? :Chef) :Platform) {:provider_for_resource :find_provider :find_provider_for_node} ... )
          PATTERN

          def on_send(node)
            platform_method?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :warning)
            end
          end
        end
      end
    end
  end
end
