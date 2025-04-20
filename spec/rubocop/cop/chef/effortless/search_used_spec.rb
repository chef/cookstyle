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

describe RuboCop::Cop::Chef::Effortless::CookbookUsesSearch, :config do
  it 'registers an offense when search is used' do
    expect_offense(<<~RUBY)
      search(:node, 'run_list:recipe[bacula::server]')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Cookbook uses search, which cannot be used in the Effortless Infra pattern
    RUBY
  end

  it "doesn't register an offense when a resource sets why-run to false" do
    expect_no_offenses(<<~RUBY)
      search_is_not_what_im_using(:node)
    RUBY
  end
end
