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

describe RuboCop::Cop::Chef::UserDeprecatedSupportsProperty, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a user resource includes the supports property' do
    expect_offense(<<~RUBY)
      user "betty" do
        supports({
        ^^^^^^^^^^ The supports property was removed in Chef Infra Client 13 in favor of individual 'manage_home' and 'non_unique' properties.
          manage_home: true,
          non_unique: true
        })
      end

    RUBY
  end

  it "doesn't register an offense when the user resource uses the new properties" do
    expect_no_offenses(<<~RUBY)
      user "betty" do
        manage_home true
        non_unique true
      end
    RUBY
  end
end
