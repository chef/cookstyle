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

describe RuboCop::Cop::Chef::Deprecations::ErlCallResource, :config do
  it 'registers an offense when using the easy_install resource' do
    expect_offense(<<~RUBY)
      erl_call "my_thing" do
      ^^^^^^^^^^^^^^^^^^^ Don't use the deprecated erl_call resource removed in Chef Infra Client 13
        bar
      end
    RUBY
  end

  it 'does not register an offense when using any other resource' do
    expect_no_offenses(<<~RUBY)
      file '/foo' do
        owner 'root'
        ignore_failure true
      end
    RUBY
  end
end
