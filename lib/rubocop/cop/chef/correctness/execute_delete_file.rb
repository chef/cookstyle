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
        # Use the `file` or `directory` resources built into Chef Infra Client with the `:delete` action
        # to remove files and directories instead of shelling out to `rm`. The resources are idempotent,
        # report correctly on what they changed, and work without a shell.
        #
        # Only a single `rm` of one path is flagged. A command containing a glob, a shell operator, or
        # anything beyond the one deletion is left alone, since the `file` and `directory` resources
        # can't express those.
        #
        # @example
        #
        #   # bad
        #   execute 'delete the thing' do
        #     command 'rm -rf /opt/thing'
        #   end
        #
        #   execute 'rm -rf /opt/thing'
        #
        #   # good
        #   directory '/opt/thing' do
        #     recursive true
        #     action :delete
        #   end
        #
        class ExecuteDeleteFile < Base
          include RuboCop::Chef::CookbookHelpers

          MSG = 'Use the `file` or `directory` resources built into Chef Infra Client with the :delete action to remove files/directories instead of shelling out to rm'
          RESTRICT_ON_SEND = [:execute].freeze

          # a lone rm of a single path: optional flags, one target, nothing else on the line.
          # the target excludes the shell metacharacters used for substitution and expansion, since
          # a path the shell computes at runtime isn't something the file/directory resources can take
          DELETE_COMMAND = %r{\A\s*(?:/bin/|/usr/bin/)?rm\s+(?:-[a-zA-Z]+\s+)*(?<path>[^\s;&|<>$`(){}]+)\s*\z}.freeze

          # the shell resources whose script lives in a code property
          SCRIPT_RESOURCES = %i(bash sh csh ksh zsh).freeze

          def_node_matcher :execute_with_command_name?, '(send nil? :execute (str $_))'

          def on_send(node)
            execute_with_command_name?(node) do |command|
              add_offense(node, severity: :refactor) if simple_delete?(command)
            end
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
            add_offense(node, severity: :refactor) if command && simple_delete?(command)
          end

          # Does the command do nothing but delete one named path? Globs are excluded because the
          # file and directory resources take a single path rather than a pattern.
          #
          # @param [String] command
          #
          # @return [Boolean]
          def simple_delete?(command)
            match = DELETE_COMMAND.match(command)
            return false unless match

            !match[:path].match?(/[*?\[]/)
          end
        end
      end
    end
  end
end
