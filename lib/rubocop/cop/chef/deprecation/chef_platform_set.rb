# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software Inc.
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
        # The Chef::Platform.set method has been removed. Use `provides` instead to set platform specific resource provides.
        #
        # @example
        #
        #   # bad
        #   Chef::Platform.set :platform => :mac_os_x, :resource => :package, :provider => Chef::Provider::Package::Homebrew
        #
        #   # good
        #   # provides :package, platform_family: 'mac_os_x'
        #
        class ChefPlatformSet < Base
          MSG = 'The Chef::Platform.set method has been removed. Use `provides` instead to set platform specific resource provides.'
          RESTRICT_ON_SEND = [:set].freeze

          def_node_matcher :chef_platform_set?, <<-PATTERN
          (send
            (const
              (const nil? :Chef) :Platform) :set ... )
          PATTERN

          def on_send(node)
            chef_platform_set?(node) do
              add_offense(node, message: MSG, severity: :warning)
            end
          end
        end
      end
    end
  end
end
