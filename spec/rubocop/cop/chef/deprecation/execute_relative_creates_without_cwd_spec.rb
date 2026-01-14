# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Deprecations::ExecuteRelativeCreatesWithoutCwd, :config do
  it 'registers an offense when an execute resource has a relative creates property' do
    expect_offense(<<~RUBY)
      execute 'some_cmd' do
        creates 'something'
        ^^^^^^^^^^^^^^^^^^^ In Chef Infra Client 13 and later you must either specific an absolute path when using the `execute` resource's `creates` property or also use the `cwd` property.
      end
    RUBY
  end

  it "doesn't register an offense when an execute resource has a *nix absolute creates path" do
    expect_no_offenses(<<~RUBY)
      execute 'some_cmd' do
        creates '/tmp/something'
      end
    RUBY
  end

  it "doesn't register an offense when an execute resource has a Windows absolute creates path" do
    expect_no_offenses(<<~RUBY)
      execute 'some_cmd' do
        creates 'C:\tmp\something'
      end
    RUBY
  end

  it "doesn't register an offense when an execute resource has a relative creates path & a cwd value" do
    expect_no_offenses(<<~RUBY)
      execute 'some_cmd' do
        creates 'something'
        cwd '/tmp'
      end
    RUBY
  end
end
