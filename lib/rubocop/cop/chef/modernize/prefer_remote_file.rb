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
        #
        # Use the `remote_file` resource instead of `curl` or `wget` commands.
        # Chef's native resources are idempotent, support retries, and handle
        # authentication securely. Shell commands lack these guarantees.
        #
        # @example
        #
        #   # bad
        #   execute 'curl -k https://example.com/install.sh | bash'
        #
        #   # bad
        #   execute 'wget https://example.com/file.tar.gz'
        #
        #   # good
        #   remote_file '/tmp/file.tar.gz' do
        #     source 'https://example.com/file.tar.gz'
        #     mode '0644'
        #   end
        #
        class PreferRemoteFile < Base
          include RuboCop::Chef::CookbookHelpers

          MSG = 'Use the `remote_file` resource instead of `curl` or `wget`. ' \
                'Native resources ensure idempotence, support retries, and handle permissions correctly.'

          RESOURCE_METHODS = %i(execute bash csh ksh perl python ruby powershell_script).freeze
          RESTRICT_ON_SEND = RESOURCE_METHODS
          PROPERTY_METHODS = %i(command code).freeze

          # Matches 'curl' or 'wget' as whole words to avoid false positives (e.g., 'libcurl')
          # Regex: start-of-string OR whitespace, then curl/wget, then whitespace OR end-of-string
          DOWNLOAD_COMMAND_REGEX = /(?:^|\s)(?:curl|wget)(?:\s|$)/.freeze

          def on_send(node)
            check_offense(node, node.first_argument)
          end

          def on_block(node)
            return unless RESOURCE_METHODS.include?(node.send_node.method_name)

            match_property_in_resource?(RESOURCE_METHODS, PROPERTY_METHODS, node) do |property_node|
              check_offense(property_node, property_node.first_argument)
            end
          end

          private

          def check_offense(node, string_node)
            return unless string_node&.str_type?
            return unless string_node.value.match?(DOWNLOAD_COMMAND_REGEX)

            add_offense(node)
          end
        end
      end
    end
  end
end
