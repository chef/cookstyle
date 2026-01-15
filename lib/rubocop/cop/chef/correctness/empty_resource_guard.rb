# frozen_string_literal: true
#
# Copyright:: 2024, Chef Software Inc.
# Author:: Sumedha (<https://github.com/sumedha-lolur>)
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
        # Resource guards (not_if/only_if) should not be empty strings or empty blocks.
        # Empty guards are always truthy in Ruby, which can lead to resources running 
        # unexpectedly or never running when they should. This is usually unintended
        # and can cause confusing behavior in cookbooks.
        #
        # Why it matters:
        # - `only_if ''` → always executes the resource
        # - `not_if ''` → never executes the resource
        # Empty block form behaves the same way.
        #
        # @example
        #
        #   # bad: guard always passes or always blocks
        #   template '/etc/foo' do
        #     mode '0644'
        #     source 'foo.erb'
        #     only_if '' 
        #   end
        #
        #   cookbook_file '/logs/foo/error.log' do
        #     source 'error.log'
        #     not_if { '' } 
        #   end
        #
        #   # good: meaningful guard conditions
        #   template '/etc/foo' do
        #     mode '0644'
        #     source 'foo.erb'
        #     only_if 'test -f /etc/foo' 
        #   end
        #
        #   cookbook_file '/logs/foo/error.log' do
        #     source 'error.log'
        #     not_if { ::File.exist?('/logs/foo/error.log') }
        #   end
        #
        #   service 'apache2' do
        #     action :restart
        #     only_if { node['platform'] == 'ubuntu' }
        #   end
        #
        #   # Or remove the guard if no condition is needed
        #   package 'curl' do
        #     action :install
        #   end

        class EmptyResourceGuard < Base
          MSG = 'Do not use empty strings in not_if/only_if guards — provide a meaningful condition or remove the guard.'

          RESTRICT_ON_SEND = [:not_if, :only_if].freeze

          def_node_matcher :empty_string_guard?, <<-PATTERN
            (send nil? {:not_if :only_if} (str #empty_string?))
          PATTERN

          def_node_matcher :empty_string_block_guard?, <<-PATTERN
            (block (send nil? {:not_if :only_if}) (args) (str #empty_string?))
          PATTERN

          def empty_string?(str)
            str.empty?
          end

          def on_send(node)
            empty_string_guard?(node) do
              add_offense(node, severity: :warning)  # changed from :refactor
            end
          end

          def on_block(node)
            empty_string_block_guard?(node) do
              add_offense(node, severity: :warning)  # changed from :refactor
            end
          end
        end
      end
    end
  end
end
