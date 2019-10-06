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

describe RuboCop::Cop::Chef::ChefCorrectness::UnnecessaryNameProperty, :config do
  subject(:cop) { described_class.new(config) }

  #   property :name, String
  #   property :name, String, name_property: true

  it 'registers an offense when a resource has a property called name' do
    expect_offense(<<~RUBY)
      property :name, String
      ^^^^^^^^^^^^^^^^^^^^^^ There is no need to define a property named :name in a resource as Chef Infra defines that property for all resources out of the box.
    RUBY
  end

  it 'registers an offense when a resource has a property called name that is a name_property' do
    expect_offense(<<~RUBY)
      property :name, String, name_property: true
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to define a property named :name in a resource as Chef Infra defines that property for all resources out of the box.
    RUBY
  end

  it 'does not register an offense when when a resource defined the name property with a default value' do
    expect_no_offenses(<<~RUBY)
      property :name, String, default: ''
    RUBY
  end
end
