# frozen_string_literal: true
#
# Copyright:: 2021, Chef Software, Inc.
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

describe RuboCop::Cop::InSpec::Deprecations::AttributeDefault, :config do
  it 'registers an offense when an input method uses default' do
    expect_offense(<<~RUBY)
      login_defs_umask = input('login_defs_umask', default: '077', description: 'Default umask to set in login.defs')
                                                   ^^^^^^^ The InSpec inputs `default` option has been replaced with the `value` option.
    RUBY

    expect_correction(<<~RUBY)
      login_defs_umask = input('login_defs_umask', value: '077', description: 'Default umask to set in login.defs')
    RUBY
  end

  it 'registers an offense when an attribute method uses default' do
    expect_offense(<<~RUBY)
      login_defs_umask = attribute('login_defs_umask', default: '077', description: 'Default umask to set in login.defs')
                                                       ^^^^^^^ The InSpec inputs `default` option has been replaced with the `value` option.
    RUBY

    expect_correction(<<~RUBY)
      login_defs_umask = attribute('login_defs_umask', value: '077', description: 'Default umask to set in login.defs')
    RUBY
  end

  it "doesn't register an offense when an input method uses value" do
    expect_no_offenses(<<~RUBY)
      login_defs_umask = input('login_defs_umask', value: '077', description: 'Default umask to set in login.defs')
    RUBY
  end
end
