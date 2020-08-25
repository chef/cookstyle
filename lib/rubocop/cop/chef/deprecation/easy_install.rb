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
      module ChefDeprecations
        # Don't use the deprecated easy_install resource removed in Chef Infra Client 13
        #
        # @example
        #
        #   # bad
        #   easy_install "my_thing" do
        #     bar
        #   end
        #
        class EasyInstallResource < Base
          MSG = "Don't use the deprecated easy_install resource removed in Chef Infra Client 13"

          def on_send(node)
            add_offense(node, message: MSG, severity: :warning) if node.method_name == :easy_install
          end
        end
      end
    end
  end
end
