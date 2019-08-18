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

describe RuboCop::Cop::Chef::NamePropertyIsRequired, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a resource property is both a name_property and a required property' do
    expect_offense(<<~RUBY)
      property :foo, String, name_property: true, required: true
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Resource properties marked as name properties should not also be required properties
    RUBY
  end

  it "doesn't register an offense with a required property that is not a name_property" do
    expect_no_offenses(<<~RUBY)
      property :foo, String, required: true
    RUBY
  end

  it "doesn't register an offense with name_property that is not required" do
    expect_no_offenses(<<~RUBY)
      property :foo, String, name_property: true
    RUBY
  end
end
