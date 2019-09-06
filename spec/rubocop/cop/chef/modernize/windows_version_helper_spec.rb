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

describe RuboCop::Cop::Chef::ChefModernize::WindowsVersionHelper, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using Windows::VersionHelper helpers' do
    expect_offense(<<~RUBY)
    if Windows::VersionHelper.nt_version == 10
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['platform_version'] data instead of the Windows::VersionHelper helper from the Windows cookbook.
      puts 'Windows 10'
    end
    RUBY
  end

  it "doesn't register an offense when using node['platform_version']" do
    expect_no_offenses(<<~RUBY)
    if node['platform_version'].to_i == 10
      puts 'Windows 10'
    end
    RUBY
  end
end
