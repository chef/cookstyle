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
        # The Delivery CLI from Chef Delivery/Workflow is no longer bundled with Chef Workstation as Chef Delivery is end of life as of Dec 31st 2021.
        #
        # Users of Delivery / Workflow would include a `.delivery` directory in their cookbooks. This directory would include Delivery local-mode configs
        # or Delivery cookbooks. The contents of this directory are now obsolete and should be removed.
        #
        class Delivery < Base
          include RangeHelp

          MSG = 'Do not include a `.delivery` directory for the `delivery` command in your cookbooks. Chef Delivery (Workflow) went EOL Dec 31st 2021 and the delivery command was removed from Chef Workstation Feb 2022.'

          def on_new_investigation
            return unless File.exist?(File.join(File.dirname(processed_source.path) + '/.delivery'))

            # Using range similar to RuboCop::Cop::Naming::Filename (file_name.rb)
            range = source_range(processed_source.buffer, 1, 0)

            add_offense(range, severity: :warning)
          end
        end
      end
    end
  end
end
