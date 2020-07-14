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

describe RuboCop::Cop::Chef::ChefStyle::ImmediateNotificationTiming do
  subject(:cop) { described_class.new }

  it 'registers an offense when notification uses the :immediate timing' do
    expect_offense(<<~RUBY)
      template '/etc/www/configures-apache.conf' do
        notifies :restart, 'service[apache]', :immediate
                                              ^^^^^^^^^^ Use :immediately instead of :immediate for resource notification timing
      end
    RUBY

    expect_correction(<<~RUBY)
    template '/etc/www/configures-apache.conf' do
      notifies :restart, 'service[apache]', :immediately
    end
  RUBY
  end

  it 'does not register an offense when notification uses the :immediately timing' do
    expect_no_offenses(<<~RUBY)
    template '/etc/www/configures-apache.conf' do
      notifies :restart, 'service[apache]', :immediately
    end
    RUBY
  end
end
