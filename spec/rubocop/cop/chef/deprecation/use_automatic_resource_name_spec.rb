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

describe RuboCop::Cop::Chef::Deprecations::UseAutomaticResourceName, :config do
  it 'registers an offense when using use_automatic_resource_name' do
    expect_offense(<<~RUBY)
      use_automatic_resource_name
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ The use_automatic_resource_name method was removed in Chef Infra Client 16. The resource name/provides should be set explicitly instead.
    RUBY

    expect_correction("\n")
  end
end
