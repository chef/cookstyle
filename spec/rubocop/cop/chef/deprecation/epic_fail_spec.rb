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

describe RuboCop::Cop::Chef::Deprecations::EpicFail do
  subject(:cop) { described_class.new }

  it 'registers an offense when using epic_fail' do
    expect_offense(<<~RUBY)
      file '/foo' do
        owner 'root'
        epic_fail true
        ^^^^^^^^^^^^^^ Use ignore_failure method instead of the deprecated epic_fail method
      end
    RUBY

    expect_correction(<<~RUBY)
      file '/foo' do
        owner 'root'
        ignore_failure true
      end
    RUBY
  end

  it 'does not register an offense when using ignore_failure' do
    expect_no_offenses(<<~RUBY)
      file '/foo' do
        owner 'root'
        ignore_failure true
      end
    RUBY
  end
end
