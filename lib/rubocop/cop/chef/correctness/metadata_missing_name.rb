# frozen_string_literal: true
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
      # metadata.rb needs to include the name method or it will fail on Chef Infra Client 12 and later.
      #
      # @example
      #
      #   # good
      #   name 'foo'
      #
      module Correctness
        class MetadataMissingName < Base
          include RangeHelp

          MSG = 'metadata.rb needs to include the name method or it will fail on Chef Infra Client 12 and later.'

          def_node_search :cb_name, '(send nil? :name str ...)'

          def on_new_investigation
            # Using range similar to RuboCop::Cop::Naming::Filename (file_name.rb)
            return if cb_name(processed_source.ast).any?
            range = source_range(processed_source.buffer, 1, 0)
            add_offense(range, message: MSG, severity: :refactor) do |_corrector|
              path = processed_source.path
              cb_name = File.basename(File.dirname(path))
              metadata = IO.read(path)
              IO.write(path, "name '#{cb_name}'\n" + metadata)
            end
          end
        end
      end
    end
  end
end
