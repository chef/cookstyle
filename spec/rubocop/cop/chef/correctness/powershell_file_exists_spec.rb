# frozen_string_literal: true
#
# Copyright:: 2021, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Correctness::PowershellFileExists, :config do
  it 'registers an offense when when using powershell_out to run Test-Path' do
    expect_offense(<<~RUBY)
      powershell_out('Test-Path "C:\\Program Files\\LAPS\\CSE\\AdmPwd.dll"').stdout.strip == 'True'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use Ruby's built-in `File.exist?('C:\\somefile')` method instead of executing PowerShell's `Test-Path` cmdlet, which takes longer to load.
    RUBY
  end

  it 'registers an offense when when using powershell_out! to run Test-Path' do
    expect_offense(<<~RUBY)
      powershell_out!('Test-Path "C:\\Program Files\\LAPS\\CSE\\AdmPwd.dll"').stdout.strip == 'True'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use Ruby's built-in `File.exist?('C:\\somefile')` method instead of executing PowerShell's `Test-Path` cmdlet, which takes longer to load.
    RUBY
  end

  it 'does not register an offense when Test-Path is not the first cmdlet' do
    expect_no_offenses(<<~RUBY)
      powershell_out('FooBar; Test-Path "C:\\Program Files\\LAPS\\CSE\\AdmPwd.dll"').stdout.strip == 'True'
    RUBY
  end

  it 'does not register an offense when running other cmdlets in powershell_out' do
    expect_no_offenses(<<~RUBY)
      powershell_out('FooBar "C:\\Program Files\\LAPS\\CSE\\AdmPwd.dll"')
    RUBY
  end
end
