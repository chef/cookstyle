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

describe RuboCop::Cop::Chef::Modernize::PowerShellGuardInterpreter, :config do
  it 'registers an offense when using the guard_interpreter is set to :powershell_script in a powershell_script resource' do
    expect_offense(<<~RUBY)
      powershell_script 'whatever' do
        code "mkdir test_dir"
        guard_interpreter :powershell_script
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ PowerShell is already set as the default guard interpreter for `powershell_script` and `batch` resources in Chef Infra Client 13 and later and does not need to be specified.
      end
    RUBY

    expect_correction(<<~RUBY)
      powershell_script 'whatever' do
        code "mkdir test_dir"
      end
    RUBY
  end

  it 'registers an offense when using the guard_interpreter is set to :powershell_script in a batch resource' do
    expect_offense(<<~RUBY)
      batch 'whatever' do
        code "mkdir test_dir"
        guard_interpreter :powershell_script
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ PowerShell is already set as the default guard interpreter for `powershell_script` and `batch` resources in Chef Infra Client 13 and later and does not need to be specified.
      end
    RUBY
  end

  it "doesn't register an offense when the guard_interpreter is set to something else in powershell_script" do
    expect_no_offenses(<<~RUBY)
      powershell_script 'whatever' do
        code "mkdir test_dir"
        guard_interpreter :foo
      end
    RUBY
  end

  it "doesn't register an offense when the guard_interpreter is set to PowerShell on another resource" do
    expect_no_offenses(<<~RUBY)
      execute 'mkdir testdir' do
        guard_interpreter :powershell_script
      end
    RUBY
  end

  context 'with TargetChefVersion set to 12' do
    let(:config) { target_chef_version(12) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        powershell_script 'whatever' do
          code "mkdir test_dir"
          guard_interpreter :powershell_script
        end
      RUBY
    end
  end
end
