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

describe RuboCop::Cop::Chef::Modernize::ShellOutToChocolatey, :config do
  it 'registers an offense when using execute to run choco' do
    expect_offense(<<~RUBY)
      execute 'install package foo' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the Chocolatey resources built into Chef Infra Client instead of shelling out to the choco command
        command "choco install --source=artifactory foo -y --no-progress --ignore-package-exit-codes"
      end
    RUBY
  end

  it 'registers an offense when using powershell_script to run choco' do
    expect_offense(<<~RUBY)
      powershell_script 'add artifactory choco source' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the Chocolatey resources built into Chef Infra Client instead of shelling out to the choco command
        code "choco source add -n=artifactory -s='https://mycorp.jfrog.io/mycorp/api/nuget/chocolatey-remote' -u foo -p bar"
        not_if 'choco source list | findstr artifactory'
      end
    RUBY
  end

  it "doesn't register an offense when using any old powershell_script resource" do
    expect_no_offenses(<<~RUBY)
      powershell_script 'foo' do
        code "totally not choco source add"
      end
    RUBY
  end

  it "doesn't register an offense when using any old execute resource" do
    expect_no_offenses(<<~RUBY)
      execute 'foo' do
        command "totally not choco install"
      end
    RUBY
  end
end
