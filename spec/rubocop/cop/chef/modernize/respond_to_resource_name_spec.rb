# frozen_string_literal: true
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

describe RuboCop::Cop::Chef::ChefModernize::RespondToResourceName, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense with a HWRP that uses respond_to? with resource_name' do
    expect_offense(<<~RUBY)
    class Chef
      class Resource
        class Icinga2Apiuser < Chef::Resource
          identity_attr :name

          def initialize(name, run_context = nil)
            super
            @resource_name = :icinga2_apiuser if respond_to?(:resource_name)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ respond_to?(:resource_name) in resources is no longer necessary in Chef Infra Client 12.5+
            @provides = :icinga2_apiuser
            @provider = Chef::Provider::Icinga2Instance
            @action = :create
            @allowed_actions = [:create, :delete, :nothing]
            @name = name
          end
        end
      end
    end
    RUBY

    expect_correction(<<~RUBY)
    class Chef
      class Resource
        class Icinga2Apiuser < Chef::Resource
          identity_attr :name

          def initialize(name, run_context = nil)
            super
            @resource_name = :icinga2_apiuser
            @provides = :icinga2_apiuser
            @provider = Chef::Provider::Icinga2Instance
            @action = :create
            @allowed_actions = [:create, :delete, :nothing]
            @name = name
          end
        end
      end
    end
    RUBY
  end

  it 'registers an offense with a HWRP that uses respond_to? with resource_name' do
    expect_no_offenses(<<~RUBY)
    class Chef
      class Resource
        class Icinga2Apiuser < Chef::Resource
          identity_attr :name

          def initialize(name, run_context = nil)
            super
            @resource_name = :icinga2_apiuser
            @provides = :icinga2_apiuser
            @provider = Chef::Provider::Icinga2Instance
            @action = :create
            @allowed_actions = [:create, :delete, :nothing]
            @name = name
          end
        end
      end
    end
    RUBY
  end

  it 'registers an offense with a LWRP that uses respond_to? with resource_name' do
    expect_offense(<<~RUBY)
    resource_name :icinga2_apiuser if respond_to?(:resource_name)
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ respond_to?(:resource_name) in resources is no longer necessary in Chef Infra Client 12.5+
    RUBY

    expect_correction(<<~RUBY)
    resource_name :icinga2_apiuser
    RUBY
  end

  it 'does not register an offense with a LWRP that does not use resource_name' do
    expect_no_offenses(<<~RUBY)
    resource_name :icinga2_apiuser
    RUBY
  end
end
