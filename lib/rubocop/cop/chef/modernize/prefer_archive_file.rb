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
        # Use the `archive_file` resource (Chef 15+) instead of shell commands
        # like `tar`, `unzip`, or `7z`. Native resources handle idempotence
        # and support various archive formats automatically.
        #
        # @example
        #
        #   # bad
        #   execute 'tar -xzf package.tar.gz'
        #
        #   # good
        #   archive_file '/opt/app' do
        #     path '/tmp/package.tar.gz'
        #   end
        #
        class PreferArchiveFile < Base
          include RuboCop::Chef::CookbookHelpers

          MSG = 'Use the `archive_file` resource instead of shell-based extraction (`tar`, `unzip`, etc.). ' \
                'Native resources handle idempotence and multiple formats natively.'

          RESOURCE_METHODS = %i(execute bash csh ksh perl python ruby powershell_script).freeze
          RESTRICT_ON_SEND = RESOURCE_METHODS
          PROPERTY_METHODS = %i(command code).freeze

          # Matches extraction tools as whole words.
          # Excludes filenames like 'file.tar.gz' by ensuring a leading space/start and trailing space/end.
          ARCHIVE_COMMAND_REGEX = /(?:^|\s)(?:tar|unzip|gunzip|gzip|7z)(?:\s|$)/.freeze

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
            return unless string_node.value.match?(ARCHIVE_COMMAND_REGEX)

            add_offense(node)
          end
        end
      end
    end
  end
end
