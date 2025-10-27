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

describe RuboCop::Cop::Chef::Correctness::ServiceResource, :config do
  it 'registers an offense when starting a service in execute resource' do
    expect_offense(<<~RUBY)
      execute 'apache_start' do
        command '/etc/init.d/httpd start'
                ^^^^^^^^^^^^^^^^^^^^^^^^^ Use a service resource to start and stop services
      end
    RUBY
  end

  it 'does not register an offense when running a normal command' do
    expect_no_offenses(<<~RUBY)
      execute 'apache_start' do
        command 'echo "not starting a service"'
      end
    RUBY
  end
end
