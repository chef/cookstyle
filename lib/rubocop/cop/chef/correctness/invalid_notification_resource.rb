# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# Author:: Tim Smith (<tsmith84@gmail.com>)
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
      module Correctness
        # The resource to notify when calling `notifies` or `subscribes` must be a string.
        #
        # @example
        #
        #   # bad
        #
        #   template '/etc/www/configures-apache.conf' do
        #     notifies :restart, service['apache'], :immediately
        #   end
        #
        #   template '/etc/www/configures-apache.conf' do
        #     notifies :restart, service[apache], :immediately
        #   end
        #
        #   # good
        #
        #   template '/etc/www/configures-apache.conf' do
        #     notifies :restart, 'service[apache]', :immediately
        #   end
        #
        class InvalidNotificationResource < Base
          MSG = 'The resource to notify when calling `notifies` or `subscribes` must be a string.'
          RESTRICT_ON_SEND = [:notifies, :subscribes].freeze

          def_node_matcher :invalid_notification?, <<-PATTERN
            (send nil? {:notifies :subscribes} (sym _) $(send (send nil? _) :[] ...) ...)
          PATTERN

          def on_send(node)
            invalid_notification?(node) do |resource|
              add_offense(resource, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
