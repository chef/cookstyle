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
      module ChefDeprecations
        # Don't use the deprecated older_than_win_2012_or_8? helper. Windows versions before 2012 and 8 are now end of life and this helper will always return false.
        #
        # @example
        #
        #   # bad
        #   if older_than_win_2012_or_8?
        #     # do some legacy things
        #   end
        #
        class DeprecatedWindowsVersionCheck < Cop
          MSG = "Don't use the deprecated older_than_win_2012_or_8? helper. Windows versions before 2012 and 8 are now end of life and this helper will always return false.".freeze

          def on_send(node)
            add_offense(node, location: :expression, message: MSG, severity: :refactor) if node.method_name == :older_than_win_2012_or_8?
          end
        end
      end
    end
  end
end
