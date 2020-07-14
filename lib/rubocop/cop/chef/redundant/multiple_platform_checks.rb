# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
# Author:: Tim Smith (<tsmith@chef.io>)
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
      module ChefRedundantCode
        # You can pass multiple values to the platform? and platform_family? helpers instead of calling the helpers multiple times.
        #
        # @example
        #
        #   # bad
        #   platform?('redhat') || platform?('ubuntu')
        #   platform_family?('debian') || platform_family?('rhel')
        #
        #   # good
        #   platform?('redhat', 'ubuntu')
        #   platform_family?('debian', 'rhel')
        #
        class MultiplePlatformChecks < Cop
          MSG = 'You can pass multiple values to the platform? and platform_family? helpers instead of calling the helpers multiple times.'

          def_node_matcher :or_platform_helpers?, <<-PATTERN
            (or (send nil? ${:platform? :platform_family?} $_ )* )
          PATTERN

          def on_or(node)
            or_platform_helpers?(node) do |helpers, _plats|
              # if the helper types were the same it's an offense, but platform_family?('rhel') || platform?('ubuntu') is legit
              add_offense(node, location: :expression, message: MSG, severity: :refactor) if helpers.uniq.size == 1
            end
          end

          def autocorrect(node)
            or_platform_helpers?(node) do |type, plats|
              lambda do |corrector|
                new_string = "#{type.first}(#{plats.map(&:source).join(', ')})"
                corrector.replace(node.loc.expression, new_string)
              end
            end
          end
        end
      end
    end
  end
end
