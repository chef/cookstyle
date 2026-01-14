# frozen_string_literal: true
#
# Copyright:: Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Ruby::LegacyPowershellOutMethods, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using powershell_out!' do
    expect_offense(<<~RUBY)
      powershell_out!('foo')
      ^^^^^^^^^^^^^^^^^^^^^^ Use powershell_exec!/powershell_exec instead of the slower legacy powershell_out!/powershell_out methods.
    RUBY
  end

  it 'registers an offense when using powershell_out' do
    expect_offense(<<~RUBY)
      powershell_out('foo')
      ^^^^^^^^^^^^^^^^^^^^^ Use powershell_exec!/powershell_exec instead of the slower legacy powershell_out!/powershell_out methods.
    RUBY
  end

  it "doesn't register an when using powershell_exec" do
    expect_no_offenses("powershell_exec('foo')")
  end

  it "doesn't register an when using powershell_exec!" do
    expect_no_offenses("powershell_exec!('foo')")
  end
end
