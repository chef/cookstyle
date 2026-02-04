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
        # @example
        #
        #   ### incorrect
        #   execute 'curl https://example.com/file.tar.gz -o /tmp/file.tar.gz'
        #
        #   execute 'download' do
        #     command 'curl https://example.com/file.tar.gz -o /tmp/file.tar.gz'
        #   end
        #
        #   execute 'fetch_file' do
        #     command 'wget https://example.com/app.tar.gz -O /tmp/app.tar.gz'
        #   end
        #
        #   bash 'download_script' do
        #     code 'curl https://example.com/install.sh -o /tmp/install.sh'
        #   end
        #
        #   ### correct
        #   remote_file '/tmp/file.tar.gz' do
        #     source 'https://example.com/file.tar.gz'
        #   end
        #
        #   remote_file '/tmp/app.tar.gz' do
        #     source 'https://example.com/app.tar.gz'
        #     checksum 'sha256checksum'
        #   end
        #
        class PreferRemoteFile < Base
          MSG = 'Use the `remote_file` resource instead of curl/wget in execute resources. ' \
                'The `remote_file` resource provides better idempotency, error handling, and checksum verification.'

          # Match curl or wget as whole words in a command
          CURL_WGET_REGEX = /\b(curl|wget)\b/.freeze

          # Resources that can execute shell commands
          SHELL_RESOURCES = %i[execute bash powershell_script sh csh perl python ruby zsh].freeze

          def on_send(node)
            return unless node.arguments?

            # Check if this is a shell resource call
            if SHELL_RESOURCES.include?(node.method_name)
              # Check the first argument (resource name which may contain the command)
              first_arg = node.first_argument
              if first_arg&.str_type? && curl_or_wget_command?(first_arg.value)
                add_offense(first_arg)
              end
            end

            # Check command/code properties inside blocks
            if %i[command code].include?(node.method_name)
              first_arg = node.first_argument
              if first_arg&.str_type? && curl_or_wget_command?(first_arg.value)
                add_offense(first_arg)
              end
            end
          end

          private

          def curl_or_wget_command?(command_string)
            return false unless command_string

            command_string.match?(CURL_WGET_REGEX)
          end
        end
      end
    end
  end
end
