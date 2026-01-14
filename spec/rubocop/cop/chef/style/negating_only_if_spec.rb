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

describe RuboCop::Cop::Chef::Style::NegatingOnlyIf, :config do
  it 'registers an offense when a only_if conditional negates ruby' do
    expect_offense(<<~RUBY)
      package 'legacy-sysv-deps' do
        only_if { !foo }
        ^^^^^^^^^^^^^^^^ Instead of using only_if conditionals with ! to negate the returned value, use not_if which is easier to read
      end
    RUBY

    expect_correction(<<~RUBY)
      package 'legacy-sysv-deps' do
        not_if { foo }
      end
    RUBY
  end

  it 'does not register an offense when an only_if condition double negates (!!) a variable' do
    expect_no_offenses(<<~RUBY)
      foo = true
      package 'legacy-sysv-deps' do
        only_if { !!foo }
      end
    RUBY
  end

  it 'does not register an offense when an only_if conditional double negates (!!) a non-variable' do
    expect_no_offenses(<<~RUBY)
      package 'legacy-sysv-deps' do
        only_if { !!foo }
      end
    RUBY
  end

  it 'does not register an offense when an only_if conditional does not negate ruby' do
    expect_no_offenses(<<~RUBY)
      package 'legacy-sysv-deps' do
        only_if { foo }
      end
    RUBY
  end

  it 'does not register an offense when an only_if conditional negates only a portion of the ruby conditional' do
    expect_no_offenses(<<~RUBY)
      package 'legacy-sysv-deps' do
        only_if { foo && !bar }
      end
    RUBY
  end

  it 'does not register an offense when an only_if conditional negates within the ruby in an inspec control' do
    expect_no_offenses(<<~RUBY)
      control 'nagios-daemon-01' do
        describe service(svc) do
          it { should be_running }
        end
        only_if { !(os.redhat? && os[:release].start_with?('6')) }
      end
    RUBY
  end
end
