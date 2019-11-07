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

describe RuboCop::Cop::Chef::ChefDeprecations::PartialSearchClassUsage, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using the Chef::PartialSearch class directly' do
    expect_offense(<<~RUBY)
      ::Chef::PartialSearch.new.search(search_key, query, :keys => partial_search_keys, :sort => sort_key) do |config|
        ^^^^^^^^^^^^^^^^^^^^^^^^^ Legacy Chef::PartialSearch class usage should be updated to use the search helper instead with the filter_results key.
        puts result['name']
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
