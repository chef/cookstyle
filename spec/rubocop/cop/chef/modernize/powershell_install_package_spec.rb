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

describe RuboCop::Cop::Chef::Modernize::PowershellInstallPackage, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using powershell_script to run Install-Package' do
    expect_offense(<<~RUBY)
      powershell_script 'Expand website' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the powershell_package resource built into Chef Infra Client 12.16+ instead of using Install-Package in a powershell_script resource
        code 'Install-Package -Name docker'
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

  context 'with TargetChefVersion set to 12.15' do
    let(:config) { target_chef_version(12.15) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        powershell_script 'Expand website' do
          code 'Install-Package -Name docker'
        end
      RUBY
    end
  end
end
