# frozen_string_literal: true
#
# Copyright:: 2021, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Correctness::MetadataMissingVersion, :config do
  it 'registers an offense when the version method is missing' do
    expect_offense(<<~RUBY, '/foo/bar/metadata.rb')
      source_url 'http://github.com/something/something'
      ^ metadata.rb should define a version for the cookbook.
      depends 'foo'
    RUBY
  end

  it "doesn't register an offense when the version property is present" do
    expect_no_offenses(<<~RUBY)
      version '1.0.0'
    RUBY
  end
end
