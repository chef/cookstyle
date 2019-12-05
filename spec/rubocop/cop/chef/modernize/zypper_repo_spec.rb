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

describe RuboCop::Cop::Chef::ChefModernize::UsesZypperRepo, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using the zypper_repo resource' do
    expect_offense(<<~RUBY)
    zypper_repo 'apache' do
    ^^^^^^^^^^^^^^^^^^^^ The zypper_repo resource was renamed zypper_repository when it was added to Chef Infra Client 13.3.
      baseurl 'http://download.opensuse.org/repositories/Apache'
      path '/openSUSE_Leap_42.2'
      type 'rpm-md'
      priority '100'
    end
    RUBY

    expect_correction(<<~RUBY)
    zypper_repository 'apache' do
      baseurl 'http://download.opensuse.org/repositories/Apache'
      path '/openSUSE_Leap_42.2'
      type 'rpm-md'
      priority '100'
    end
    RUBY
  end

  it "doesn't register an offense when using the zypper_repository resource" do
    expect_no_offenses(<<~RUBY)
    zypper_repository 'apache' do
      baseurl 'http://download.opensuse.org/repositories/Apache'
      path '/openSUSE_Leap_42.2'
      type 'rpm-md'
      priority '100'
    end
    RUBY
  end

  context 'with TargetChefVersion set to 13.2' do
    let(:config) { target_chef_version(13.2) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        zypper_repo 'apache' do
          baseurl 'http://download.opensuse.org/repositories/Apache'
          path '/openSUSE_Leap_42.2'
          type 'rpm-md'
          priority '100'
        end
      RUBY
    end
  end
end
