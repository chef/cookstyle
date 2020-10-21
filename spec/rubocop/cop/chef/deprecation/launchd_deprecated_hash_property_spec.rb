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

describe RuboCop::Cop::Chef::Deprecations::LaunchdDeprecatedHashProperty, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when the launchd resource uses the hash property' do
    expect_offense(<<~RUBY)
      launchd 'call.mom.weekly' do
        program '/Library/scripts/call_mom.sh'
        start_calendar_interval 'Weekday' => 7, 'Hourly' => 10
        hash foo: 'bar'
        ^^^^^^^^^^^^^^^ The launchd resource's hash property was renamed to plist_hash in Chef Infra Client 13+ to avoid conflicts with Ruby's hash class.
        time_out 300
      end
    RUBY

    expect_correction(<<~RUBY)
      launchd 'call.mom.weekly' do
        program '/Library/scripts/call_mom.sh'
        start_calendar_interval 'Weekday' => 7, 'Hourly' => 10
        plist_hash foo: 'bar'
        time_out 300
      end
    RUBY
  end

  it "doesn't register an offense when the launchd resource uses the plist_hash property" do
    expect_no_offenses(<<~RUBY)
      launchd 'call.mom.weekly' do
        program '/Library/scripts/call_mom.sh'
        start_calendar_interval 'Weekday' => 7, 'Hourly' => 10
        plist_hash foo: 'bar'
        time_out 300
      end
    RUBY
  end
end
