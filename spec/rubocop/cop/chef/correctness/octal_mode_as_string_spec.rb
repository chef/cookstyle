# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

describe RuboCop::Cop::Chef::Correctness::OctalModeAsString, :config do
  it 'registers an offense with an octal string mode' do
    expect_offense(<<~RUBY)
      file '/logs/foo/error.log' do
        mode '0o755'
        ^^^^^^^^^^^^ Don't represent file modes as strings containing octal values. Use standard base 10 file modes instead. For example: '0755'.
      end
    RUBY
  end

  it 'does not register an offense with a valid string mode' do
    expect_no_offenses(<<~RUBY)
      file '/logs/foo/error.log' do
        mode '0755'
      end
    RUBY
  end

  it 'does not register an offense with an octal mode' do
    expect_no_offenses(<<~RUBY)
      file '/logs/foo/error.log' do
        mode 0o755
      end
    RUBY
  end

  it 'does not register an offense when the mode argument is a non-string/integer' do
    expect_no_offenses(<<~RUBY)
      file '/logs/foo/error.log' do
        mode new_resource.mode
      end
    RUBY
  end
end
