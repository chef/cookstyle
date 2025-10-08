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

describe RuboCop::Cop::Chef::Modernize::IncludingWindowsDefaultRecipe, :config do
  it 'registers an offense when including the "windows" recipe' do
    expect_offense(<<~RUBY)
      include_recipe 'windows'
      ^^^^^^^^^^^^^^^^^^^^^^^^ Do not include the Windows default recipe, which only installs win32 gems already included in Chef Infra Client
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when including the "windows::default" recipe' do
    expect_offense(<<~RUBY)
      include_recipe 'windows::default'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not include the Windows default recipe, which only installs win32 gems already included in Chef Infra Client
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when including any other recipe" do
    expect_no_offenses(<<~RUBY)
      include_recipe 'foo'
    RUBY
  end
end
