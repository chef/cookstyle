# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
# Author:: Tim Smith (<tsmith84@gmail.com>)
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

describe RuboCop::Cop::Chef::Style::TrueClassFalseClassResourceProperties, :config do
  it 'registers an offense when a resource specifies the type of TrueClass, FalseClass' do
    expect_offense(<<~RUBY)
      property :foo, [TrueClass, FalseClass]
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ When setting the allowed types for a resource to accept either true or false values it's much simpler to use true and false instead of TrueClass and FalseClass.
    RUBY

    expect_correction("property :foo, [true, false]\n")
  end

  it 'does not register an offense when a resource property has a type of true, false' do
    expect_no_offenses('property :foo, [true, false]')
  end
end
