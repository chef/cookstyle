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

describe RuboCop::Cop::Chef::ChefSharing::IncludeResourceExamples, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a resource does not include examples' do
    expect_offense(<<~RUBY)
      provides 'foo'
      ^ Resources should include examples field to allow automated documentation. Requires Chef Infra Client 13.9 or later.
    RUBY
  end

  it "doesn't register an offense when a resource contains examples" do
    expect_no_offenses(<<~RUBY)
      provides 'foo'
      examples <<~DOC
        **Specify a global domain value**

        ```ruby
        macos_userdefaults 'full keyboard access to all controls' do
          key 'AppleKeyboardUIMode'
          value '2'
        end
        ```
      DOC
    RUBY
  end
end
