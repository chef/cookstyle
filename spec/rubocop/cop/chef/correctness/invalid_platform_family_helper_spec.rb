# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
# Author:: Tim Smith (<tsmith@chef.io>)
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

describe RuboCop::Cop::Chef::Correctness::InvalidPlatformFamilyHelper, :config do
  it 'registers an offense when platform_family? passes "redhat"' do
    expect_offense(<<~RUBY)
      platform_family?('redhat')
                       ^^^^^^^^ Pass valid platform families to the platform_family? helper.
    RUBY

    expect_correction(<<~RUBY)
      platform_family?('rhel')
    RUBY
  end

  it 'removes arguments if the correct value is already in the list' do
    expect_offense(<<~RUBY)
      platform_family?('redhat', 'rhel', 'amazon')
                       ^^^^^^^^ Pass valid platform families to the platform_family? helper.
    RUBY

    expect_correction(<<~RUBY)
      platform_family?('rhel', 'amazon')
    RUBY
  end

  it 'does not autocorrect a platform family without a known mapping' do
    expect_offense(<<~RUBY)
      platform_family?('linux')
                       ^^^^^^^ Pass valid platform families to the platform_family? helper.
    RUBY

    expect_no_corrections
  end

  it "doesn't register an offense when platform_family? passes a valid platform" do
    expect_no_offenses(<<~RUBY)
      platform_family?('rhel')
    RUBY
  end
end
