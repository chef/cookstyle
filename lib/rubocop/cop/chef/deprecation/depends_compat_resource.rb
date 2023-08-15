# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
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
        # Don't depend on the deprecated `compat_resource` cookbook made obsolete by Chef Infra Client 12.19+.
        #
        # @example
        #
        #   ### incorrect
        #   depends 'compat_resource'
        #
        class CookbookDependsOnCompatResource < Base
          include RangeHelp
          extend TargetChefVersion
          extend AutoCorrector

          minimum_target_chef_version '12.19'

          MSG = "Don't depend on the deprecated compat_resource cookbook made obsolete by Chef 12.19+"
          RESTRICT_ON_SEND = [:depends].freeze

          def_node_matcher :depends_compat_resource?, <<-PATTERN
            (send nil? :depends (str {"compat_resource"}))
          PATTERN

          def on_send(node)
            depends_compat_resource?(node) do
              add_offense(node, severity: :warning) do |corrector|
                corrector.remove(range_with_surrounding_space(range: node.loc.expression, side: :left))
              end
            end
          end
        end
      end
    end
  end
end
