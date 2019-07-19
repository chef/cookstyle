#
# Copyright:: 2019, Chef Software Inc.
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
      # why_run_supported? no longer needs to be set to true as that is the default in Chef 13+
      #
      # @example
      #
      #   # bad
      #   why_run_supported?
      #    true
      #   end
      #
      class WhyRunSupportedTrue < Cop
        extend TargetChefVersion

        minimum_target_chef_version 13

        MSG = 'why_run_supported? no longer needs to be set to true as it is the default in Chef 13++'.freeze

        def on_def(node)
          if node.method_name == :why_run_supported? && node.body == s(:true) # rubocop: disable Lint/BooleanSymbol
            add_offense(node, location: :expression, message: MSG, severity: :refactor)
          end
        end

        def autocorrect(node)
          lambda do |corrector|
            corrector.remove(node.loc.expression)
          end
        end
      end
    end
  end
end
