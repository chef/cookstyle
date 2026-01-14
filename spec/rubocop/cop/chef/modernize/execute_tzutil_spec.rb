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

describe RuboCop::Cop::Chef::Modernize::ExecuteTzUtil, :config do
  it 'registers an offense when using the execute resource with a command running tzutil' do
    expect_offense(<<~RUBY)
      execute 'set tz' do
      ^^^^^^^^^^^^^^^^^^^ Use the timezone resource included in Chef Infra Client 14.6+ instead of shelling out to tzutil
        command 'tzutil.exe /s UTC'
      end
    RUBY
  end

  it 'registers an offense when using the execute resource to run tzutil' do
    expect_offense(<<~RUBY)
      execute 'tzutil /s UTC'
      ^^^^^^^^^^^^^^^^^^^^^^^ Use the timezone resource included in Chef Infra Client 14.6+ instead of shelling out to tzutil
    RUBY
  end

  it 'registers an offense when using the powershell_script resource to run tzutil' do
    expect_offense(<<~RUBY)
      powershell_script 'set windows timezone' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the timezone resource included in Chef Infra Client 14.6+ instead of shelling out to tzutil
        code "tzutil.exe /s UTC"
        not_if { shell_out('tzutil.exe /g').stdout.include?('UTC') }
      end
    RUBY
  end

  it "doesn't register an offense when using the timezone resource" do
    expect_no_offenses(<<~RUBY)
      timezone 'UTC'
    RUBY
  end

  context 'with TargetChefVersion set to 14.5' do
    let(:config) { target_chef_version(14.5) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        execute 'set tz' do
          command 'tzutil.exe /s UTC'
        end
      RUBY
    end
  end
end
