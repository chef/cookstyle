# frozen_string_literal: true
#
# Copyright:: Copyright 2019-2020, Chef Software Inc.
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
        #   attribute :name, kind_of: String
        #   attribute :name, kind_of: String, name_attribute: true
        #
        class UnnecessaryNameProperty < Base
          extend AutoCorrector

          MSG = 'There is no need to define a property or attribute named :name in a resource as Chef Infra defines this on all resources by default.'
          RESTRICT_ON_SEND = [:property, :attribute].freeze

          def_node_matcher :name_attribute?, <<-PATTERN
          (send nil? :attribute
            (sym :name)
            (hash
              (pair
                (sym :kind_of)
                (const nil? :String))
              (pair
                (sym :name_attribute)
                (true))?))
          PATTERN

          def_node_matcher :name_property?, <<-PATTERN
            (send nil? :property
              (sym :name)
              (const nil? :String)
              (hash
                (pair
                  (sym :name_property)
                  (true)))?)
          PATTERN

          def on_send(node)
            name_property?(node) do
              add_offense(node, message: MSG, severity: :refactor) do |corrector|
                corrector.remove(node.source_range)
              end
            end

            name_attribute?(node) do
              add_offense(node, message: MSG, severity: :refactor) do |corrector|
                corrector.remove(node.source_range)
              end
            end
          end
        end
      end
    end
  end
end
