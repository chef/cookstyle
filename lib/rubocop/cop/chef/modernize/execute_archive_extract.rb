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
      module Modernize
        # Use the archive_file resource built into Chef Infra Client 15+ instead of shelling out to
        # tar or unzip. The resource extracts tar, tar.gz, tar.bz2, tar.xz, and zip archives, and it
        # only runs when the archive is newer than what was already extracted, where the shelled out
        # command re-extracts on every converge.
        #
        # @example
        #
        #   # bad
        #   execute 'extract nginx' do
        #     command "tar xzf #{Chef::Config[:file_cache_path]}/nginx.tar.gz -C /opt/nginx"
        #   end
        #
        #   execute 'unzip -o /tmp/app.zip -d /opt/app'
        #
        #   # good
        #   archive_file 'extract nginx' do
        #     path "#{Chef::Config[:file_cache_path]}/nginx.tar.gz"
        #     destination '/opt/nginx'
        #   end
        #
        class ExecuteArchiveExtract < Base
          include RuboCop::Chef::CookbookHelpers
          extend TargetChefVersion

          minimum_target_chef_version '15.0'

          MSG = 'Use the archive_file resource built into Chef Infra Client 15+ instead of shelling out to tar or unzip'
          RESTRICT_ON_SEND = [:execute].freeze

          # `tar` extracts when its short flags include an x, or with the --extract long option.
          # Anchoring the flag cluster directly after `tar` keeps `tar czf` (create), `tar tzf`
          # (list), and `tar --exclude=.git -czf` from matching, since none of those put an x
          # in the first cluster.
          EXTRACT_COMMAND = %r{
            \A\s*(?:\S*/)?(?:
              tar\s+(?:-)?[a-z]*x[a-z]*(?:\s|\z) |  # tar xzf / tar -xzf / tar zxvf
              tar\s+--extract\b                  |  # tar --extract --file
              unzip(?:\s|\z)                        # unzip -o foo.zip -d /opt
            )
          }xi.freeze

          # the shell resources whose script lives in a code property
          SCRIPT_RESOURCES = %i(bash sh csh ksh zsh script).freeze

          # A command that chains, pipes, or substitutes is doing more than extracting, so
          # archive_file cannot replace it wholesale and the suggestion would be wrong.
          SHELL_OPERATORS = ['&&', '||', ';', '|', '`', '$(', "\n"].freeze

          def on_send(node)
            command = node.arguments.first
            return unless command&.str_type? && extracts_archive?(command.value)

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
            add_offense(node, severity: :refactor) if command && extracts_archive?(command)
          end

          # @param [String] command
          #
          # @return [Boolean]
          def extracts_archive?(command)
            return false if SHELL_OPERATORS.any? { |operator| command.include?(operator) }

            EXTRACT_COMMAND.match?(command)
          end
        end
      end
    end
  end
end
