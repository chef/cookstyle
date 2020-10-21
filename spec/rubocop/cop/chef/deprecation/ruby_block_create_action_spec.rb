# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Deprecations::RubyBlockCreateAction, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when ruby_block uses the :create action' do
    expect_offense(<<~RUBY)
      ruby_block 'my special ruby block' do
        block do
          puts 'running'
        end
        action :create
               ^^^^^^^ Use the :run action in the ruby_block resource instead of the deprecated :create action
      end
    RUBY

    expect_correction(<<~RUBY)
      ruby_block 'my special ruby block' do
        block do
          puts 'running'
        end
        action :run
      end
    RUBY
  end

  it "doesn't register an offense when ruby_block uses the :run action" do
    expect_no_offenses(<<~RUBY)
      ruby_block 'my special ruby block' do
        block do
          puts 'running'
        end
        action :run
      end
    RUBY
  end
end
