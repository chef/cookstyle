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
        # Legacy Chef::PartialSearch class usage should be updated to use the `search` helper instead with the `filter_result` key.
        #
        # @example
        #
        #   # bad
        #   ::Chef::PartialSearch.new.search((:node, 'role:web',
        #     keys: { 'name' => [ 'name' ],
        #             'ip' => [ 'ipaddress' ],
        #             'kernel_version' => %w(kernel version),
        #               }
        #   ).each do |result|
        #     puts result['name']
        #     puts result['ip']
        #     puts result['kernel_version']
        #   end
        #
        #   # good
        #   search(:node, 'role:web',
        #     filter_result: { 'name' => [ 'name' ],
        #                      'ip' => [ 'ipaddress' ],
        #                      'kernel_version' => %w(kernel version),
        #               }
        #   ).each do |result|
        #     puts result['name']
        #     puts result['ip']
        #     puts result['kernel_version']
        #   end
        #
        class PartialSearchClassUsage < Cop
          MSG = 'Legacy Chef::PartialSearch class usage should be updated to use the search helper instead with the filter_result key.'.freeze

          def_node_matcher :partial_search_class?, <<-PATTERN
            (send (const (const ... :Chef) :PartialSearch) :new)
          PATTERN

          def on_send(node)
            partial_search_class?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :warning)
            end
          end
        end
      end
    end
  end
end
