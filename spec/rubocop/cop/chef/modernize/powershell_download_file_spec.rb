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

require 'spec_helper'

describe RuboCop::Cop::Chef::Modernize::PowershellDownloadFile, :config do
  it 'registers an offense when a powershell_script uses Invoke-WebRequest' do
    expect_offense(<<~RUBY)
      powershell_script 'download the installer' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the remote_file resource to download files instead of downloading them in a PowerShell script resource
        code 'Invoke-WebRequest -Uri https://example.com/foo.msi -OutFile C:/foo.msi'
      end
    RUBY
  end

  it 'registers an offense when a powershell_script uses Start-BitsTransfer' do
    expect_offense(<<~RUBY)
      powershell_script 'download the installer' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the remote_file resource to download files instead of downloading them in a PowerShell script resource
        code 'Start-BitsTransfer -Source https://example.com/foo.msi -Destination C:/foo.msi'
      end
    RUBY
  end

  it 'registers an offense when a powershell_script uses System.Net.WebClient' do
    expect_offense(<<~RUBY)
      powershell_script 'download the installer' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the remote_file resource to download files instead of downloading them in a PowerShell script resource
        code '(New-Object System.Net.WebClient).DownloadFile("https://example.com/foo.msi", "C:/foo.msi")'
      end
    RUBY
  end

  it 'registers an offense when a pwsh_script downloads a file' do
    expect_offense(<<~RUBY)
      pwsh_script 'download the installer' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the remote_file resource to download files instead of downloading them in a PowerShell script resource
        code 'Invoke-WebRequest -Uri https://example.com/foo.msi -OutFile C:/foo.msi'
      end
    RUBY
  end

  it "doesn't register an offense for an unrelated powershell_script" do
    expect_no_offenses(<<~RUBY)
      powershell_script 'set a thing' do
        code 'Set-ItemProperty -Path HKLM:/Foo -Name Bar -Value 1'
      end
    RUBY
  end

  it "doesn't register an offense when remote_file is already used" do
    expect_no_offenses(<<~RUBY)
      remote_file 'C:/foo.msi' do
        source 'https://example.com/foo.msi'
      end
    RUBY
  end

  it "doesn't register an offense for a script that queries rather than downloads" do
    expect_no_offenses(<<~RUBY)
      powershell_script 'check a thing' do
        code 'Get-Service -Name foo'
      end
    RUBY
  end
end
