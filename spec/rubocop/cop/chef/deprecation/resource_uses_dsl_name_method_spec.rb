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

describe RuboCop::Cop::Chef::Deprecations::ResourceUsesDslNameMethod, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a resource uses the dsl_name method' do
    expect_offense(<<~RUBY)
      my_resource = MyResource.dsl_name
                    ^^^^^^^^^^^^^^^^^^^ Use resource_name instead of the dsl_name method in resources. This will cause failures in Chef Infra Client 13 and later.
    RUBY
  end

  it "doesn't register an offense when using the resource_name method" do
    expect_no_offenses(<<~RUBY)
      my_resource = MyResource.resource_name
    RUBY
  end
end
