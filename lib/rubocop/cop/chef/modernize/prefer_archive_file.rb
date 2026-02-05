# frozen_string_literal: true
#
# Copyright:: 2024-2026, Chef Software, Inc.
# Author:: Suhas Kumar
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
        # Use Chef's `archive_file` resource instead of shelling out to tar, unzip, gunzip,
        # gzip, or 7z commands in execute or bash resources. The `archive_file` resource
        # (available since Chef Infra Client 15.0) provides better idempotency, error handling,
        # and integrates properly with Chef's resource model.
        #
        # NOTE: This cop does NOT provide autocorrection because:
        # 1. Archive commands have complex flag combinations (-xzf, -cvf, etc.) that cannot
        #    be reliably translated to `archive_file` properties
        # 2. Some tar commands create archives (tar -cvf) while others extract (tar -xvf)
        # 3. Piped commands like `curl | tar` require manual refactoring to separate resources
        # 4. Commands may include pre/post processing that `archive_file` cannot replicate
        #
        # @example
        #
        #   ### incorrect
        #   execute 'tar -xzf /tmp/app.tar.gz -C /opt'
        #
        #   execute 'extract_archive' do
        #     command 'tar -xvf /tmp/package.tar -C /usr/local'
        #   end
        #
        #   bash 'unzip_file' do
        #     code 'unzip -o /tmp/app.zip -d /opt/app'
        #   end
        #
        #   execute 'gunzip /tmp/data.gz'
        #
        #   execute '7z x /tmp/archive.7z -o/opt/app'
        #
        #   ### correct
        #   archive_file '/tmp/app.tar.gz' do
        #     destination '/opt'
        #   end
        #
        #   archive_file '/tmp/package.tar' do
        #     destination '/usr/local'
        #     overwrite true
        #   end
        #
        #   archive_file '/tmp/app.zip' do
        #     destination '/opt/app'
        #     overwrite :auto
        #   end
        #
        class PreferArchiveFile < Base
          # SAFETY: AutoCorrector is intentionally NOT included.
          # Reason: Archive commands have complex flag combinations (tar -xzf vs tar -cvf,
          # unzip -o, 7z x vs 7z a) that cannot be reliably translated to archive_file
          # properties. Some commands create archives while others extract them, and piped
          # commands require manual decomposition. Manual review is required.

          MSG = 'Use the `archive_file` resource instead of tar/unzip/gunzip/gzip/7z commands ' \
                'in execute resources. The `archive_file` resource (Chef Infra Client 15.0+) ' \
                'provides better idempotency and error handling.'

          # Match archive commands only when used as commands, not as file extensions
          # Pattern matches: start of string, after space, after path separator (/), or after pipe (|)
          # Followed by: space (for arguments), end of string, or another command separator
          # This avoids false positives like '.tar.gz', 'tarball', 'unzipped'
          ARCHIVE_CMD_REGEX = %r{(?:^|[\s/|])(?:tar|unzip|gunzip|gzip|7z)(?:\s|$|;|\|)}.freeze

          # Performance optimization: Only trigger on_send for these shell resource methods
          # and the command/code property setters
          RESTRICT_ON_SEND = %i(execute bash powershell_script sh csh perl python ruby zsh command code).freeze

          def on_send(node)
            return unless node.arguments?

            method = node.method_name

            # Check if this is a shell resource call (execute, bash, etc.)
            if shell_resource?(method)
              check_resource_name(node)
            # Check command/code properties inside resource blocks
            elsif command_property?(method)
              check_command_property(node)
            end
          end

          private

          def shell_resource?(method)
            %i(execute bash powershell_script sh csh perl python ruby zsh).include?(method)
          end

          def command_property?(method)
            %i(command code).include?(method)
          end

          def check_resource_name(node)
            first_arg = node.first_argument
            return unless first_arg&.str_type?
            return unless archive_command?(first_arg.value)

            add_offense(first_arg)
          end

          def check_command_property(node)
            first_arg = node.first_argument
            return unless first_arg&.str_type?
            return unless archive_command?(first_arg.value)

            add_offense(first_arg)
          end

          def archive_command?(command_string)
            return false unless command_string

            command_string.match?(ARCHIVE_CMD_REGEX)
          end
        end
      end
    end
  end
end
