# frozen_string_literal: true
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
      module ChefCorrectness
        # Don't represent file modes as Strings containing octal values.
        #
        # @example
        #
        #   # bad
        #   file '/etc/some_file' do
        #     mode '0o755'
        #   end
        #
        #   # good
        #   file '/etc/some_file' do
        #     mode '0755'
        #   end
        #
        class OctalModeAsString < Base
          MSG = "Don't represent file modes as strings containing octal values. Use standard base 10 file modes instead. For example: '0755'."
          RESTRICT_ON_SEND = [:mode].freeze

          def on_send(node)
            return unless node.arguments.first&.str_type? && node.arguments.first.value.match?(/^0o/)
            add_offense(node, message: MSG, severity: :refactor)
          end
        end
      end
    end
  end
end
