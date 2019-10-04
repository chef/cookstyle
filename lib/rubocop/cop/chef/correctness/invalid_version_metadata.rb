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
        # Cookbook metadata.rb version field should follow X.Y.Z version format.
        #
        # @example
        #
        #   # bad
        #   version '1.2.3.4'
        #
        #   # good
        #   version '1.2.3'
        #
        class InvalidVersionMetadata < Cop
          MSG = 'Cookbook metadata.rb version field should follow X.Y.Z version format.'.freeze

          def_node_matcher :version?, '(send nil? :version $str ...)'

          def on_send(node)
            version?(node) do |ver|
              if ver.value !~ /\A\d+\.\d+(\.\d+)?\z/ # entirely borrowed from Foodcritic.
                add_offense(ver, location: :expression, message: MSG, severity: :refactor)
              end
            end
          end
        end
      end
    end
  end
end
