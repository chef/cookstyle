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
      module Deprecations
        # Use the :run action in the ruby_block resource instead of the deprecated :create action
        #
        # @example
        #
        #   # bad
        #   ruby_block 'my special ruby block' do
        #     block do
        #       puts 'running'
        #     end
        #     action :create
        #   end
        #
        #   # bad
        #   template '/etc/foo.conf' do
        #     notifies :create, 'ruby_block[my special ruby block]', :immediately
        #   end
        #
        #   # good
        #   ruby_block 'my special ruby block' do
        #     block do
        #       puts 'running'
        #     end
        #     action :run
        #   end
        #
        #   # good
        #   template '/etc/foo.conf' do
        #     notifies :run, 'ruby_block[my special ruby block]', :immediately
        #   end
        #
        class RubyBlockCreateAction < Base
          include RuboCop::Chef::CookbookHelpers
          extend AutoCorrector

          MSG = 'Use the :run action in the ruby_block resource instead of the deprecated :create action'
          RESTRICT_ON_SEND = [:notifies, :subscribes].freeze

          def_node_matcher :notification?, <<-PATTERN
            (send nil? {:notifies :subscribes} $(sym :create) ${str dstr} ...)
          PATTERN

          def on_block(node)
            match_property_in_resource?(:ruby_block, 'action', node) do |ruby_action|
              each_action_symbol(ruby_action) do |action, prefix|
                next unless action.value == :create
                add_offense(action, severity: :warning) do |corrector|
                  corrector.replace(action, "#{prefix}run")
                end
              end
            end
          end

          def on_send(node)
            notification?(node) do |action, notified_resource|
              next unless ruby_block?(notified_resource)

              add_offense(action, severity: :warning) do |corrector|
                corrector.replace(action, ':run')
              end
            end
          end

          private

          # Does the notified resource string address a ruby_block? An interpolated name
          # ("ruby_block[#{foo}]") still starts with a literal segment we can key off of, but a
          # string whose resource type is itself interpolated tells us nothing, so we skip it.
          #
          # @param [RuboCop::AST::Node] node the str or dstr the notification points at
          #
          # @return [Boolean]
          def ruby_block?(node)
            literal = node.str_type? ? node : node.children.first
            literal&.str_type? && literal.value.start_with?('ruby_block[')
          end
        end
      end
    end
  end
end
