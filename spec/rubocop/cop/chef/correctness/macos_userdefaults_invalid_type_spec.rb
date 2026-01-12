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

describe RuboCop::Cop::Chef::Correctness::MacosUserdefaultsInvalidType, :config do
  it 'registers an offense when an invalid type is set in macos_userdefaults' do
    expect_offense(<<~RUBY)
      macos_userdefaults 'set a value' do
        global true
        key 'key'
        type 'boolean'
        ^^^^^^^^^^^^^^ The macos_userdefaults resource prior to Chef Infra Client 16.3 would silently continue if invalid types were passed resulting in unexpected behavior. Valid values are: "array", "bool", "dict", "float", "int", and "string".
      end
    RUBY

    expect_correction(<<~RUBY)
      macos_userdefaults 'set a value' do
        global true
        key 'key'
        type 'bool'
      end
    RUBY
  end

  it "registers an offense even if it can't autocorrect it" do
    expect_offense(<<~RUBY)
      macos_userdefaults 'set a value' do
        global true
        key 'key'
        type 'total_fake_stuff'
        ^^^^^^^^^^^^^^^^^^^^^^^ The macos_userdefaults resource prior to Chef Infra Client 16.3 would silently continue if invalid types were passed resulting in unexpected behavior. Valid values are: "array", "bool", "dict", "float", "int", and "string".
      end
    RUBY

    expect_no_corrections
  end

  it 'does not register an offense with a valid type in macos_userdefaults' do
    expect_no_offenses(<<~RUBY)
      macos_userdefaults 'set a value' do
        global true
        key 'key'
        type 'bool'
      end
    RUBY
  end
end
