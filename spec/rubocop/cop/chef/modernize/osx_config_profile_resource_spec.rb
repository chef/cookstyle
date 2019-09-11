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

describe RuboCop::Cop::Chef::ChefModernize::OsxConfigProfileResource, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using the osx_config_profile resource' do
    expect_offense(<<~RUBY)
    osx_config_profile 'Install screensaver profile' do
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The osx_config_profile resource was renamed to osx_profile. The new resource name should be used.
      profile 'screensaver/com.company.screensaver.mobileconfig'
    end
    RUBY

    expect_correction(<<~RUBY)
    osx_profile 'Install screensaver profile' do
      profile 'screensaver/com.company.screensaver.mobileconfig'
    end
    RUBY
  end

  it "doesn't register an offense when using the osx_profile resource" do
    expect_no_offenses(<<~RUBY)
    osx_profile 'Install screensaver profile' do
      profile 'screensaver/com.company.screensaver.mobileconfig'
    end
    RUBY
  end
end
