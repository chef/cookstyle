# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

describe RuboCop::Cop::Chef::Modernize::MacOsXUserdefaults, :config do
  it 'registers an offense when using the mac_os_x_userdefaults resource' do
    expect_offense(<<~RUBY)
      mac_os_x_userdefaults 'full keyboard access to all controls' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The mac_os_x_userdefaults resource was renamed to macos_userdefaults when it was added to Chef Infra Client 14.0. The new resource name should be used.
        domain 'AppleKeyboardUIMode'
        global true
        value '2'
      end
    RUBY

    expect_correction(<<~RUBY)
      macos_userdefaults 'full keyboard access to all controls' do
        domain 'AppleKeyboardUIMode'
        global true
        value '2'
      end
    RUBY
  end

  it "doesn't register an offense when using the macos_userdefaults resource" do
    expect_no_offenses(<<~RUBY)
      macos_userdefaults 'full keyboard access to all controls' do
        domain 'AppleKeyboardUIMode'
        global true
        value '2'
      end
    RUBY
  end

  context 'with TargetChefVersion set to 13' do
    let(:config) { target_chef_version(13) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        mac_os_x_userdefaults 'full keyboard access to all controls' do
          domain 'AppleKeyboardUIMode'
          global true
          value '2'
        end
      RUBY
    end
  end
end
