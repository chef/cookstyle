#
# Copyright:: 2019-2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefRedundantCode::SensitivePropertyInResource, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a resource has a sensitive property with a default of false' do
    expect_offense(<<~RUBY)
    property :sensitive, [true, false], default: false
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Every Chef Infra resource already includes a sensitive property with a default value of false.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when a resource has a sensitive attribute with a default of false' do
    expect_offense(<<~RUBY)
    attribute :sensitive, [true, false], default: false
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Every Chef Infra resource already includes a sensitive property with a default value of false.
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when a resource has a sensitive property that defaults to true" do
    expect_no_offenses(<<~RUBY)
    property :sensitive, [true, false], default: true
    RUBY
  end
end
