# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefDeprecations::ExecutePathProperty, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when an execute resource has a String path property' do
    expect_offense(<<~RUBY)\
      execute 'some_cmd' do
        path '/foo/bar'
        ^^^^^^^^^^^^^^^ In Chef Infra Client 13 and later you must set path env vars in execute resources using the `environment` property not the legacy `path` property.
      end
    RUBY
  end

  it 'registers an offense when an execute resource has an Array path property' do
    expect_offense(<<~RUBY)\
      execute 'some_cmd' do
        path ['/foo/bar']
        ^^^^^^^^^^^^^^^^^ In Chef Infra Client 13 and later you must set path env vars in execute resources using the `environment` property not the legacy `path` property.
      end
    RUBY
  end

  it "doesn't register an offense when a non-execute resource has a path property" do
    expect_no_offenses(<<~RUBY)
    foo 'bar' do
      path ['/foo/bar']
    end
    RUBY
  end
end
