# frozen_string_literal: true
#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefRedundantCode:: PropertySplatRegex, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a property includes regex: /.*/' do
    expect_offense(<<~RUBY)
      property :foo, String, regex: /.*/
                             ^^^^^^^^^^^ There is no need to validate the input of properties in resources using a regex value that will always pass.
    RUBY

    expect_correction("property :foo, String\n")
  end

  it 'registers an offense when an attribute includes regex: /.*/' do
    expect_offense(<<~RUBY)
      attribute :foo, String, regex: /.*/
                              ^^^^^^^^^^^ There is no need to validate the input of properties in resources using a regex value that will always pass.
    RUBY

    expect_correction("attribute :foo, String\n")
  end

  it "doesn't register an offense when a property sets desired_state: false" do
    expect_no_offenses('property :foo, String, desired_state: false')
  end
end
