# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software Inc.
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
        # Use `ignore_failure` in resources to continue when failures occur instead of the deprecated `epic_fail` property.
        #
        # @example
        #
        #   ### incorrect
        #   package "foo" do
        #     epic_fail true
        #   end
        #
        #   ### correct
        #   package "foo" do
        #     ignore_failure true
        #   end
        #
        class EpicFail < Base
          extend AutoCorrector

          MSG = 'Use `ignore_failure` in resources to continue when failures occur instead of the deprecated `epic_fail` property'
          RESTRICT_ON_SEND = [:epic_fail].freeze

          def on_send(node)
            add_offense(node, severity: :warning) do |corrector|
              corrector.replace(node, 'ignore_failure true')
            end
          end
        end
      end
    end
  end
end
