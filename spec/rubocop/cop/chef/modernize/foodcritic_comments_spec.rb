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

describe RuboCop::Cop::Chef::Modernize::FoodcriticComments, :config do
  it 'registers an offense with a foodcritic inline comment' do
    expect_offense(<<~RUBY)
      blah # ~FC013
           ^^^^^^^^ Remove legacy code comments that disable Foodcritic rules
    RUBY

    expect_correction("blah \n")
  end

  it 'registers an offense with a foodcritic comment above code' do
    expect_offense(<<~RUBY)
      # ~FC013
      ^^^^^^^^ Remove legacy code comments that disable Foodcritic rules
      blah
    RUBY

    expect_correction("\nblah\n")
  end

  it 'removes the entire comment if it starts with ~FCXXX' do
    expect_offense(<<~RUBY)
      # ~FC013 doesn't make sense here
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Remove legacy code comments that disable Foodcritic rules
      blah
    RUBY

    expect_correction("\nblah\n")
  end

  it "doesn't register an offense when a comment just mentions FCXXX" do
    expect_no_offenses(<<~RUBY)
      timezone 'UTC' # no need for ~FC123 here anymore
    RUBY
  end
end
