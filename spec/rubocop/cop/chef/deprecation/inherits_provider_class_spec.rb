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

describe RuboCop::Cop::Chef::ChefDeprecations::ProviderInheritsFromProviderClass, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a HWRP inherits from Chef::Provider' do
    expect_offense(<<~RUBY)
    class AptUpdate < Chef::Provider
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ To get the full functionality of Chef's Recipe DSL a HWRP style Provider should inherit from Chef::Provider::LWRPBase and not Chef::Provider.
      # some provider code
    end
    RUBY

    expect_correction(<<~RUBY)
    class AptUpdate < Chef::Provider::LWRPBase
      # some provider code
    end
    RUBY
  end

  it 'does not register an offense when a HWRP inherits from Chef::Provider::LWRPBase' do
    expect_no_offenses(<<~RUBY)
    class AptUpdate < Chef::Provider::LWRPBase
      # some provider code
    end
    RUBY
  end

  it 'does not register an offense when a HWRP inherits uses Poise' do
    expect_no_offenses(<<~RUBY)
    class AptUpdate < Chef::Provider
      include Poise
      # some provider code
    end
    RUBY
  end
end
