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

describe RuboCop::Cop::Chef::Modernize::ExecuteSleep, :config do
  it "registers an offense when running execute 'sleep 60'" do
    expect_offense(<<~RUBY)
      execute "sleep 60"
      ^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include a chef_sleep resource that should be used to sleep between executing resources if necessary instead of using the bash or execute resources to run the sleep command.
    RUBY
  end

  it "registers an offense when running an execute resource with command 'sleep 60'" do
    expect_offense(<<~RUBY)
      execute "Sleep the Chef run" do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include a chef_sleep resource that should be used to sleep between executing resources if necessary instead of using the bash or execute resources to run the sleep command.
        command 'sleep 60'
      end
    RUBY
  end

  it "registers an offense when running an bash resource with code 'sleep 60'" do
    expect_offense(<<~RUBY)
      bash "Sleep the Chef run" do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include a chef_sleep resource that should be used to sleep between executing resources if necessary instead of using the bash or execute resources to run the sleep command.
        code 'sleep 60'
      end
    RUBY
  end

  context 'with TargetChefVersion set to 15.4' do
    let(:config) { target_chef_version(15.4) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        execute "sleep 60" do
          command "sleep 60"
          action :run
        end
      RUBY
    end
  end
end
