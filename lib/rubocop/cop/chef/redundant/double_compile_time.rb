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
        # If a resource includes the `compile_time` property there's no need to also use `.run_action(:some_action)` on the resource block
        #
        # @example
        #
        #   # bad
        #   chef_gem 'deep_merge' do
        #     action :nothing
        #     compile_time true
        #   end.run_action(:install)
        #
        #   # good
        #   chef_gem 'deep_merge' do
        #     action :install
        #     compile_time true
        #   end
        #
        class DoubleCompileTime < Base
          extend RuboCop::Cop::AutoCorrector

          MSG = "If a resource includes the `compile_time` property there's no need to also use `.run_action(:some_action)` on the resource block."
          RESTRICT_ON_SEND = [:run_action].freeze

          def_node_matcher :run_action_on_resource?, <<-PATTERN
          (send
            $(block
              (send nil? ... )
              (args)
              _
            ) :run_action (sym $_) )
          PATTERN

          def_node_search :compile_time_true?, '(send nil? :compile_time (true))'
          def_node_search :action_nodes, '(send nil? :action $(sym _))'

          def on_send(node)
            run_action_on_resource?(node) do |resource, run_action|
              next unless compile_time_true?(resource.body)

              # without an explicit action there's nothing to rewrite: the resource runs its
              # default action, and picking the replacement would mean knowing what that is.
              # report it, but leave the fix to a human.
              action = action_nodes(resource.body).first
              unless action
                add_offense(node.loc.selector, severity: :refactor)
                next
              end

              add_offense(node.loc.selector, severity: :refactor) do |corrector|
                # rewrite the action's value and drop the trailing .run_action(...). rewriting the
                # whole block source instead would replace the action name wherever else it appears,
                # renaming the resource itself in something like chef_gem 'nothing'
                corrector.replace(action, ":#{run_action}")
                corrector.remove(node.loc.dot.join(node.source_range.end))
              end
            end
          end
        end
      end
    end
  end
end
