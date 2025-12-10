# frozen_string_literal: true

#
# Copyright:: Copyright 2019, Chef Software Inc.
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

describe RuboCop::Cop::Chef::RedundantCode::AptRepositoryNotifiesAptUpdate, :config do
  it 'registers an offense when apt_repository notifies execute[apt-get update]' do
    expect_offense(<<~RUBY)
      apt_repository 'my repo' do
        uri 'http://packages.example.com/debian'
        components %w(stable main)
        deb_src false
        notifies :run, 'execute[apt-get update]', :immediately
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ There is no need to notify an apt-get update when an apt_repository is created as this is done automatically by the apt_repository resource.
      end
    RUBY

    expect_correction(<<~RUBY)
      apt_repository 'my repo' do
        uri 'http://packages.example.com/debian'
        components %w(stable main)
        deb_src false
      end
    RUBY
  end

  it 'does not register an offense with a plain old notification' do
    expect_no_offenses(<<~RUBY)
      apt_repository 'my repo' do
        uri 'http://packages.example.com/debian'
        components %w(stable main)
        deb_src false
        notifies :run, 'execute[foo]', :immediately
      end
    RUBY
  end
end
