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
      module Correctness
        # A `not_if`/`only_if` guard takes either a string, which is run as a shell command, or a block,
        # which is run as Ruby. Passing a Ruby expression directly gives the guard the expression's
        # *result* rather than the expression, because it is evaluated while the recipe is compiled.
        #
        # A guard that receives `true` or `false` raises at converge time:
        #
        #   ArgumentError: Invalid only_if/not_if command, expected a string: true (TrueClass)
        #
        # Worse, an expression that happens to return a string is accepted and then run as a shell
        # command, so the guard quietly tests something entirely different to what was intended.
        #
        # Only expressions that clearly produce a boolean are flagged, so a shell command built in Ruby
        # and held in a variable is left alone.
        #
        # @example
        #
        #   # bad
        #   not_if ::File.exist?('/etc/foo')
        #   only_if node['foo']['version'] == '1.0'
        #
        #   # good
        #   not_if { ::File.exist?('/etc/foo') }
        #   only_if { node['foo']['version'] == '1.0' }
        #
        #   # good - a string guard runs as a shell command
        #   not_if 'test -f /etc/foo'
        #
        class RubyGuardWithoutBlock < Base
          extend AutoCorrector

          MSG = 'A Ruby expression used as a resource guard has to be wrapped in a block. Passing it directly hands the guard the expression result, which raises at converge time or silently runs a shell command.'
          RESTRICT_ON_SEND = [:not_if, :only_if].freeze

          # comparison and negation operators always produce a boolean
          BOOLEAN_OPERATORS = %i(== != < > <= >= =~ !~ ! equal? eql?).freeze

          def_node_matcher :guard_with_argument, '(send nil? {:not_if :only_if} $_)'

          def on_send(node)
            guard_with_argument(node) do |argument|
              next unless boolean_expression?(argument)

              add_offense(node, severity: :refactor) do |corrector|
                corrector.replace(node, "#{node.method_name} { #{argument.source} }")
              end
            end
          end

          private

          # Can we tell that this expression produces a boolean rather than a shell command? Anything
          # we can't be sure about, such as a bare method call or a local variable, is left alone: it
          # may well hold a perfectly good command string.
          #
          # @param [RuboCop::AST::Node] node
          #
          # @return [Boolean]
          def boolean_expression?(node)
            return true if node.boolean_type? || node.defined_type?
            return true if node.operator_keyword? # && and ||
            return node.children.one? && boolean_expression?(node.children.first) if node.begin_type?
            return false unless node.send_type?

            node.method_name.to_s.end_with?('?') || BOOLEAN_OPERATORS.include?(node.method_name)
          end
        end
      end
    end
  end
end
