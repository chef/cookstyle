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

describe RuboCop::Cop::Chef::RedundantCode::StringPropertyWithNilDefault, :config do
  it 'registers an offense when a String property has a nil default' do
    expect_offense(<<~RUBY)
      property :config_file, String, default: nil
                                     ^^^^^^^^^^^^ Properties have a nil value by default so there is no need to set the default value to nil.
    RUBY

    expect_correction("property :config_file, String\n")
  end

  it 'registers an offense when a String/NilClass property has a nil default' do
    expect_offense(<<~RUBY)
      property :config_file, [String, NilClass], default: nil
                                                 ^^^^^^^^^^^^ Properties have a nil value by default so there is no need to set the default value to nil.
    RUBY

    expect_correction("property :config_file, [String, NilClass]\n")
  end

  it 'registers an offense when a String/nil property has a nil default' do
    expect_offense(<<~RUBY)
      property :config_file, [String, nil], default: nil
                                            ^^^^^^^^^^^^ Properties have a nil value by default so there is no need to set the default value to nil.
    RUBY

    expect_correction("property :config_file, [String, nil]\n")
  end

  it "doesn't register an offense when a property has a non-nil default" do
    expect_no_offenses(<<~RUBY)
      property :bob, String, default: 'foo'
    RUBY
  end
end
