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
        # set_or_return within a method should not be used to define property in a resource. Instead use
        # the property method which properly validates and defines properties in a way that works with
        # reporting and documentation functionality in Chef Infra Client
        #
        # @example
        #
        #   # bad
        #    def severity(arg = nil)
        #      set_or_return(
        #        :severity, arg,
        #        :kind_of => String,
        #        :default => nil
        #      )
        #    end
        #
        #   # good
        #   property :severity, String
        #
        class SetOrReturnInResources < Cop
          MSG = 'Do not use set_or_return within a method to define a property for a resource. Use the property method instead, which supports validation, reporting, and documentation functionality'.freeze

          def on_send(node)
            if node.method_name == :set_or_return
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
