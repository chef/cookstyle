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

describe RuboCop::Cop::Chef::ChefModernize::ExecuteAptUpdate, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using execute to run apt-get update' do
    expect_offense(<<~RUBY)
    execute 'apt-get update' do
    ^^^^^^^^^^^^^^^^^^^^^^^^ Use the apt_update resource instead of the execute resource to run an apt-get update package cache update
      command 'apt-get update'
    end
    RUBY
  end

  it "doesn't register an offense when running another command in an execute resource" do
    expect_no_offenses(<<~RUBY)
      execute 'foo' do
        command 'bar'
      end
    RUBY
  end
end
