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
      module Correctness
        # Setting `unified_mode true` conditionally leaves a resource running in unified mode on newer
        # Chef Infra Client releases and in legacy mode on older ones. That's not a coherent thing to
        # want: the resource has to be written, tested, and debugged against both execution models.
        #
        # Pick one. Set `unified_mode true` unconditionally and drop support for releases that predate
        # it, or set `unified_mode false if respond_to?(:unified_mode)` to deliberately opt out of
        # unified mode everywhere and keep writing the resource in the traditional style.
        #
        # Only `unified_mode true` is flagged. `unified_mode false` under a guard is the supported way
        # to opt out and is left alone.
        #
        # @example
        #
        #   # bad
        #   unified_mode true if respond_to?(:unified_mode)
        #
        #   # good
        #   unified_mode true
        #
        #   # good - deliberately opting out of unified mode
        #   unified_mode false if respond_to?(:unified_mode)
        #
        class ConditionalUnifiedModeTrue < Base
          extend AutoCorrector
          extend TargetChefVersion

          minimum_target_chef_version '15.3'

          MSG = 'Set `unified_mode true` unconditionally. Making it conditional gives you unified mode on newer Chef Infra Client releases and legacy mode on older ones, so the resource has to be tested and reasoned about both ways.'
          RESTRICT_ON_SEND = [:unified_mode].freeze

          def_node_matcher :unified_mode_true?, '(send nil? :unified_mode (true))'

          def on_send(node)
            return unless unified_mode_true?(node)

            conditional = node.each_ancestor(:if).first
            return unless conditional

            add_offense(node, severity: :refactor) do |corrector|
              # only unwrap the conditional when it wraps nothing but this property, otherwise
              # we'd delete whatever else the branch was guarding. an elsif is never safe to unwrap:
              # its node covers only the elsif itself, so replacing it drops that branch's condition
              # and folds the property into the preceding branch
              next if conditional.elsif?
              next unless sole_branch_body?(conditional, node)

              corrector.replace(conditional, node.source)
            end
          end

          private

          # Is the property the entire body of the conditional? `if` puts the body in the first
          # child after the condition and `unless` puts it in the second, so check both. A branch
          # holding anything else is a `begin` node rather than the property itself, and an `if`
          # with an `else` (or an `elsif` chain) leaves the other branch non-nil.
          #
          # @param [RuboCop::AST::IfNode] conditional
          # @param [RuboCop::AST::SendNode] node the `unified_mode true` property
          #
          # @return [Boolean]
          def sole_branch_body?(conditional, node)
            conditional.children[1..2].compact == [node]
          end
        end
      end
    end
  end
end
