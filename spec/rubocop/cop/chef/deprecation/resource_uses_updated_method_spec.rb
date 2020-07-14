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

describe RuboCop::Cop::Chef::ChefDeprecations::ResourceUsesUpdatedMethod, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a resource uses update method' do
    expect_offense(<<~RUBY)
      action :foo do
        updated = true
        ^^^^^^^^^^^^^^ Don't use updated = true/false to update resource state. This will cause failures in Chef Infra Client 13 and later.
      end
    RUBY
  end

  it "doesn't register an offense when using updated_by_last_action instead" do
    expect_no_offenses(<<~RUBY)
      action :foo do
        new_resource.updated_by_last_action true
      end
    RUBY
  end
end
