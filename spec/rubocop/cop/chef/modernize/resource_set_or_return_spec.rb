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

describe RuboCop::Cop::Chef::Modernize::SetOrReturnInResources, :config do
  it 'registers an offense with a resource that uses set_or_return' do
    expect_offense(<<~RUBY)
      def sp_min(arg = nil)
        set_or_return(:sp_min, arg, kind_of: Integer)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use set_or_return within a method to define a property for a resource. Use the property method instead, which supports validation, reporting, and documentation functionality
      end
    RUBY
  end

  it 'does not register an offense with a resource that uses property' do
    expect_no_offenses(<<~RUBY)
      property :sp_min, Integer
    RUBY
  end
end
