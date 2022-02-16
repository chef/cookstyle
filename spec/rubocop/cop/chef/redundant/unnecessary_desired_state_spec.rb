# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::RedundantCode::UnnecessaryDesiredState, :config do
  it 'registers an offense when metadata uses "attribute"' do
    expect_offense(<<~RUBY)
      property :foo, String, desired_state: true
                             ^^^^^^^^^^^^^^^^^^^ There is no need to set a property to desired_state: true as all properties have a desired_state of true by default.
    RUBY

    expect_correction("property :foo, String\n")
  end

  it "doesn't register an offense when a property sets desired_state: false" do
    expect_no_offenses('property :foo, String, desired_state: false')
  end
end
