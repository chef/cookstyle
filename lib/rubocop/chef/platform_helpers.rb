#
# Copyright:: Copyright 2019, Chef Software Inc.
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
  module Chef
    # common helpers for Platforms in Chef Infra Cookbooks
    module PlatformHelpers
      # a mapping of invalid platform family values to valid platform family
      INVALID_PLATFORM_FAMILIES = {
        'sles' => 'suse',
        'redhat' => 'rhel',
        'centos' => 'rhel',
        'scientific' => 'rhel',
        'ubuntu' => 'debian',
        'opensuse' => 'suse',
        'opensuseleap' => 'suse',
        'mac_os_x_server' => 'mac_os_x',
        'darwin' => 'mac_os_x',
        'linux' => nil,
      }.freeze

      # a mapping of invalid platforms values to valid platforms
      INVALID_PLATFORMS = {
        'aws' => nil,
        'archlinux' => 'arch',
        'amazonlinux' => 'amazon',
        'darwin' => 'mac_os_x',
        'debuan' => 'debian',
        'mingw32' => 'windows',
        'mswin' => 'windows',
        'macos' => 'mac_os_x',
        'macosx' => 'mac_os_x',
        'mac_os_x_server' => 'mac_os_x',
        'mint' => 'linuxmint',
        'linux' => nil,
        'oel' => 'oracle',
        'oraclelinux' => 'oracle',
        'rhel' => 'redhat',
        'schientific' => 'scientific',
        'scientificlinux' => 'scientific',
        'sles' => 'suse',
        'solaris' => 'solaris2',
        'ubundu' => 'ubuntu',
        'ubunth' => 'ubuntu',
        'ubunutu' => 'ubuntu',
        'windwos' => 'windows',
        'xcp' => nil,
      }.freeze
    end
  end
end
