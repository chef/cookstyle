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

describe RuboCop::Cop::Chef::Deprecations::UsesRunCommandHelper, :config do
  it 'registers an offense when a cookbook uses the run_command helper' do
    expect_offense(<<~RUBY)
      run_command(foo)
      ^^^^^^^^^^^^^^^^ Use 'shell_out!' instead of the legacy 'run_command' or 'run_command_with_systems_locale' helpers for shelling out. The run_command helper was removed in Chef Infra Client 13.
    RUBY
  end

  it 'registers an offense when a cookbook uses the run_command_with_systems_locale helper' do
    expect_offense(<<~RUBY)
      run_command_with_systems_locale(foo)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use 'shell_out!' instead of the legacy 'run_command' or 'run_command_with_systems_locale' helpers for shelling out. The run_command helper was removed in Chef Infra Client 13.
    RUBY
  end

  it "doesn't register an offense when using the run_command helper if it's defined in the same file" do
    expect_no_offenses(<<~RUBY)
      run_command(foo)

      def run_command(bar)
        baz(bar)
      end
    RUBY
  end

  it 'registers an offense when a cookbook requires the Chef::Mixin::Command module' do
    expect_offense(<<~RUBY)
      require 'chef/mixin/command'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use 'shell_out!' instead of the legacy 'run_command' or 'run_command_with_systems_locale' helpers for shelling out. The run_command helper was removed in Chef Infra Client 13.
    RUBY
  end

  it 'registers an offense when a cookbook includes the Chef::Mixin::Command module' do
    expect_offense(<<~RUBY)
      include Chef::Mixin::Command
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use 'shell_out!' instead of the legacy 'run_command' or 'run_command_with_systems_locale' helpers for shelling out. The run_command helper was removed in Chef Infra Client 13.
    RUBY
  end

  it "doesn't register an offense when using the run_command_with_systems_locale helper if it's defined in the same file" do
    expect_no_offenses(<<~RUBY)
      run_command_with_systems_locale(foo)

      def run_command_with_systems_locale(bar)
        baz(bar)
      end
    RUBY
  end
end
