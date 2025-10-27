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

describe RuboCop::Cop::Chef::Modernize::SimplifyAptPpaSetup, :config do
  it 'registers an offense and apt_repository contains a PPA repo in http(s) form' do
    expect_offense(<<~RUBY)
      apt_repository 'atom-ppa' do
        uri 'http://ppa.launchpad.net/webupd8team/atom/ubuntu'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The apt_repository resource allows setting up PPAs without using the full URL to ppa.launchpad.net.
        components ['main']
        keyserver 'keyserver.ubuntu.com'
        key 'C2518248EEA14886'
      end
    RUBY
  end

  it "doesn't register an offense when apt_repository sets a non-PPA uri" do
    expect_no_offenses(<<~RUBY)
      apt_repository 'atom-ppa' do
        uri 'http://foo.bar.com/ubuntu'
        components ['main']
      end
    RUBY
  end

  it "doesn't register an offense with a simplified PPA uri" do
    expect_no_offenses(<<~RUBY)
      apt_repository 'atom-ppa' do
        uri 'ppa:webupd8team/atom'
        components ['main']
        keyserver 'keyserver.ubuntu.com'
        key 'C2518248EEA14886'
      end
    RUBY
  end
end
