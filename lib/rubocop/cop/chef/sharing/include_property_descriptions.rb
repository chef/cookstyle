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
        # Resources properties should include description fields to allow automated documention. Requires Chef Infra Client 13.9 or later.
        #
        # @example
        #
        #   # bad
        #   property :foo, String
        #
        #   # good
        #   property :foo, String, description: "Set the important thing to..."
        #
        class IncludePropertyDescriptions < Cop
          extend TargetChefVersion

          minimum_target_chef_version '13.9'

          MSG = 'Resources should include description fields to allow automated documention. Requires Chef Infra Client 13.9 or later.'.freeze

          # any method named property being called with a symbol argument and anything else
          def_node_matcher :property?, '(send nil? :property (sym _) ...)'

          # hash that contains description in any order (that's the <> bit)
          def_node_search :description_hash, '(hash <(pair (sym :description) ...) ...>)'

          def on_send(node)
            property?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor) unless description_hash(processed_source.ast).any?
            end
          end
        end
      end
    end
  end
end
