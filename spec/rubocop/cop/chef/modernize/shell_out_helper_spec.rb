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

describe RuboCop::Cop::Chef::Modernize::ShellOutHelper, :config do
  it "registers an offense when a resource runs Mixlib::ShellOut.new('foo').run_command" do
    expect_offense(<<~RUBY)
      Mixlib::ShellOut.new('foo').run_command
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the built-in `shell_out` helper available in Chef Infra Client 12.11+ instead of calling `Mixlib::ShellOut.new('foo').run_command`.
    RUBY

    expect_correction(<<~RUBY)
      shell_out('foo')
    RUBY
  end

  it 'does not register an offense when just Mixlib::ShellOut is used w/o run_command' do
    expect_no_offenses("Mixlib::ShellOut.new('foo')")
  end
end
