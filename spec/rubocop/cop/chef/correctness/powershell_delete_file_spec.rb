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

describe RuboCop::Cop::Chef::Correctness::PowershellScriptDeleteFile, :config do
  it 'registers an offense when when using powershell_script to run Remove-File' do
    expect_offense(<<~RUBY)
      powershell_script 'Cleanup_Old_Install_File' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `file` or `directory` resources built into Chef Infra Client with the :delete action to remove files/directories instead of using Remove-Item in a powershell_script resource
        code 'Remove-Item C:\Windows\foo\installed.txt'
        action :nothing
        only_if { ::File.exist?('C:\\Windows\\foo\\installed.txt') }
      end
    RUBY
  end

  it 'does not register an offense when using powershell_script to run Remove-File with a splat operator' do
    expect_no_offenses(<<~RUBY)
      powershell_script 'Cleanup_Old_Install_File' do
        code 'Remove-Item C:\Windows\foo\installed*.txt'
        action :nothing
        only_if { ::File.exist?('C:\\Windows\\foo\\installed.txt') }
      end
    RUBY
  end
end
