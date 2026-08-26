# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# Author:: Tim Smith (<tsmith84@proton.me>)
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
        # Use the `service` resource to manage services instead of shelling out. The resource is
        # idempotent, picks the right init system for the platform, and reports correctly on what it
        # changed. A shelled out command runs on every converge whether or not anything needed to
        # change, so the run reports the resource as updated every time.
        #
        # @example
        #
        #   # bad
        #   execute 'restart apache' do
        #     command 'systemctl restart httpd'
        #   end
        #
        #   execute '/etc/init.d/httpd start'
        #
        #   # good
        #   service 'httpd' do
        #     action :restart
        #   end
        #
        class ServiceResource < Base
          MSG = 'Use the service resource to manage services instead of shelling out to an init script, service, systemctl, or a similar tool'
          RESTRICT_ON_SEND = %i(command code execute).freeze

          # the state changing verbs. `status` is left out: a status check is usually a guard rather
          # than something the service resource replaces
          SERVICE_ACTIONS = %w(
            start stop restart reload force-reload try-restart reload-or-restart
            enable disable mask unmask
          ).freeze

          # commands whose service action is captured and checked against SERVICE_ACTIONS
          ACTION_COMMANDS = [
            %r{\A/(?:etc/init\.d|etc/rc\.d|usr/local/etc/rc\.d)/\S+\s+(\S+)}, # /etc/init.d/httpd start
            %r{\A(?:/usr/sbin/|/sbin/)?service\s+\S+\s+(\S+)},                # service httpd start
            %r{\A(?:/usr/bin/|/bin/)?systemctl\s+(?:--\S+\s+)*(\S+)\s+\S+},   # systemctl start httpd
            /\Ainvoke-rc\.d\s+\S+\s+(\S+)/,                                   # invoke-rc.d httpd start
            /\Ainitctl\s+(\S+)\s+\S+/,                                        # initctl start httpd
            /\Asvcadm\s+(\S+)\s+\S+/,                                         # svcadm enable httpd
          ].freeze

          # commands that manage a service whatever the rest of the line says
          DIRECT_COMMANDS = [
            /\A(?:start|stop|restart)\s+\S+\z/,                               # upstart: start httpd
            /\Alaunchctl\s+(?:load|unload|start|stop|enable|disable|bootstrap|bootout)\s/,
            /\Achkconfig\s+(?:--\S+\s+)*\S+\s+(?:on|off)\z/,                  # chkconfig httpd on
            /\Aupdate-rc\.d\s/,                                               # update-rc.d httpd defaults
            /\A(?:sc|net)\s+(?:start|stop|config)\s+\S+/i,                    # windows: net start httpd
          ].freeze

          # a command doing more than the one service action can't be swapped for the resource
          SHELL_OPERATORS = ['&&', '||', ';', '|', '`', '$('].freeze

          def_node_matcher :command_property?, '(send nil? {:command :code} $str)'
          def_node_matcher :execute_with_command_name?, '(send nil? :execute $str)'

          def on_send(node)
            command_property?(node) do |command|
              add_offense(command, severity: :refactor) if manages_service?(command.value)
            end

            execute_with_command_name?(node) do |command|
              add_offense(node, severity: :refactor) if manages_service?(command.value)
            end
          end

          private

          # @param [String] command the literal command string
          #
          # @return [Boolean]
          def manages_service?(command)
            cmd = command.strip
            return false if SHELL_OPERATORS.any? { |operator| cmd.include?(operator) }

            ACTION_COMMANDS.each do |pattern|
              match = pattern.match(cmd)
              return true if match && SERVICE_ACTIONS.include?(match[1].downcase)
            end

            DIRECT_COMMANDS.any? { |pattern| cmd.match?(pattern) }
          end
        end
      end
    end
  end
end
