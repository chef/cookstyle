#
# Copyright:: 2019, Chef Software, Inc.
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
      module ChefModernize
        # The osx_config_profile resource was renamed to osx_profile.
        # The new resource name should be used.
        #
        #   # bad
        #   osx_config_profile 'Install screensaver profile' do
        #     profile 'screensaver/com.company.screensaver.mobileconfig'
        #   end
        #
        #   # good
        #   osx_profile 'Install screensaver profile' do
        #     profile 'screensaver/com.company.screensaver.mobileconfig'
        #   end
        #
        class OsxConfigProfileResource < Cop
          MSG = 'The osx_config_profile resource was renamed to osx_profile. The new resource name should be used.'.freeze

          def on_send(node)
            add_offense(node, location: :expression, message: MSG, severity: :refactor) if node.method_name == :osx_config_profile
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, node.source.gsub(/^osx_config_profile/, 'osx_profile'))
            end
          end
        end
      end
    end
  end
end
