#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefDeprecations::WindowsFeatureServermanagercmd, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when windows_feature sets install_method to :servermanagercmd' do
    expect_offense(<<~RUBY)
      windows_feature 'DHCP' do
        install_method :servermanagercmd
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The `windows_feature` resource no longer supports setting the `install_method` to `:servermanagercmd`. `:windows_feature_dism` or `:windows_feature_powershell` should be used instead.
      end
    RUBY
  end

  it "doesn't register an offense when windows_feature sets install_method to :windows_feature_dism" do
    expect_no_offenses(<<~RUBY)
      windows_feature 'DHCP' do
        install_method :windows_feature_dism
      end
    RUBY
  end
end
