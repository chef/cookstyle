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

describe RuboCop::Cop::Chef::Modernize::ExecuteScExe, :config do
  it "registers an offense when running execute 'sleep 60'" do
    expect_offense(<<~RUBY)
      execute "Delete chef-client service" do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 14.0 and later includes :create, :delete, and :configure actions with the full idempotency of the windows_service resource. See the windows_service documentation at https://docs.chef.io/resources/windows_service for additional details on creating services with the windows_service resource
        command "sc.exe delete chef-client"
        action :run
      end
    RUBY
  end

  it "doesn't register an offense for a command that doesn't start with sc.exe" do
    expect_no_offenses(<<~RUBY)
      execute "foo" do
        command "something something sc.exe"
        action :run
      end
    RUBY
  end

  context 'with TargetChefVersion set to 14' do
    let(:config) { target_chef_version(13) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        execute "Delete chef-client service" do
          command "sc.exe delete chef-client"
          action :run
        end
      RUBY
    end
  end
end
