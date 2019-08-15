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
      # metadata.rb needs to include the name method
      #
      # @example
      #
      #   # good
      #   name 'foo'
      #
      class MetadataMissingName < Cop
        include RangeHelp

        MSG = 'metadata.rb needs to include the name method'.freeze

        def investigate(processed_source)
          return if processed_source.blank?
          return unless File.basename(processed_source.file_path) == 'metadata.rb'

          # Using range similar to RuboCop::Cop::Naming::Filename (file_name.rb)
          range = source_range(processed_source.buffer, 1, 0)

          add_offense(nil, location: range, message: MSG, severity: :refactor) unless cb_name(processed_source.ast).any?
        end

        def_node_search :cb_name, '(send nil? :name str ...)'
      end
    end
  end
end
