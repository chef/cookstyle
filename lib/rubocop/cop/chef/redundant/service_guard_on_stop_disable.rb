# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# Author:: Tim Smith (<tsmith84@proton.me>)
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
      module RedundantCode
        # The `:stop` and `:disable` actions of the `service` resource are already no-ops when the service
        # isn't installed, so guarding them with a check for the init script or unit file adds nothing. The
        # base provider only converges these actions when `current_resource.running`/`current_resource.enabled`
        # is set, and the platform providers never set that state for a service they can't find.
        #
        # The guard is also actively harmful because it hardcodes a single path while the provider searches
        # several. A guard on `/usr/local/etc/rc.d/snmpd` skips a FreeBSD host running the service out of
        # `/etc/rc.d`, and the run then reports success while leaving the service enabled.
        #
        # This cop only fires when every action is `:stop` or `:disable`. Actions like `:start`, `:enable`,
        # `:restart`, and `:reload` are asserted against the init script, so a guard there is meaningful. The
        # `systemd_unit` resource shells out unconditionally, so its guards are meaningful as well and are
        # never flagged.
        #
        # @example
        #
        #   # bad
        #   service 'snmpd' do
        #     action %i(stop disable)
        #     only_if { ::File.exist?('/usr/local/etc/rc.d/snmpd') }
        #   end
        #
        #   # good
        #   service 'snmpd' do
        #     action %i(stop disable)
        #   end
        #
        class ServiceGuardOnStopDisable < Base
          include RuboCop::Chef::CookbookHelpers
          include RangeHelp
          extend AutoCorrector

          MSG = 'A service resource that only stops or disables a service does not need a guard checking for the init script or unit file. Chef Infra Client already skips these actions when the service does not exist, and hardcoding a single path can silently skip services installed elsewhere.'

          # actions that Chef Infra Client treats as no-ops when the service can't be found
          NO_OP_ACTIONS = %i(stop disable).freeze

          # the directories the various service providers search for init scripts and unit files
          INIT_SCRIPT_PATH = %r{/(?:etc/init\.d|etc/rc\.d|usr/local/etc/rc\.d|etc/sv|systemd/system)/}.freeze

          def_node_matcher :file_exist_check, <<~PATTERN
            (send (const {nil? cbase} :File) {:exist? :exists? :executable? :file? :readable?} $_)
          PATTERN

          def_node_search :action_nodes, '(send nil? :action $...)'

          def on_block(node)
            match_property_in_resource?(:service, %i(only_if not_if), node) do |guard|
              # a string guard like `only_if 'test -f /etc/init.d/foo'` isn't a Ruby block
              next unless guard.block_type?
              next unless only_no_op_actions?(node)

              # `guard.body` is only a bare send when the block does nothing but the existence check.
              # Anything more (a `&&`, a second statement) is a guard we shouldn't touch.
              path = file_exist_check(guard.body)
              next unless path && INIT_SCRIPT_PATH.match?(path.source)

              add_offense(guard, severity: :refactor) do |corrector|
                corrector.remove(range_by_whole_lines(guard.source_range, include_final_newline: true))
              end
            end
          end

          private

          # @param [RuboCop::AST::BlockNode] node the resource block
          #
          # @return [Boolean] the resource declares at least one action and all of them are no-ops
          #                   for a service that isn't installed
          def only_no_op_actions?(node)
            actions = action_nodes(node).flat_map { |args| args.flat_map { |arg| action_symbols(arg) } }
            !actions.empty? && actions.all? { |action| NO_OP_ACTIONS.include?(action) }
          end

          # Unwrap the ways an action can be written: `action :stop`, `action %i(stop disable)`,
          # and `action [:stop, :disable]`. Anything else (a variable, a node attribute) yields nil,
          # which fails the NO_OP_ACTIONS check and leaves the resource alone.
          #
          # @param [RuboCop::AST::Node] node
          #
          # @return [Array<Symbol, nil>]
          def action_symbols(node)
            case node.type
            when :sym
              [node.value]
            when :array
              node.values.flat_map { |value| action_symbols(value) }
            else
              [nil]
            end
          end
        end
      end
    end
  end
end
