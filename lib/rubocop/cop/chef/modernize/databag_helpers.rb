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
      module Modernize
        # Use the `data_bag_item` helper instead of `Chef::DataBagItem.load` or `Chef::EncryptedDataBagItem.load`.
        #
        # @example
        #
        #   # bad
        #   plain_text_data = Chef::DataBagItem.load('foo', 'bar')
        #   encrypted_data = Chef::EncryptedDataBagItem.load('foo2', 'bar2')
        #
        #   # good
        #   plain_text_data = data_bag_item('foo', 'bar')
        #   encrypted_data = data_bag_item('foo2', 'bar2')
        #
        class DatabagHelpers < Base
          extend AutoCorrector

          MSG = 'Use the `data_bag_item` helper instead of `Chef::DataBagItem.load` or `Chef::EncryptedDataBagItem.load`.'
          RESTRICT_ON_SEND = [:load].freeze

          def_node_matcher :data_bag_class_load?, <<-PATTERN
          (send
            (const
              (const {nil? cbase} :Chef) {:DataBagItem :EncryptedDataBagItem}) :load
              ...)
          PATTERN

          def on_send(node)
            data_bag_class_load?(node) do
              add_offense(node, severity: :refactor) do |corrector|
                # replace only the receiver and the .load selector, so that the arguments are left
                # exactly as written. rewriting node.source would also hit any argument that
                # happened to contain the class name, and would leave the leading :: of a scope
                # resolved ::Chef::DataBagItem.load behind
                corrector.replace(node.receiver.source_range.join(node.loc.selector), 'data_bag_item')
              end
            end
          end
        end
      end
    end
  end
end
