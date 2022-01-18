# frozen_string_literal: true
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

describe RuboCop::Cop::Chef::Effortless::CookbookUsesPolicygroups, :config do
  it 'registers an offense when node.policygroup is used' do
    expect_offense(<<~RUBY)
      node.policy_group == 'webserver'
      ^^^^^^^^^^^^^^^^^ Cookbook uses Policy Groups, which cannot be used with Effortless Infra
    RUBY
  end
end
