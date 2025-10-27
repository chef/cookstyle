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

describe RuboCop::Cop::Chef::Sharing::IncludeResourceDescriptions, :config do
  it 'registers an offense when a resource does not include a description' do
    expect_offense(<<~RUBY)
      resource_name 'foo'
      ^ Resources should include description fields to allow automated documentation. Requires Chef Infra Client 13.9 or later.
    RUBY
  end

  it "doesn't register an offense when a resource contains a description" do
    expect_no_offenses(<<~RUBY)
      resource_name 'foo'
      description 'foo does a thing'
    RUBY
  end

  it "doesn't register an offense when a resource contains a description with string interpolation" do
    expect_no_offenses(<<~'RUBY')
      resource_name 'foo'
      val = 'thing'
      description "foo does a #{val}"
    RUBY
  end
end
