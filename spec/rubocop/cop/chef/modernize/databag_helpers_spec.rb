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

describe RuboCop::Cop::Chef::Modernize::DatabagHelpers, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using Chef::DataBagItem.load' do
    expect_offense(<<~RUBY)
      Chef::DataBagItem.load('foo', 'bar')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `data_bag_item` helper instead of `Chef::DataBagItem.load` or `Chef::EncryptedDataBagItem.load`.
    RUBY

    expect_correction(<<~RUBY)
      data_bag_item('foo', 'bar')
    RUBY
  end

  it 'registers an offense when using Chef::EncryptedDataBagItem.load' do
    expect_offense(<<~RUBY)
      Chef::EncryptedDataBagItem.load('foo', 'bar')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `data_bag_item` helper instead of `Chef::DataBagItem.load` or `Chef::EncryptedDataBagItem.load`.
    RUBY

    expect_correction(<<~RUBY)
      data_bag_item('foo', 'bar')
    RUBY
  end
end
