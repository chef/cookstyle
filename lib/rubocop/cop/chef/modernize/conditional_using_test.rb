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
      module Modernize
        # Use `::File.exist?('/foo/bar')` in an `only_if` or `not_if` guard instead of the slower `'test -f /foo/bar'`, which requires shelling out. The Ruby check has to be passed as a block. Passing it directly, as `not_if ::File.exist?('/foo/bar')`, raises `ArgumentError: Invalid only_if/not_if command, expected a string`.
        #
        # @example
        #
        #   # bad
        #   only_if 'test -f /bin/foo'
        #   not_if 'test -f /bin/foo'
        #
        #   # bad - a Ruby guard has to be a block, this raises at converge time
        #   only_if ::File.exist?('/bin/foo')
        #
        #   # good
        #   only_if { ::File.exist?('/bin/foo') }
        #   not_if { ::File.exist?('/bin/foo') }
        #
        class ConditionalUsingTest < Base
          extend AutoCorrector

          # %{guard} is the guard the offense was found on, so that a not_if offense isn't told to
          # use an only_if, which would invert the condition
          MSG = "Use %{guard} { ::File.exist?('/foo/bar') } instead of the slower %{guard} 'test -f /foo/bar' which requires shelling out"
          RESTRICT_ON_SEND = [:not_if, :only_if].freeze

          def_node_matcher :resource_conditional?, <<~PATTERN
            (send nil? {:not_if :only_if} $str )
          PATTERN

          def on_send(node)
            resource_conditional?(node) do |conditional|
              return unless conditional.value.match?(/^test -[ef] \S*$/)
              add_offense(node, message: format(MSG, guard: node.method_name), severity: :refactor) do |corrector|
                new_string = "{ ::File.exist?('#{conditional.value.match(/^test -[ef] (\S*)$/)[1]}') }"
                corrector.replace(conditional, new_string)
              end
            end
          end
        end
      end
    end
  end
end
