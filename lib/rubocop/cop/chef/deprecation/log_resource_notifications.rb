#
# Copyright:: 2020, Chef Software, Inc.
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
        # In Chef Infra Client 16 the log resource no longer notifies when logging so notifications should not be triggered from log resources. See the notify_group functionality for a potential replacement.
        #
        # @example
        #
        #   # bad
        #   template '/etc/foo' do
        #     source 'bar.erb'
        #     notifies :write, 'log[Aggregate notifications using a single log resource]', :immediately
        #   end
        #
        #   log 'Aggregate notifications using a single log resource' do
        #     notifies :restart, 'service[foo]', :delayed
        #   end
        #
        #   # good
        #   template '/etc/foo' do
        #     source 'bar.erb'
        #     notifies :run, 'notify_group[Aggregate notifications using a single notify_group resource]', :immediately
        #   end
        #
        #   notify_group 'Aggregate notifications using a single notify_group resource' do
        #     notifies :restart, 'service[foo]', :delayed
        #   end
        #
        class LogResourceNotifications < Cop
          include RuboCop::Chef::CookbookHelpers

          MSG = 'In Chef Infra Client 16 the log resource no longer notifies when logging so notifications should not be triggered from log resources. Use the notify_group resource instead to aggregate notifications.'.freeze

          def on_block(node)
            match_property_in_resource?(:log, 'notifies', node) do |prop_node|
              add_offense(prop_node, location: :expression, message: MSG, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
