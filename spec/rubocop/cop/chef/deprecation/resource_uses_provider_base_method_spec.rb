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

describe RuboCop::Cop::Chef::Deprecations::ResourceUsesProviderBaseMethod, :config do
  it 'registers an offense when a resource uses the provider_base method' do
    expect_offense(<<~RUBY)
      provider_base ::Chef::Provider::SomethingSomething
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use the deprecated provider_base method in a resource to specify the provider module to use. Instead, the provider should call provides to register itself, or the resource should call provider to specify the provider to use. This will cause failures in Chef Infra Client 13 and later.
    RUBY
  end
end
