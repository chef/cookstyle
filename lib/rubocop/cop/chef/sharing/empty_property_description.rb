# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# Author:: Tim Smith (<tsmith84@proton.me>)
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
      module Sharing
        # Resource properties should not set an empty `description`. Automated documentation tools have
        # nothing to render from it, so it does no more than a missing field would while looking like the
        # property has been documented.
        #
        # @example
        #
        #   # bad
        #   property :site_name, String,
        #            name_property: true,
        #            description: ''
        #
        #   # good
        #   property :site_name, String,
        #            name_property: true,
        #            description: 'The name of the site'
        #
        class EmptyPropertyDescription < Base
          MSG = 'Resource properties should not set an empty `description`. Either describe the property or leave the field off entirely.'
          RESTRICT_ON_SEND = [:property].freeze

          # any method named property being called with a symbol argument and an options hash.
          # capturing the hash rather than searching the whole send keeps us off `description`
          # keys nested inside another option's value, such as `default: { description: '' }`
          def_node_matcher :property_options, '(send nil? :property (sym _) ... $hash)'

          def on_send(node)
            property_options(node) do |options|
              options.pairs.each do |pair|
                next unless pair.key.sym_type? && pair.key.value == :description
                # a description built by interpolation isn't a literal str node, so we can't tell
                # whether it's empty and leave it alone
                next unless pair.value.str_type? && pair.value.value.strip.empty?
                add_offense(pair, severity: :refactor)
              end
            end
          end
        end
      end
    end
  end
end
