# frozen_string_literal: true
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

describe RuboCop::Cop::Chef::Effortless::CookbookUsesDatabags, :config do
  it 'registers an offense when data_bag method is used' do
    expect_offense(<<~RUBY)
      data_bag_item('admins', login)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Cookbook uses data bags, which cannot be used in the Effortless Infra pattern
    RUBY
  end

  it 'registers an offense when data_bag_item method is used' do
    expect_offense(<<~RUBY)
      data_bag(data_bag_name)
      ^^^^^^^^^^^^^^^^^^^^^^^ Cookbook uses data bags, which cannot be used in the Effortless Infra pattern
    RUBY
  end
end
