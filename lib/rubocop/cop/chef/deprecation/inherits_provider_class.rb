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
        # To get the full functionality of Chef's Recipe DSL a HWRP style Provider should inherit from Chef::Provider::LWRPBase and not Chef::Provider.
        #
        # @example
        #
        #  # bad
        #  class AptUpdate < Chef::Provider
        #    # some provider code
        #  end
        #
        #  # good
        #  class AptUpdate < Chef::Provider::LWRPBase
        #    # some provider code
        #  end
        #
        #  # better
        #  Write a custom resource using the custom resource DSL and avoid class based HWRPs entirely
        #
        class ProviderInheritsFromProviderClass < Cop
          MSG = "To get the full functionality of Chef's Recipe DSL a HWRP style Provider should inherit from Chef::Provider::LWRPBase and not Chef::Provider.".freeze

          def_node_matcher :inherits_from_compat_resource?, <<-PATTERN
          (class (const nil? _ ) (const (const nil? :Chef) :Provider) ... )
          PATTERN

          def_node_search :poise_resource?, <<-PATTERN
          (send nil? :include (const nil? :Poise))
          PATTERN

          def on_class(node)
            inherits_from_compat_resource?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor) if poise_resource?(processed_source.ast).nil?
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, node.loc.expression.source.gsub('Chef::Provider', 'Chef::Provider::LWRPBase'))
            end
          end
        end
      end
    end
  end
end
