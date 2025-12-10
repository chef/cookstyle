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

describe RuboCop::Cop::Chef::Correctness::InvalidPlatformValueForPlatformFamilyHelper, :config do
  it 'registers an offense when value_for_platform_family passes "sles"' do
    expect_offense(<<~RUBY)
      value_for_platform_family(
        %w(rhel sles) => 'foo',
                ^^^^ Pass valid platform families to the value_for_platform_family helper.
        %w(mac_os_x) => 'foo'
      )
    RUBY
  end

  it "doesn't register an offense when value_for_platform_family passes valid platforms" do
    expect_no_offenses(<<~RUBY)
      value_for_platform_family(
        %w(rhel suse) => 'foo',
        %w(mac_os_x) => 'foo'
      )
    RUBY
  end
end
