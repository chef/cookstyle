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

describe RuboCop::Cop::Chef::Deprecations::DeprecatedYumRepositoryProperties, :config do
  it 'registers an offense when the using legacy yum_repository properties' do
    expect_offense(<<~RUBY)
      yum_repository 'OurCo' do
        description 'OurCo yum repository'
        url 'http://artifacts.ourco.org/foo/bar'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ With the release of Chef Infra Client 12.14 and the yum cookbook 3.0 several properties in the yum_repository resource were renamed. url -> baseurl, keyurl -> gpgkey, and mirrorexpire -> mirror_expire.
        keyurl 'http://artifacts.ourco.org/pub/yum/RPM-GPG-KEY-OURCO-6'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ With the release of Chef Infra Client 12.14 and the yum cookbook 3.0 several properties in the yum_repository resource were renamed. url -> baseurl, keyurl -> gpgkey, and mirrorexpire -> mirror_expire.
        mirrorexpire 1440
        ^^^^^^^^^^^^^^^^^ With the release of Chef Infra Client 12.14 and the yum cookbook 3.0 several properties in the yum_repository resource were renamed. url -> baseurl, keyurl -> gpgkey, and mirrorexpire -> mirror_expire.
        action :create
      end
    RUBY

    expect_correction(<<~RUBY)
      yum_repository 'OurCo' do
        description 'OurCo yum repository'
        baseurl 'http://artifacts.ourco.org/foo/bar'
        gpgkey 'http://artifacts.ourco.org/pub/yum/RPM-GPG-KEY-OURCO-6'
        mirror_expire 1440
        action :create
      end
    RUBY
  end

  it "doesn't register an offense when using new yum_repository properties" do
    expect_no_offenses(<<~RUBY)
      yum_repository 'OurCo' do
        description 'OurCo yum repository'
        baseurl 'http://artifacts.ourco.org/foo/bar'
        gpgkey 'http://artifacts.ourco.org/pub/yum/RPM-GPG-KEY-OURCO-6'
        mirror_expire 1440
        action :create
      end
    RUBY
  end
end
