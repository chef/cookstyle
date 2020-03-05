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

describe RuboCop::Cop::Chef::ChefCorrectness::ChefApplicationFatal do
  subject(:cop) { described_class.new }

  it 'registers an offense when Chef::Application.fatal! is called' do
    expect_offense(<<~RUBY)
      Chef::Application.fatal!('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use raise to force Chef Infra Client to fail instead of using Chef::Application.fatal
    RUBY

    expect_correction(<<~RUBY)
      raise('foo')
    RUBY
  end
end
