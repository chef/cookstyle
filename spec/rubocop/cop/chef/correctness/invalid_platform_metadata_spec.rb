# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Correctness::InvalidPlatformMetadata, :config do
  it 'registers an offense when a cookbook contains an invalid supports platform' do
    expect_offense(<<~RUBY)
      supports 'darwin'
               ^^^^^^^^ metadata.rb "supports" platform is invalid
      depends 'foo'
    RUBY

    expect_correction(<<~RUBY)
      supports 'mac_os_x'
      depends 'foo'
    RUBY
  end

  it 'registers offenses for invalid platforms defined in a loop' do
    expect_offense(<<~RUBY)
      %w(ubuntu centos redhat fedora amazon rhel).each do |os|
                                            ^^^^ metadata.rb "supports" platform is invalid
        supports os
      end
    RUBY

    expect_correction(<<~RUBY)
      %w(ubuntu centos redhat fedora amazon redhat).each do |os|
        supports os
      end
    RUBY
  end

  it "doesn't register an offense when a cookbook contains a valid supports platform" do
    expect_no_offenses(<<~RUBY)
      supports 'mac_os_x'
    RUBY
  end
end
