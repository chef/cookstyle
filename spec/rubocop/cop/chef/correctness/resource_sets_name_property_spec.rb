# frozen_string_literal: true

#
# Copyright:: 2016, Chris Henry
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

describe RuboCop::Cop::Chef::Correctness::ResourceSetsNameProperty, :config do
  it 'registers an offense when a resource sets the name property' do
    expect_offense(<<~RUBY)
      service 'foo' do
       name 'bar'
       ^^^^^^^^^^ Resource sets the name property in the resource instead of using a name_property.
      end
    RUBY
  end

  it 'does not register an offense when when a resource sets other properties' do
    expect_no_offenses(<<~RUBY)
      service 'foo' do
          not_name 'bar'
        end
    RUBY
  end
end
