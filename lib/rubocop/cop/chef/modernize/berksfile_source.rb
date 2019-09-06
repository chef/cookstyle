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
        # Over the course of years there have been many different valid community site / Supermarket
        # URLs to use in a cookbook's Berksfile. These old URLs continue to function via redirects,
        # but should be updated to point to the latest Supermarket URL.
        #
        # @example
        #
        #   # bad
        #   source 'http://community.opscode.com/api/v3'
        #   source 'https://supermarket.getchef.com'
        #   source 'https://api.berkshelf.com'
        #
        #   # good
        #   source 'https://supermarket.chef.io'
        #
        class LegacyBerksfileSource < Cop
          MSG = 'Do not use legacy Berksfile community sources. Use Chef Supermarket instead.'.freeze

          def_node_matcher :berksfile_source?, <<-PATTERN
            (send nil? :source (str #old_berkshelf_url?))
          PATTERN

          def old_berkshelf_url?(url)
            %w(http://community.opscode.com/api/v3 https://supermarket.getchef.com https://api.berkshelf.com).include?(url)
          end

          def on_send(node)
            berksfile_source?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, "source 'https://supermarket.chef.io'")
            end
          end
        end
      end
    end
  end
end
