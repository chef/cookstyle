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

describe RuboCop::Cop::Chef::Correctness::SupportsMustBeFloat, :config do
  it 'registers an offense when a version constraint uses an integer' do
    expect_offense(<<~RUBY)
      supports 'redhat', '> 8'
                         ^^^^^ Versions used in metadata.rb supports calls should be floats not integers.
    RUBY

    expect_correction(<<~RUBY)
      supports 'redhat', '> 8.0'
    RUBY
  end

  it 'does not register an offense when supports has no constraint' do
    expect_no_offenses("supports 'redhat'")
  end

  it 'does not register an offense when the supports constraint uses a float' do
    expect_no_offenses("supports 'redhat', '> 8.0'")
  end
end
