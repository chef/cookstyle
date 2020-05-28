#
# Copyright:: Copyright 2020, Chef Software Inc.
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

describe RuboCop::Cop::Chef::ChefCorrectness::LazyEvalNodeAttributeDefaults do
  subject(:cop) { described_class.new }

  it 'registers an offense when a property includes a non-lazy attribute as a default' do
    expect_offense(<<~RUBY)
      property :Something, String, default: node['hostname']
                                            ^^^^^^^^^^^^^^^^ When setting a node attribute as the default value for a custom resource property, wrap the node attribute in `lazy {}` so that its value is available when the resource executes.
    RUBY

    expect_correction(<<~RUBY)
      property :Something, String, default: lazy { node['hostname'] }
    RUBY
  end

  it 'does not register an offense when a property includes a lazy attribute as a default' do
    expect_no_offenses("property :Something, String, default: lazy { node['hostname'] }")
  end

  it 'does not register an offense when a property includes non-attribute default' do
    expect_no_offenses("property :Something, String, default: 'Some value'")
  end

  it 'does not register an offense when a property does not have a default' do
    expect_no_offenses('property :Something, String')
  end
end
