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

describe RuboCop::Cop::Chef::IncludingMixinShelloutInResources, :config do
  subject(:cop) { described_class.new(config) }

      #
      #   include Chef::Mixin::ShellOut

  it 'registers an error when requiring "chef/mixin/shell_out"' do
    expect_offense(<<~RUBY)
    require 'chef/mixin/shell_out'
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to include Chef::Mixin::ShellOut in resources or providers as this is already done by Chef Infra Client.
    RUBY
  end

  it 'registers an error when including "Chef::Mixin::ShellOut"' do
    expect_offense(<<~RUBY)
    include Chef::Mixin::ShellOut
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to include Chef::Mixin::ShellOut in resources or providers as this is already done by Chef Infra Client.
    RUBY
  end

  it "doesn't register an offense when including Chef::Mixin::Foo" do
    expect_no_offenses(<<~RUBY)
    include Chef::Mixin::Foo
    RUBY
  end

  it "doesn't register an offense when requirinng chef/mixin/foo" do
    expect_no_offenses(<<~RUBY)
    require 'chef/mixin/foo'
    RUBY
  end
end
