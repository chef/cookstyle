# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Deprecations::DeprecatedShelloutMethods, :config do
  it 'registers an offense when using shell_out_compact' do
    expect_offense(<<~RUBY)
      shell_out_compact('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^^ Many legacy specialized shell_out methods were replaced in Chef Infra Client 14.3 and removed in Chef Infra Client 15. Use shell_out and any additional options if necessary.
    RUBY
  end

  it 'registers an offense when using shell_out_compact!' do
    expect_offense(<<~RUBY)
      shell_out_compact!('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^^^ Many legacy specialized shell_out methods were replaced in Chef Infra Client 14.3 and removed in Chef Infra Client 15. Use shell_out and any additional options if necessary.
    RUBY
  end

  it 'registers an offense when using shell_out_with_timeout' do
    expect_offense(<<~RUBY)
      shell_out_with_timeout('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Many legacy specialized shell_out methods were replaced in Chef Infra Client 14.3 and removed in Chef Infra Client 15. Use shell_out and any additional options if necessary.
    RUBY
  end

  it 'registers an offense when using shell_out_with_timeout!' do
    expect_offense(<<~RUBY)
      shell_out_with_timeout!('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Many legacy specialized shell_out methods were replaced in Chef Infra Client 14.3 and removed in Chef Infra Client 15. Use shell_out and any additional options if necessary.
    RUBY
  end

  it 'registers an offense when using shell_out_with_systems_locale' do
    expect_offense(<<~RUBY)
      shell_out_with_systems_locale('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Many legacy specialized shell_out methods were replaced in Chef Infra Client 14.3 and removed in Chef Infra Client 15. Use shell_out and any additional options if necessary.
    RUBY
  end

  it 'registers an offense when using shell_out_with_systems_locale!' do
    expect_offense(<<~RUBY)
      shell_out_with_systems_locale!('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Many legacy specialized shell_out methods were replaced in Chef Infra Client 14.3 and removed in Chef Infra Client 15. Use shell_out and any additional options if necessary.
    RUBY
  end

  it 'registers an offense when using shell_out_compact_timeout' do
    expect_offense(<<~RUBY)
      shell_out_compact_timeout('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Many legacy specialized shell_out methods were replaced in Chef Infra Client 14.3 and removed in Chef Infra Client 15. Use shell_out and any additional options if necessary.
    RUBY
  end

  it 'registers an offense when using shell_out_compact_timeout!' do
    expect_offense(<<~RUBY)
      shell_out_compact_timeout!('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Many legacy specialized shell_out methods were replaced in Chef Infra Client 14.3 and removed in Chef Infra Client 15. Use shell_out and any additional options if necessary.
    RUBY
  end

  it "doesn't register an offense when using shellout" do
    expect_no_offenses("shellout('foo')")
  end

  it "doesn't register an offense when using shellout!" do
    expect_no_offenses("shellout!('foo')")
  end
end
