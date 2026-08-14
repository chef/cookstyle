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
        # The two resources are not interchangeable and the one you pick has to match what is on disk.
        # `directory` asserts the path really is a directory before deleting, so it raises
        # `Cannot delete directory[...]` on a file even with `recursive true`, and `file` calls
        # `File.delete`, so it raises `Errno::EISDIR` on a directory. A `directory` delete also needs
        # `recursive true` for anything that isn't empty, or it raises `Errno::ENOTEMPTY`.
        #
        # Only a single `rm` of one path is flagged. A command containing a glob, a shell operator, or
        # anything beyond the one deletion is left alone, since the `file` and `directory` resources
        # can't express those.
        #
        # @example
        #
        #   # bad -- rm without -r, which the shell will not let you point at a directory
        #   execute 'rm /etc/foo.conf'
        #
        #   # good
        #   file '/etc/foo.conf' do
        #     action :delete
        #   end
        #
        #   # bad -- a recursive rm of a directory
        #   execute 'delete the thing' do
        #     command 'rm -rf /opt/thing'
        #   end
        #
        #   # good
        #   directory '/opt/thing' do
        #     recursive true
        #     action :delete
        #   end
        #
        class ExecuteDeleteFile < Base
          include RuboCop::Chef::CookbookHelpers

          # The two resources are not interchangeable, so the message has to name the right one.
          # `directory` asserts the path really is a directory before deleting, and `file` calls
          # File.delete, so pointing at the wrong one fails the converge rather than doing nothing.
          FILE_MSG = 'Use the `file` resource with the :delete action to remove a file instead of shelling out to rm'
          DIRECTORY_MSG = 'Use the `directory` resource with `recursive true` and the :delete action to remove a directory instead of shelling out to rm. Use the `file` resource instead if the path is a file.'

          RESTRICT_ON_SEND = [:execute].freeze

          # a lone rm of a single path: optional flags, one target, nothing else on the line.
          # the target excludes the shell metacharacters used for substitution and expansion, since
          # a path the shell computes at runtime isn't something the file/directory resources can take
          DELETE_COMMAND = %r{\A\s*(?:/bin/|/usr/bin/)?rm\s+(?<flags>(?:-[a-zA-Z]+\s+)*)(?<path>[^\s;&|<>$`(){}]+)\s*\z}.freeze

          # the shell resources whose script lives in a code property
          SCRIPT_RESOURCES = %i(bash sh csh ksh zsh).freeze

          def_node_matcher :execute_with_command_name?, '(send nil? :execute (str $_))'

          def on_send(node)
            execute_with_command_name?(node) do |command|
              message = message_for(command)
              add_offense(node, message: message, severity: :refactor) if message
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
            return unless command

            message = message_for(command)
            add_offense(node, message: message, severity: :refactor) if message
          end

          # Does the command do nothing but delete one named path, and if so which resource replaces
          # it? Globs are excluded because the file and directory resources take a single path rather
          # than a pattern.
          #
          # Without -r the shell refuses to remove a directory, so a bare `rm` provably targets a
          # file and `file` is the right answer. With -r the author is removing a tree, so
          # `directory` is, though the path could still be a file that -rf was used on out of habit.
          #
          # @param [String] command
          #
          # @return [String, nil] the message to report, or nil when this isn't a simple delete
          def message_for(command)
            match = DELETE_COMMAND.match(command)
            return if match.nil?
            return if match[:path].match?(/[*?\[]/)

            match[:flags].match?(/-[a-zA-Z]*r/i) ? DIRECTORY_MSG : FILE_MSG
          end
        end
      end
    end
  end
end
