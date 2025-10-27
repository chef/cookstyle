# frozen_string_literal: true

#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Modernize::PowershellInstallWindowsFeature, :config do
  it 'registers an offense when using powershell_script to run Install-WindowsFeature' do
    expect_offense(<<~RUBY)
      powershell_script 'Install Feature' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the windows_feature resource built into Chef Infra Client 14+ instead of using Install-WindowsFeature or Add-WindowsFeature in a powershell_script resource
        code 'Install-WindowsFeature -Name "Net-framework-Core"'
      end
    RUBY
  end

  it 'registers an offense when using powershell_script to run Add-WindowsFeature' do
    expect_offense(<<~RUBY)
      powershell_script 'Add Feature' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the windows_feature resource built into Chef Infra Client 14+ instead of using Install-WindowsFeature or Add-WindowsFeature in a powershell_script resource
        code 'Add-WindowsFeature -Name "Net-framework-Core"'
      end
    RUBY
  end

  it "doesn't register an offense when using powershell_script for other things" do
    expect_no_offenses(<<~RUBY)
      powershell_script 'Any old thing' do
        code 'Nope nope nope'
      end
    RUBY
  end

  context 'with TargetChefVersion set to 13' do
    let(:config) { target_chef_version(13) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        powershell_script 'Install Feature' do
          code 'Install-WindowsFeature -Name "Net-framework-Core"'
        end
      RUBY
    end
  end
end
