#
# Copyright:: 2019-2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefModernize::DependsOnZypperCookbook, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when depending on the zypper cookbook' do
    expect_offense(<<~RUBY)
    depends 'zypper'
    ^^^^^^^^^^^^^^^^ Don't depend on the zypper cookbook as the zypper_repository resource is built into Chef Infra Client 13.3+
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when depending on other cookbooks" do
    expect_no_offenses(<<~RUBY)
      depends 'foo'
    RUBY
  end

  context 'with TargetChefVersion set to 13.2' do
    let(:config) { target_chef_version(13.2) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        depends 'zypper'
      RUBY
    end
  end
end
