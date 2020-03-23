#
# Copyright:: Copyright 2020, Chef Software Inc.
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

describe RuboCop::Cop::Chef::ChefCorrectness::ConditionalRubyShellout do
  subject(:cop) { described_class.new }

  it 'registers an offense with a not_if that shells out using system' do
    expect_offense(<<~RUBY)
      cookbook_file '/logs/foo/error.log' do
        source 'error.log'
        not_if { system('wget https://www.bar.com/foobar.txt -O /dev/null') }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use Ruby to shellout in an only_if / not_if conditional when you can shellout directly by wrapping the command in quotes.
      end
    RUBY

    expect_correction(<<~RUBY)
      cookbook_file '/logs/foo/error.log' do
        source 'error.log'
        not_if 'wget https://www.bar.com/foobar.txt -O /dev/null'
      end
    RUBY
  end

  it 'registers an offense with a only_if that shells out using shell_out' do
    expect_offense(<<~RUBY)
      cookbook_file '/logs/foo/error.log' do
        source 'error.log'
        only_if { shell_out('wget https://www.bar.com/foobar.txt -O /dev/null').exitstatus == 0 }
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Don't use Ruby to shellout in an only_if / not_if conditional when you can shellout directly by wrapping the command in quotes.
      end
    RUBY

    expect_correction(<<~RUBY)
      cookbook_file '/logs/foo/error.log' do
        source 'error.log'
        only_if 'wget https://www.bar.com/foobar.txt -O /dev/null'
      end
    RUBY
  end

  it 'does not register an offense if shell_out calls methods other than exitstatus == 0' do
    expect_no_offenses(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
        only_if { shell_out('which docker').stdout.empty? }
      end
    RUBY
  end

  it 'does not register an offense if a conditional shells out directly using a string' do
    expect_no_offenses(<<~RUBY)
      template '/etc/foo' do
        mode '0644'
        source 'foo.erb'
        only_if 'which docker'
      end
    RUBY
  end
end
