#
# Copyright:: Copyright 2019, Chef Software Inc.
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
      module ChefRedundantCode
        # There is no need to define a property or attribute named :name in a resource as Chef Infra defines this on all resources by default.
        #
        # @example
        #
        #   # bad
        #   property :name, String
        #   property :name, String, name_property: true
        #   attribute :name, String
        #   attribute :name, String, name_attribute: true
        #
        class UnnecessaryNameProperty < Cop
          MSG = 'There is no need to define a property or attribute named :name in a resource as Chef Infra defines this on all resources by default.'.freeze

          # match on a property/attribute named :name that's a string. The property/attribute optionally
          # set name_property/name_attribute true, but nothing else is allowed. If you're doing that it's
          # no longer the default and your usage is fine.
          def_node_matcher :name_property?, <<-PATTERN
            (send nil? {:property :attribute} (sym :name) (const nil? :String) (hash (pair (sym {:name_attribute :name_property}) (true)))?)
          PATTERN

          def on_send(node)
            name_property?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.remove(node.source_range)
            end
          end
        end
      end
    end
  end
end
