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

describe RuboCop::Cop::Chef::ChefCorrectness::DnfPackageAllowDowngrades do
  subject(:cop) { described_class.new }

  it 'registers an offense when a dnf_package resource uses the allow_downgrades property' do
    expect_offense(<<~RUBY)
      dnf_package 'nginx' do
        version '1.2.3'
        allow_downgrades true
        ^^^^^^^^^^^^^^^^^^^^^ dnf_package does not support the allow_downgrades property
      end
    RUBY
  end

  it 'does not register an offense when a dnf_package resource does not set allow_downgrades' do
    expect_no_offenses(<<~RUBY)
      dnf_package 'nginx' do
        version '1.2.3'
      end
    RUBY
  end
end
