# frozen_string_literal: true
#
# Copyright:: 2016, Chris Henry
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

describe RuboCop::Cop::Chef::Correctness::ResourceWithNoneAction, :config do
  it 'registers an offense when a resource calls the :none action' do
    expect_offense(<<~RUBY)
      execute 'apache_start' do
        action :none
               ^^^^^ Resource uses the nonexistent :none action instead of the :nothing action
      end
    RUBY

    expect_correction(<<~RUBY)
      execute 'apache_start' do
        action :nothing
      end
    RUBY
  end

  it 'does not register an offense when a resource calls the :nothing action' do
    expect_no_offenses(<<~RUBY)
      execute 'apache_start' do
        action :nothing
      end
    RUBY
  end
end
