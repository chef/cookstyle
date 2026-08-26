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
      module Modernize
        # Chef Infra Client 16.0 and later includes an `alternatives` resource that should be used to
        # manage alternatives links instead of shelling out to `update-alternatives` or `alternatives`.
        # The resource is idempotent and handles both the Debian and RHEL flavours of the command, where
        # an `execute` re-runs on every converge and reports the resource as updated every time.
        #
        # @example
        #
        #   # bad
        #   execute 'install java alternative' do
        #     command 'update-alternatives --install /usr/bin/java java /usr/lib/jvm/jre-11/bin/java 1'
        #   end
        #
        #   execute 'alternatives --set java /usr/lib/jvm/jre-11/bin/java'
        #
        #   # good
        #   alternatives 'java' do
        #     link '/usr/bin/java'
        #     path '/usr/lib/jvm/jre-11/bin/java'
        #     priority 1
        #     action :install
        #   end
        #
        class ExecuteUpdateAlternatives < Base
          include RuboCop::Chef::CookbookHelpers
          extend TargetChefVersion

          minimum_target_chef_version '16.0'

          MSG = 'Chef Infra Client 16.0 and later includes an alternatives resource that should be used to manage alternatives links instead of shelling out to update-alternatives or alternatives'
          RESTRICT_ON_SEND = [:execute].freeze

          # Debian ships update-alternatives and RHEL ships alternatives, and the resource drives both.
          # Matching is limited to the four subcommands the resource can express: --install, --set,
          # --auto, and --remove. The rest are deliberately left alone -- --config and --display are
          # interactive or read only, and --remove-all has no resource equivalent.
          ALTERNATIVES_COMMAND = %r{
            \A\s*(?:/usr/sbin/|/usr/bin/|/sbin/|/bin/)?  # an optional absolute path to the binary
            (?:update-)?alternatives\s+
            --(?:install|set|auto|remove(?!-all))\b
          }x.freeze

          # the shell resources whose script lives in a code property
          SCRIPT_RESOURCES = %i(bash sh csh ksh zsh).freeze

          def on_send(node)
            command = node.arguments.first
            return unless command&.str_type? && manages_alternatives?(command.value)

            add_offense(node, severity: :refactor)
          end

          def on_block(node)
            match_property_in_resource?(:execute, 'command', node) do |property|
              report_property(node, property)
            end

            match_property_in_resource?(SCRIPT_RESOURCES, 'code', node) do |property|
              report_property(node, property)
            end
          end

          private

          def report_property(node, property)
            command = method_arg_ast_to_string(property)
            add_offense(node, severity: :refactor) if command && manages_alternatives?(command)
          end

          # @param [String] command
          #
          # @return [Boolean]
          def manages_alternatives?(command)
            ALTERNATIVES_COMMAND.match?(command)
          end
        end
      end
    end
  end
end
