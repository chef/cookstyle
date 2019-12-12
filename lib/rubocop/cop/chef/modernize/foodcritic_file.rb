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
      # Remove any legacy .foodcritic files in your cookbooks that are no longer necessary if you're using Cookstyle for cookbook linting.
      #
      module ChefModernize
        class FoodcriticFile < Cop
          include RangeHelp

          MSG = 'Remove .foodcritic files from cookbooks.'.freeze
          require 'pry'; binding.pry
          def inspect(processed_source)
            require 'pry'; binding.pry
            # Using range similar to RuboCop::Cop::Naming::Filename (file_name.rb)
            range = source_range(processed_source.buffer, 1, 0)

            add_offense(nil, location: range, message: MSG, severity: :refactor)
          end
        end
      end
    end
  end
end
