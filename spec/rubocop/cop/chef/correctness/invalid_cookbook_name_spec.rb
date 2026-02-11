# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

describe RuboCop::Cop::Chef::Correctness::InvalidCookbookName, :config do
  it 'registers an offense when the name has a period' do
    expect_offense(<<~RUBY, '/foo/bar/metadata.rb')
      name 'foo.bar'
      ^^^^^^^^^^^^^^ Cookbook names should not contain invalid characters such as periods.
      depends 'foo'
    RUBY
  end

  it "doesn't register an offense when the name isn't a string" do
    expect_no_offenses(<<~RUBY)
      name name_variable
    RUBY
  end

  it "doesn't register an offense when the name does not contain a period" do
    expect_no_offenses(<<~RUBY)
      name 'foo_bar'
    RUBY
  end
end
