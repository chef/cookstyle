#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefStyle::TrueFalseResourceProperties do
  subject(:cop) { described_class.new }

  it 'registers an offense when a resource specifies the type of true, false' do
    expect_offense(<<~RUBY)
      property :foo, [true, false]
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use TrueClass and FalseClass in resource properties not true and false
    RUBY

    expect_correction("property :foo, [TrueClass, FalseClass]\n")
  end

  it 'does not register an offense when a resource property has a type of TrueClass,FalseClass' do
    expect_no_offenses('property :foo, [TrueClass, FalseClass]')
  end
end
