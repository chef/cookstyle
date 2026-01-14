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

describe RuboCop::Cop::Chef::Deprecations::DeprecatedSudoActions, :config do
  it 'registers an offense when the using legacy sudo :install action' do
    expect_offense(<<~RUBY)
      sudo 'bob' do
        action :install
        ^^^^^^^^^^^^^^^ The `sudo` resource in the sudo cookbook 5.0 (2018) or Chef Infra Client 14 and later have replaced the existing `:install` and `:remove` actions with `:create` and `:delete` actions to better match other resources in Chef Infra.
      end
    RUBY

    expect_correction(<<~RUBY)
      sudo 'bob' do
        action :create
      end
    RUBY
  end

  it 'registers an offense when the using legacy sudo :remove action' do
    expect_offense(<<~RUBY)
      sudo 'bob' do
        action :remove
        ^^^^^^^^^^^^^^ The `sudo` resource in the sudo cookbook 5.0 (2018) or Chef Infra Client 14 and later have replaced the existing `:install` and `:remove` actions with `:create` and `:delete` actions to better match other resources in Chef Infra.
      end
    RUBY

    expect_correction(<<~RUBY)
      sudo 'bob' do
        action :delete
      end
    RUBY
  end

  it "doesn't register an offense when using the sudo create action" do
    expect_no_offenses(<<~RUBY)
      sudo 'bob' do
        action :create
      end
    RUBY
  end

  it "doesn't register an offense when using the sudo remove action" do
    expect_no_offenses(<<~RUBY)
      sudo 'bob' do
        action :delete
      end
    RUBY
  end
end
