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
      module ChefCorrectness
        # metadata.rb supports methods should contain valid platforms.
        #
        # @example
        #
        #   # bad
        #   supports 'darwin'
        #   supports 'mswin'
        #
        #   # good
        #   supports 'mac_os_x'
        #   supports 'windows'
        #
        class InvalidPlatformMetadata < Cop
          COMMON_TYPOS = {
            "aws": nil,
            "archlinux": 'arch',
            "amazonlinux": 'amazon',
            "darwin": 'mac_os_x',
            "debuan": nil,
            "mingw32": 'windows',
            "mswin": 'windows',
            "macos": 'mac_os_x',
            "macosx": 'mac_os_x',
            "mac_os_x_server": 'mac_os_x',
            "mint": 'linuxmint',
            "linux": nil,
            "oel": 'oracle',
            "oraclelinux": 'oracle',
            "rhel": 'redhat',
            "schientific": 'scientific',
            "scientificlinux": 'scientific',
            "sles": 'suse',
            "solaris": 'solaris2',
            "ubundu": 'ubuntu',
            "ubunth": 'ubuntu',
            "ubunutu": 'ubuntu',
            "windwos": 'windows',
            "xcp": nil,
          }.freeze

          MSG = 'metadata.rb "supports" platform is invalid'.freeze

          def_node_matcher :supports?, '(send nil? :supports $str ...)'

          def on_send(node)
            supports?(node) do |plat|
              if COMMON_TYPOS[plat.str_content.to_sym]
                add_offense(plat, location: :expression, message: MSG, severity: :refactor)
              end
            end
          end

          def autocorrect(node)
            correct_string = autocorrect_license_string(node.str_content)
            if correct_string
              lambda do |corrector|
                corrector.replace(node.loc.expression, "'#{correct_string}'")
              end
            end
          end

          # private

          def autocorrect_license_string(bad_string)
            COMMON_TYPOS[bad_string.delete(',').downcase.to_sym]
          end
        end
      end
    end
  end
end
