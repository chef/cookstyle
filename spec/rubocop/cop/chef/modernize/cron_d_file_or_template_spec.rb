# frozen_string_literal: true
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

describe RuboCop::Cop::Chef::Modernize::CronDFileOrTemplate, :config do
  it 'registers an offense when using template to create a file in /etc/cron.d/' do
    expect_offense(<<~RUBY)
      template '/etc/cron.d/backup' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the cron_d resource that ships with Chef Infra Client 14.4+ instead of manually creating the file with template, file, or cookbook_file resources
        source 'cron_backup_job.erb'
        owner 'root'
        group 'root'
        mode '644'
      end
    RUBY
  end

  it 'registers an offense when using file to create a file in /etc/cron.d/' do
    expect_offense(<<~RUBY)
      file '/etc/cron.d/backup' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the cron_d resource that ships with Chef Infra Client 14.4+ instead of manually creating the file with template, file, or cookbook_file resources
        content '*/30 * * * * something /usr/local/bin/something'
        owner 'root'
        group 'root'
        mode '644'
      end
    RUBY
  end

  it 'registers an offense when using cookbook_file to create a file in /etc/cron.d/' do
    expect_offense(<<~RUBY)
      cookbook_file '/etc/cron.d/backup' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the cron_d resource that ships with Chef Infra Client 14.4+ instead of manually creating the file with template, file, or cookbook_file resources
        owner 'root'
        group 'root'
        mode '644'
      end
    RUBY
  end

  it 'registers an offense when using file to delete a file in /etc/cron.d/' do
    expect_offense(<<~RUBY)
      file '/etc/cron.d/backup' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the cron_d resource that ships with Chef Infra Client 14.4+ instead of manually creating the file with template, file, or cookbook_file resources
        action :delete
      end
    RUBY

    expect_offense(<<~'RUBY')
      file "/etc/cron.d/#{job_name}" do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the cron_d resource that ships with Chef Infra Client 14.4+ instead of manually creating the file with template, file, or cookbook_file resources
        action :delete
      end
    RUBY
  end

  it 'does not register an offense when the resource name is a variable or method' do
    expect_no_offenses(<<~RUBY)
      template foo do
        source "thing.erb"
      end
    RUBY
  end
end
