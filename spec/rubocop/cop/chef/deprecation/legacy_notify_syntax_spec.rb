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

describe RuboCop::Cop::Chef::ChefDeprecations::LegacyNotifySyntax, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a resource uses the legacy notification syntax w/o the timing' do
    expect_offense(<<~RUBY)
    foo 'bar' do
      notifies :restart, resources(service: 'apache')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the new-style notification syntax which allows you to notify resources defined later in a recipe or resource.
    end
    RUBY
  end

  it 'registers an offense when a resource uses the legacy notification syntax with the timing' do
    expect_offense(<<~RUBY)
    foo 'bar' do
      notifies :restart, resources(service: 'apache'), :immediately
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the new-style notification syntax which allows you to notify resources defined later in a recipe or resource.
    end
    RUBY
  end

  it "doesn't register an offense when using the modern notifies syntax" do
    expect_no_offenses(<<~RUBY)
    foo 'bar' do
      notifies :restart, 'service[apache]'
    end
    RUBY
  end
end
