# frozen_string_literal: true

#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Deprecations::LogResourceNotifications, :config do
  it 'registers an offense when a log resource includes a notification' do
    expect_offense(<<~RUBY)
      log 'Aggregate notifications using a single log resource' do
        notifies :restart, 'service[foo]', :delayed
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ In Chef Infra Client 16 the log resource no longer notifies when logging so notifications should not be triggered from log resources. Use the notify_group resource introduced in Chef Infra Client 15.8 instead to aggregate notifications.
      end
    RUBY
  end

  it "doesn't register an offense when a log resource doesn't include a notification" do
    expect_no_offenses(<<~RUBY)
      log 'Just a log resource' do
        action :write
      end
    RUBY
  end
end
