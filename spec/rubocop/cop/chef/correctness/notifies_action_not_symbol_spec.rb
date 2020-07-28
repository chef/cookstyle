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

describe RuboCop::Cop::Chef::ChefCorrectness::NotifiesActionNotSymbol do
  subject(:cop) { described_class.new }

  it 'registers an offense when a notifies action is a string' do
    expect_offense(<<~RUBY)
      execute 'some command' do
        notifies 'restart', 'service[httpd]', 'delayed'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Resource notification and subscription actions should be symbols not strings.
      end
    RUBY

    expect_correction(<<~RUBY)
      execute 'some command' do
        notifies :restart, 'service[httpd]', 'delayed'
      end
    RUBY
  end

  it 'registers an offense when a subscribes action is a string' do
    expect_offense(<<~RUBY)
      execute 'some command' do
        subscribes 'restart', 'service[httpd]', 'delayed'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Resource notification and subscription actions should be symbols not strings.
      end
    RUBY

    expect_correction(<<~RUBY)
      execute 'some command' do
        subscribes :restart, 'service[httpd]', 'delayed'
      end
    RUBY
  end

  it 'does not register an offense when the notifies action is a symbol' do
    expect_no_offenses(<<~RUBY)
      execute 'some command' do
        notifies :restart, 'service[httpd]', 'delayed'
      end
    RUBY
  end
end
