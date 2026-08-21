# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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
        # Resource guards (not_if/only_if) should not be empty. An empty string always evaluates to true
        # and an empty block always evaluates to false, so in either case the guard stops doing the job
        # it was written for and the resource silently runs, or fails to run, on every converge.
        #
        # Empty strings in Ruby are "truthy", which means:
        # - `only_if ''` will ALWAYS execute the resource (guard always passes)
        # - `not_if ''` will NEVER execute the resource (guard always blocks)
        #
        # An empty block behaves the other way around, since a block with no body returns `nil`:
        # - `only_if { }` will NEVER execute the resource
        # - `not_if { }` will ALWAYS execute the resource
        #
        # This behavior is usually unintended and can lead to resources running when they shouldn't
        # or never running when they should.
        #
        # @example
        #
        #   # bad
        #   template '/etc/foo' do
        #     mode '0644'
        #     source 'foo.erb'
        #     only_if ''  # This will always be true - resource always executes
        #   end
        #
        #   cookbook_file '/logs/foo/error.log' do
        #     source 'error.log'
        #     not_if { '' }  # This will always be true - resource never executes
        #   end
        #
        #   service 'apache2' do
        #     action :restart
        #     only_if { '' }  # Block form also problematic
        #   end
        #
        #   # good
        #   template '/etc/foo' do
        #     mode '0644'
        #     source 'foo.erb'
        #     only_if 'test -f /etc/foo'  # Actual shell command
        #   end
        #
        #   cookbook_file '/logs/foo/error.log' do
        #     source 'error.log'
        #     not_if { ::File.exist?('/logs/foo/error.log') }  # Proper Ruby expression
        #   end
        #
        #   service 'apache2' do
        #     action :restart
        #     only_if { node['platform'] == 'ubuntu' }  # Meaningful condition
        #   end
        #
        #   # Or simply remove the guard if no condition is needed
        #   package 'curl' do
        #     action :install
        #   end
        #
        class EmptyResourceGuard < Base
          MSG = 'Resource guards (not_if/only_if) should not be empty strings as empty strings will always evaluate to true.'
          EMPTY_BLOCK_MSG = 'Resource guards (not_if/only_if) should not be empty blocks as an empty block returns nil, which always evaluates to false.'
          RESTRICT_ON_SEND = [:not_if, :only_if].freeze

          def_node_matcher :empty_string_guard?, <<-PATTERN
            (send nil? {:not_if :only_if} (str #empty_string?))
          PATTERN

          def_node_matcher :empty_string_block_guard?, <<-PATTERN
            (block (send nil? {:not_if :only_if}) (args) (str #empty_string?))
          PATTERN

          # A block with no body at all. Such a block returns nil rather than the empty string matched
          # above, so the guard fails rather than passes.
          def_node_matcher :empty_block_guard?, <<-PATTERN
            (block (send nil? {:not_if :only_if}) (args) nil?)
          PATTERN

          def empty_string?(str)
            str.empty?
          end

          def on_send(node)
            empty_string_guard?(node) do
              add_offense(node, severity: :refactor)
            end
          end

          def on_block(node)
            empty_string_block_guard?(node) do
              add_offense(node, severity: :refactor)
            end

            empty_block_guard?(node) do
              add_offense(node, message: EMPTY_BLOCK_MSG, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
