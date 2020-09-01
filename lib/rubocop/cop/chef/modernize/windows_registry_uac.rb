# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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
        # Chef Infra Client 15.0 and later includes a windows_uac resource that should be used to set Windows UAC values instead of setting registry keys directly.
        #
        #   # bad
        #   registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' do
        #     values [{ name: 'EnableLUA', type: :dword, data: 0 },
        #             { name: 'PromptOnSecureDesktop', type: :dword, data: 0 },
        #             { name: 'ConsentPromptBehaviorAdmin', type: :dword, data: 0 },
        #            ]
        #     action :create
        #   end
        #
        #  # good
        #  windows_uac 'Set Windows UAC settings' do
        #    enable_uac false
        #    prompt_on_secure_desktop true
        #    consent_behavior_admins :no_prompt
        #  end
        #
        class WindowsRegistryUAC < Cop
          include RuboCop::Chef::CookbookHelpers
          extend TargetChefVersion

          minimum_target_chef_version '15.0'

          MSG = 'Chef Infra Client 15.0 and later includes a windows_uac resource that should be used to set Windows UAC values instead of setting registry keys directly.'
          RESTRICT_ON_SEND = [:registry_key].freeze

          # non block execute resources
          def on_send(node)
            return unless node&.arguments.first&.source.match?(/(HKLM|HKEY_LOCAL_MACHINE)\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System/i) &&
                          node.parent&.method_name != :describe

            # use source instead of .value in case there's string interpolation which adds a complex dstr type
            # with a nested string and a begin. Source allows us to avoid a lot of defensive programming here
            add_offense(node, location: :expression, message: MSG, severity: :refactor)
          end

          # block execute resources
          def on_block(node)
            match_property_in_resource?(:registry_key, 'key', node) do |key_prop|
              property_data = method_arg_ast_to_string(key_prop)
              return unless property_data && property_data.match?(/(HKLM|HKEY_LOCAL_MACHINE)\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System/i)
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
