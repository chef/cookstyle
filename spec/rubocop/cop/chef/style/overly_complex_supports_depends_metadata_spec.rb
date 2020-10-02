# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefStyle::OverlyComplexSupportsDependsMetadata do
  subject(:cop) { described_class.new }

  it 'registers an offense when defining two supports in an array' do
    expect_offense(<<~RUBY)
      %w( debian ubuntu ).each do |os|
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't loop over an array to set cookbook dependencies or supported platforms if you have fewer than three values to set.
        supports os
      end
    RUBY

    expect_correction(<<~RUBY)
      supports 'debian'
      supports 'ubuntu'
    RUBY
  end

  it 'registers an offense when defining two depends in an array' do
    expect_offense(<<~RUBY)
      %w( apt yum ).each do |cb|
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't loop over an array to set cookbook dependencies or supported platforms if you have fewer than three values to set.
        depends cb
      end
    RUBY

    expect_correction(<<~RUBY)
      depends 'apt'
      depends 'yum'
    RUBY
  end

  it 'does not register an offense when defining three depends in an array' do
    expect_no_offenses(<<~RUBY)
      %w( apt yum windows ).each do |cb|
        depends cb
      end
    RUBY
  end
end
