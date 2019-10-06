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
        # The cron_manage resource was renamed to cron_access in the 6.1 release of the cron
        # cookbook, and later shipped in Chef Infra Client 14.4. The new resource name should
        # be used.
        #
        #   # bad
        #   cron_manage 'mike'
        #
        #   # good
        #   cron_access 'mike'
        #
        class CronManageResource < Cop
          MSG = 'The cron_manage resource was renamed to cron_access in the 6.1 release of the cron cookbook and later shipped in Chef Infra Client 14.4. The new resource name should be used.'.freeze

          def on_send(node)
            add_offense(node, location: :expression, message: MSG, severity: :refactor) if node.method_name == :cron_manage
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, node.source.gsub(/^cron_manage/, 'cron_access'))
            end
          end
        end
      end
    end
  end
end
