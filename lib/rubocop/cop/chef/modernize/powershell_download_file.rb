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
        # Use the `remote_file` resource to download files instead of shelling out to PowerShell.
        # `remote_file` is idempotent, supports checksum verification, proxies, and conditional
        # downloads with etags and last-modified headers, none of which a script gets for free.
        #
        # @example
        #
        #   # bad
        #   powershell_script 'download the installer' do
        #     code 'Invoke-WebRequest -Uri https://example.com/foo.msi -OutFile C:\foo.msi'
        #   end
        #
        #   # good
        #   remote_file 'C:\foo.msi' do
        #     source 'https://example.com/foo.msi'
        #   end
        #
        class PowershellDownloadFile < Base
          include RuboCop::Chef::CookbookHelpers

          MSG = 'Use the remote_file resource to download files instead of downloading them in a PowerShell script resource'

          # the PowerShell ways of pulling a file down over HTTP
          DOWNLOAD_COMMANDS = Regexp.union(
            /invoke-webrequest\s/i,
            /\bstart-bitstransfer\s/i,
            /\bwget\s/i,        # PowerShell alias for Invoke-WebRequest
            /\bcurl\s/i,        # PowerShell alias for Invoke-WebRequest
            /system\.net\.webclient/i
          ).freeze

          def on_block(node)
            match_property_in_resource?(%i(powershell_script pwsh_script), 'code', node) do |code_property|
              property_data = method_arg_ast_to_string(code_property)
              next unless property_data&.match?(DOWNLOAD_COMMANDS)

              add_offense(node, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
