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
        # Use Chef's `remote_file` resource instead of curl or wget commands in execute
        # resources. The `remote_file` resource provides better error handling, idempotency,
        # checksum verification, and integrates properly with Chef's resource model.
        #
        # NOTE: This cop does NOT provide autocorrection because:
        # 1. `curl | bash` patterns execute scripts in memory - replacing with `remote_file`
        #    would change behavior (download to disk instead of execute in memory)
        # 2. curl/wget commands often have complex flags, authentication headers, or
        #    redirects that cannot be automatically translated to `remote_file` properties
        # 3. Some commands pipe output or process data streams that `remote_file` cannot handle
        #
        # @example
        #
        #   ### incorrect
        #   execute 'curl https://example.com/file.tar.gz -o /tmp/file.tar.gz'
        #
        #   execute 'download' do
        #     command 'curl https://example.com/file.tar.gz -o /tmp/file.tar.gz'
        #   end
        #
        #   bash 'fetch_file' do
        #     code 'wget https://example.com/app.tar.gz -O /tmp/app.tar.gz'
        #   end
        #
        #   # This pattern is detected but CANNOT be auto-corrected safely
        #   execute 'curl https://example.com/install.sh | bash'
        #
        #   ### correct
        #   remote_file '/tmp/file.tar.gz' do
        #     source 'https://example.com/file.tar.gz'
        #     checksum 'sha256checksum'
        #   end
        #
        #   remote_file '/tmp/app.tar.gz' do
        #     source 'https://example.com/app.tar.gz'
        #     owner 'root'
        #     group 'root'
        #     mode '0644'
        #   end
        #
        class PreferRemoteFile < Base
          # SAFETY: AutoCorrector is intentionally NOT included.
          # Reason: Patterns like `curl | bash` execute scripts in memory. Converting
          # to `remote_file` would download to disk instead, breaking functionality.
          # Additionally, complex curl/wget flags cannot be reliably translated to
          # remote_file properties. Manual review and refactoring is required.

          MSG = 'Use the `remote_file` resource instead of curl/wget in execute resources. ' \
                'The `remote_file` resource provides better idempotency, error handling, and checksum verification.'

          # Match curl or wget as whole words only (avoids false positives like curl-config, libcurl)
          CURL_WGET_REGEX = /\b(curl|wget)\b/.freeze

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
            return unless curl_or_wget_command?(first_arg.value)

            add_offense(first_arg)
          end

          def check_command_property(node)
            first_arg = node.first_argument
            return unless first_arg&.str_type?
            return unless curl_or_wget_command?(first_arg.value)

            add_offense(first_arg)
          end

          def curl_or_wget_command?(command_string)
            return false unless command_string

            command_string.match?(CURL_WGET_REGEX)
          end
        end
      end
    end
  end
end
