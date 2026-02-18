# frozen_string_literal: true
#
# Copyright:: 2024, Sous Chefs
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
        # Do not use `FileUtils.rm_rf` in recipes to delete files or directories.
        # This bypasses Chef's idempotency and reporting, making code that is
        # not idempotent and hard to debug. Instead, use the `file` or
        # `directory` resources with `action :delete`.
        #
        # @example
        #
        #   ### incorrect
        #   ruby_block 'delete temp file' do
        #     block do
        #       FileUtils.rm_rf '/tmp/foo.txt'
        #     end
        #   end
        #
        #   ### correct
        #   file '/tmp/foo.txt' do
        #     action :delete
        #   end
        #
        class FileUtilsRMRF < Base
          MSG = 'Do not use FileUtils.rm_rf. Use the file or directory resources with action :delete instead.'

          # Restrict to checking `send` nodes for performance
          RESTRICT_ON_SEND = [:rm_rf].freeze

          def_node_matcher :fileutils_rm_rf?, <<~PATTERN
            (send (const nil? :FileUtils) :rm_rf ...)
          PATTERN

          def on_send(node)
            return unless fileutils_rm_rf?(node)

            add_offense(node.receiver.source_range.join(node.loc.selector))
          end
        end
      end
    end
  end
end
