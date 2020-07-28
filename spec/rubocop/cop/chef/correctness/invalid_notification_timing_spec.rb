# frozen_string_literal: true
#
# Copyright:: Copyright 2019, Chef Software Inc.
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

describe RuboCop::Cop::Chef::ChefCorrectness::InvalidNotificationTiming do
  subject(:cop) { described_class.new }

  it 'registers an offense with an invalid notification timing' do
    expect_offense(<<~RUBY)
      execute 'some command' do
        notifies :restart, 'service[httpd]', :now
                                             ^^^^ Valid notification timings are :immediately, :immediate (alias for :immediately), :delayed, and :before.
      end
    RUBY
  end

  it 'does not register an offense with a valid notification timing' do
    expect_no_offenses(<<~RUBY)
      execute 'some command' do
        notifies :restart, 'service[httpd]', :delayed
      end
    RUBY
  end

  it 'does not register an offense when there is no timing' do
    expect_no_offenses(<<~RUBY)
      execute 'some command' do
        notifies :restart, 'service[httpd]'
      end
    RUBY
  end
end
