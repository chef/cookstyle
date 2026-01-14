# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
# Author:: Tim Smith (<tsmith84@gmail.com>)
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

describe RuboCop::Cop::Chef::Deprecations::PartialSearchHelperUsage, :config do
  it 'registers an offense when using the partial_search helper' do
    expect_offense(<<~RUBY)
      partial_search(:node, 'role:web',
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Legacy partial_search usage should be updated to use :filter_result in the search helper instead
        keys: { 'name' => [ 'name' ],
                'ip' => [ 'ipaddress' ],
                'kernel_version' => %w(kernel version),
                  }
      ).each do |result|
        puts result['name']
        puts result['ip']
        puts result['kernel_version']
      end
    RUBY
  end

  it "doesn't register an offense when using the search helper" do
    expect_no_offenses(<<~RUBY)
      search(:node, 'role:web',
        filter_result: { 'name' => [ 'name' ],
                          'ip' => [ 'ipaddress' ],
                          'kernel_version' => %w(kernel version),
                  }
      ).each do |result|
        puts result['name']
        puts result['ip']
        puts result['kernel_version']
      end
    RUBY
  end
end
