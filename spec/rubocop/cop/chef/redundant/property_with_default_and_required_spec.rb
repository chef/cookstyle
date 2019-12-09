#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefRedundantCode::PropertyWithRequiredAndDefault, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a property has a default value and is required' do
    expect_offense(<<~RUBY)
    property :bob, String, required: true, default: 'foo'
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Resource property should not be both required and have a default value. This will fail on Chef Infra Client 13+
    RUBY
  end

  it "doesn't register an offense when a property is required with no default" do
    expect_no_offenses(<<~RUBY)
    property :bob, String, required: true
    RUBY
  end

  it "doesn't register an offense when a property isn't required but has a default" do
    expect_no_offenses(<<~RUBY)
    property :bob, String, default: 'foo'
    RUBY
  end
end
