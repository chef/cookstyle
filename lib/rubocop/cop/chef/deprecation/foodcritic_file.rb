# frozen_string_literal: true
#
# Copyright:: 2022, Chef Software Inc.
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
        # The Foodcritic cookbook linter has been deprecated and should no longer be used for validating cookbooks. Do not include the `.foodcritic` config file used by Foodcritic in your cookbooks.
        #
        class FoodcriticFile < Base
          include RangeHelp

          MSG = 'Do not include the `.foodcritic` config file for the deprecated Foodcritic cookbook linter.'

          def on_new_investigation
            return unless processed_source.path.end_with?('.foodcritic')

            # Using range similar to RuboCop::Cop::Naming::Filename (file_name.rb)
            range = source_range(processed_source.buffer, 1, 0)

            add_offense(range, severity: :warning)
          end
        end
      end
    end
  end
end
