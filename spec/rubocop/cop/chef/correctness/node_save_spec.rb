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

describe RuboCop::Cop::Chef::Correctness::CookbookUsesNodeSave, :config do
  it 'registers an offense when a cookbook uses node.save' do
    expect_offense(<<~RUBY)
      node.save
      ^^^^^^^^^ Don't use node.save to save partial node data to the Chef Infra Server mid-run unless it's absolutely necessary. Node.save can result in failed Chef Infra runs appearing in search and increases load on the Chef Infra Server.
    RUBY
  end

  it "doesn't register an offense when a cookbook uses another node method" do
    expect_no_offenses(<<~RUBY)
      node.environment
    RUBY
  end
end
