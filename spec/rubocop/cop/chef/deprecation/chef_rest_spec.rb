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

describe RuboCop::Cop::Chef::ChefDeprecations::UsesChefRESTHelpers, :config do
  subject(:cop) { described_class.new(config) }

  it "registers an offense when requiring 'chef/rest'" do
    expect_offense(<<~RUBY)
      require 'chef/rest'
      ^^^^^^^^^^^^^^^^^^^ Don't use the helpers in Chef::REST which were removed in Chef Infra Client 13
    RUBY
  end

  it 'registers an offense when using helpers from Chef::REST' do
    expect_offense(<<~RUBY)
    Chef::REST::RESTRequest.new(:GET, foo, nil).call
    ^^^^^^^^^^ Don't use the helpers in Chef::REST which were removed in Chef Infra Client 13
    RUBY
  end
end
