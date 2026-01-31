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
      module Security
        # Do not use curl or wget with flags that disable SSL/TLS certificate verification.
        # These flags (-k, --insecure for curl, --no-check-certificate for wget) prevent
        # the client from verifying the identity of the remote server, making the connection
        # vulnerable to Man-in-the-Middle attacks. Instead of disabling verification,
        # ensure the remote host has a valid certificate, provide a CA bundle, or use
        # Chef's `remote_file` resource for secure downloads.
        #
        # @example
        #
        #   ### incorrect
        #   execute 'curl -k https://example.com/install.sh | bash'
        #
        #   execute 'download' do
        #     command 'curl --insecure https://example.com/file.tar.gz -o /tmp/file.tar.gz'
        #   end
        #
        #   bash 'fetch_file' do
        #     code 'wget --no-check-certificate https://example.com/app.tar.gz'
        #   end
        #
        #   ### correct
        #   remote_file '/tmp/file.tar.gz' do
        #     source 'https://example.com/file.tar.gz'
        #   end
        #
        #   execute 'curl https://example.com/install.sh -o /tmp/install.sh'
        #
        #   execute 'wget https://example.com/file.tar.gz -O /tmp/file.tar.gz'
        #
        class InsecureCurlWgetDownload < Base
          MSG = 'Do not use curl/wget with insecure flags that disable SSL certificate verification (-k, --insecure, --no-check-certificate). This makes downloads vulnerable to Man-in-the-Middle (MITM) attacks. Use Chef\'s `remote_file` resource for secure downloads or ensure proper SSL certificates are configured.'

          # This single regex looks for `curl` or `wget` as a whole word,
          # followed by anything, then one of the insecure flags.
          # We use (?:^|\s) and (?:\s|$) for flag boundaries since - is not a word char.
          INSECURE_COMMAND_REGEX = /\b(curl|wget)\b.*(?:^|\s)(-k|--insecure|--no-check-certificate)(?:\s|$)/.freeze

          # Resources that can execute shell commands
          SHELL_RESOURCES = %i[execute bash powershell_script sh csh perl python ruby zsh].freeze

          def on_send(node)
            return unless node.arguments?

            # Check if this is a shell resource call
            if SHELL_RESOURCES.include?(node.method_name)
              # Check the first argument (resource name which may contain the command)
              first_arg = node.first_argument
              if first_arg&.str_type? && insecure_command?(first_arg.value)
                add_offense(first_arg)
              end
            end

            # Check command/code properties inside blocks
            if %i[command code].include?(node.method_name)
              first_arg = node.first_argument
              if first_arg&.str_type? && insecure_command?(first_arg.value)
                add_offense(first_arg)
              end
            end
          end

          private

          def insecure_command?(command_string)
            return false unless command_string

            command_string.match?(INSECURE_COMMAND_REGEX)
          end
        end
      end
    end
  end
end