# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software Inc.
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
      module ChefDeprecations
        # Make sure ignore_failure is used instead of epic_fail
        #
        # @example
        #
        #   # bad
        #   package "foo" do
        #     epic_fail true
        #   end
        #
        #   # good
        #   package "foo" do
        #     ignore_failure true
        #   end
        #
        class EpicFail < Base
          MSG = 'Use ignore_failure method instead of the deprecated epic_fail method'

          extend AutoCorrector
          def on_send(node)
            add_offense(node, message: MSG, severity: :warning) do |corrector|
              corrector.replace(node.loc.expression, 'ignore_failure true')
            end if node.method_name == :epic_fail
          end
        end
      end
    end
  end
end
