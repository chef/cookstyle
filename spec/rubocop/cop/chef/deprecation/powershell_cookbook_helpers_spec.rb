# frozen_string_literal: true

#
# Copyright:: 2020, Chef Software, Inc.
# Author:: Tim Smith (<tsmith84@gmail.com>)
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

describe RuboCop::Cop::Chef::Deprecations::PowershellCookbookHelpers, :config do
  it 'registers an offense with Powershell::VersionHelper.powershell_version?' do
    expect_offense(<<~RUBY)
      Powershell::VersionHelper.powershell_version?('4.0')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['powershell']['version'] or the new powershell_version helper available in Chef Infra Client 15.8+ instead of the deprecated PowerShell cookbook helpers.
    RUBY

    expect_correction("node['powershell']['version'].to_f == '4.0'\n")
  end
end
