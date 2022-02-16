# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
# Author:: Tim Smith (<tsmith84@gmail.com>)
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

describe RuboCop::Cop::Chef::Modernize::WindowsScResource, :config do
  it 'registers an offense when using the sc_windows resource' do
    expect_offense(<<~RUBY)
      sc_windows 'chef-client' do
      ^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 14.0 and later includes :create, :delete, and :configure actions without the need for the sc cookbook dependency. See the windows_service documentation at https://docs.chef.io/resources/windows_service for additional details.
        path "C:\\opscode\\chef\\bin"
        action :create
      end
    RUBY
  end

  context 'with TargetChefVersion set to 13' do
    let(:config) { target_chef_version(13) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        sc_windows 'chef-client' do
          path "C:\\opscode\\chef\\bin"
          action :create
        end
      RUBY
    end
  end
end
