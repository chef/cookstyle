# frozen_string_literal: true
#
# Copyright:: Copyright 2020, Chef Software Inc.
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

describe RuboCop::Cop::Chef::ChefDeprecations::MacosUserdefaultsGlobalProperty, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when macos_userdefaults set the global property' do
    expect_offense(<<~RUBY)
      macos_userdefaults 'set a value' do
        global true
        ^^^^^^^^^^^ The `global` property in the macos_userdefaults resource was deprecated in Chef Infra Client 16.3. Omitting the `domain` property will now set global defaults.
        key 'key'
        value 'value'
      end
    RUBY

    expect_correction(<<~RUBY)
      macos_userdefaults 'set a value' do
        key 'key'
        value 'value'
      end
    RUBY
  end

  it "doesn't register an offense when macos_userdefaults doesn't use the global property" do
    expect_no_offenses(<<~RUBY)
      macos_userdefaults 'set a value' do
        key 'key'
        value 'value'
      end
    RUBY
  end
end
