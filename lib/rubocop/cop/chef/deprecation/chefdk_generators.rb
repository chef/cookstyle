# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software Inc.
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
        # Chef Workstation 0.8 and later renamed the ChefDK module used when writing custom cookbook generators from ChefDK to ChefCLI. For compatibility with the latest Chef Workstation releases you'll need to reference the new class names.
        #
        # @example
        #
        #   # bad
        #   ChefDK::CLI
        #   ChefDK::Generator::TemplateHelper
        #   module ChefDK
        #     ...
        #   end
        #
        #   # good
        #   ChefCLI::CLI
        #   ChefCLI::Generator::TemplateHelper
        #   module ChefCLI
        #     ...
        #   end
        #
        class ChefDKGenerators < Base
          MSG = 'When writing cookbook generators use the ChefCLI module instead of the ChefDK module which was removed in Chef Workstation 0.8 and later.'

          extend AutoCorrector
          def on_const(node)
            # We want to catch calls like ChefCLI::CLI.whatever or places where classes are defined in the ChefDK module
            return unless node.const_name == 'ChefDK' && (node.parent&.module_type? || node.parent&.const_type?)

            add_offense(node, message: MSG, severity: :warning) do |corrector|
              corrector.replace(node.loc.expression, node.source.gsub('ChefDK', 'ChefCLI'))
            end
          end
        end
      end
    end
  end
end
