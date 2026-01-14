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

describe RuboCop::Cop::Chef::Modernize::PowershellScriptExpandArchive, :config do
  it 'registers an offense when using the powershell_script to expand an archive' do
    expect_offense(<<~RUBY)
      powershell_script 'Expand website' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of using Expand-Archive in a powershell_script resource
        code 'Expand-Archive "C:\\file.zip" -DestinationPath "C:\\inetpub\\wwwroot\\" -Force'
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

  context 'with TargetChefVersion set to 14' do
    let(:config) { target_chef_version(14) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        powershell_script 'Expand website' do
          code 'Expand-Archive "C:\\file.zip" -DestinationPath "C:\\inetpub\\wwwroot\\" -Force'
        end
      RUBY
    end
  end
end
