# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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

require 'spec_helper'

describe RuboCop::Cop::Chef::Deprecations::WindowsPackageInstallerTypeString, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when windows_package has a string installer_type property' do
    expect_offense(<<~RUBY)
      windows_package 'AppveyorDeploymentAgent' do
        source 'https://www.example.com/appveyor.msi'
        installer_type 'msi'
        ^^^^^^^^^^^^^^^^^^^^ In Chef Infra Client 13 and later the `windows_package` resource's `installer_type` property must be a symbol.
        options "/quiet /qn /norestart /log install.log"
      end
    RUBY
  end

  it 'does not register an offense when windows_package has a symbol installer_type property' do
    expect_no_offenses(<<~RUBY)
      windows_package 'AppveyorDeploymentAgent' do
        source 'https://www.example.com/appveyor.msi'
        installer_type :msi
        options "/quiet /qn /norestart /log install.log"
      end
    RUBY
  end
end
