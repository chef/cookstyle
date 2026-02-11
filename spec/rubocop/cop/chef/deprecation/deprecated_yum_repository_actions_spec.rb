# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

describe RuboCop::Cop::Chef::Deprecations::DeprecatedYumRepositoryActions, :config do
  it 'registers an offense when the using legacy yum_repository delete action' do
    expect_offense(<<~RUBY)
      yum_repository 'OurCo' do
        action :delete
        ^^^^^^^^^^^^^^ With the release of Chef Infra Client 12.14 and the yum cookbook 3.0 the `yum_repository` resource actions were renamed. The `add` action became `create` and `delete` became `remove` to better match other resources in Chef Infra Client.
      end
    RUBY

    expect_correction(<<~RUBY)
      yum_repository 'OurCo' do
        action :remove
      end
    RUBY
  end

  it 'registers an offense when the using legacy yum_repository add action' do
    expect_offense(<<~RUBY)
      yum_repository 'OurCo' do
        baseurl 'http://artifacts.ourco.org/foo/bar'
        action :add
        ^^^^^^^^^^^ With the release of Chef Infra Client 12.14 and the yum cookbook 3.0 the `yum_repository` resource actions were renamed. The `add` action became `create` and `delete` became `remove` to better match other resources in Chef Infra Client.
      end
    RUBY

    expect_correction(<<~RUBY)
      yum_repository 'OurCo' do
        baseurl 'http://artifacts.ourco.org/foo/bar'
        action :create
      end
    RUBY
  end

  it "doesn't register an offense when using the yum_repository create action" do
    expect_no_offenses(<<~RUBY)
      yum_repository 'OurCo' do
        description 'OurCo yum repository'
        baseurl 'http://artifacts.ourco.org/foo/bar'
        gpgkey 'http://artifacts.ourco.org/pub/yum/RPM-GPG-KEY-OURCO-6'
        action :create
      end
    RUBY
  end

  it "doesn't register an offense when using the yum_repository remove action" do
    expect_no_offenses(<<~RUBY)
      yum_repository 'OurCo' do
        action :remove
      end
    RUBY
  end
end
