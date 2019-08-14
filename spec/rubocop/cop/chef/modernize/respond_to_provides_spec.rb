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

describe RuboCop::Cop::Chef::RespondToProvides, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense with a HWRP that uses respond_to? with provides' do
    expect_violation(<<-RUBY)
    class Chef
      class Provider
        class Icinga2Environment < Chef::Provider::LWRPBase
          provides :icinga2_environment if respond_to?(:provides)
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ respond_to?(:provides) in resources is no longer necessary in Chef Infra Client 12+
        end
      end
    end
    RUBY
  end

  it 'registers an offense with a LWRP that uses respond_to? with resource_name' do
    expect_violation(<<-RUBY)
    provides :icinga2_environment if respond_to?(:provides)
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ respond_to?(:provides) in resources is no longer necessary in Chef Infra Client 12+
    RUBY
  end

  it 'does not register an offense with a LWRP that does not use provides' do
    expect_no_violations(<<-RUBY)
    provides :icinga2_environment
    RUBY
  end
end
