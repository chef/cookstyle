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

describe RuboCop::Cop::Chef::ChefModernize::CronManageResource, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using the cron_manage resource' do
    expect_offense(<<~RUBY)
    cron_manage 'mike'
    ^^^^^^^^^^^^^^^^^^ The cron_manage resource was renamed to cron_access in the 6.1 release of the cron cookbook and later shipped in Chef Infra Client 14.4. The new resource name should be used.
    RUBY

    expect_correction(<<~RUBY)
    cron_access 'mike'
    RUBY
  end

  it "doesn't register an offense when using the cron_access resource" do
    expect_no_offenses(<<~RUBY)
    cron_access 'mike'
    RUBY
  end

  context 'with TargetChefVersion set to 14.3' do
    let(:config) { target_chef_version(14.3) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        cron_manage 'mike'
      RUBY
    end
  end
end
