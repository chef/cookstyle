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
      module ChefCorrectness
        # metadata.rb should not include fields with an empty string. Either don't include the field or add a value.
        #
        # @example
        #
        #   # bad
        #   license ''
        #
        #   # good
        #   license 'Apache-2.0'
        #
        class EmptyMetadataField < Cop
          MSG = 'Cookbook metadata.rb contains an field with an empty string.'.freeze

          def_node_matcher :field?, '(send nil? _ $str ...)'

          def on_send(node)
            field?(node) do |str|
              add_offense(str, location: :expression, message: MSG, severity: :refactor) if str.value.empty?
            end
          end
        end
      end
    end
  end
end
