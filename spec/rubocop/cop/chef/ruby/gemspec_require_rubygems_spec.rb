# frozen_string_literal: true
#
#  Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

describe RuboCop::Cop::Chef::Ruby::GemspecRequireRubygems, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when requiring rubygems' do
    expect_offense(<<~RUBY)
      require "rubygems"
      ^^^^^^^^^^^^^^^^^^ Rubygems does not need to be required in a Gemspec. It's already loaded out of the box in Ruby now.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when requiring rubygems with a conditional' do
    expect_offense(<<~RUBY)
      require "rubygems" unless defined?(Gem)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Rubygems does not need to be required in a Gemspec. It's already loaded out of the box in Ruby now.
    RUBY

    expect_correction("\n")
  end
end
