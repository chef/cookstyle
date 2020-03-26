#
# Copyright:: Copyright 2020, Chef Software Inc.
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
      module ChefSharing
        # Resources should include description fields to allow automated documention. Requires Chef Infra Client 13.9 or later.
        #
        # @example
        #
        #   # good
        #   resource_name :foo
        #   description "The foo resource is used to do..."
        #
        class IncludeResourceDescriptions < Cop
          include RangeHelp
          extend TargetChefVersion

          minimum_target_chef_version '13.9'

          MSG = 'Resources should include description fields to allow automated documention. Requires Chef Infra Client 13.9 or later.'.freeze

          def investigate(processed_source)
            return if processed_source.blank?

            # Using range similar to RuboCop::Cop::Naming::Filename (file_name.rb)
            range = source_range(processed_source.buffer, 1, 0)

            add_offense(nil, location: range, message: MSG, severity: :refactor) unless resource_description(processed_source.ast).any?
          end

          def_node_search :resource_description, '(send nil? :description str ...)'
        end
      end
    end
  end
end