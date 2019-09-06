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
      module ChefModernize
        # There is no need to include Chef::Mixin::ShellOut in resources or providers as this is already done by Chef Infra Client.
        #
        # @example
        #
        #   # bad
        #   require 'chef/mixin/shell_out'
        #   include Chef::Mixin::ShellOut

        class IncludingMixinShelloutInResources < Cop
          MSG = 'There is no need to include Chef::Mixin::ShellOut in resources or providers as this is already done by Chef Infra Client.'.freeze

          def_node_matcher :include_shellout?, <<-PATTERN
            (send nil? :include (const (const (const nil? :Chef) :Mixin) :ShellOut))
          PATTERN

          def_node_matcher :require_shellout?, <<-PATTERN
            (send nil? :require ( str "chef/mixin/shell_out"))
          PATTERN

          def on_send(node)
            require_shellout?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end

            include_shellout?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.remove(node.loc.expression)
            end
          end
        end
      end
    end
  end
end
