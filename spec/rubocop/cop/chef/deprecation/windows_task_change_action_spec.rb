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

describe RuboCop::Cop::Chef::ChefDeprecations::WindowsTaskChangeAction, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when windows_task uses the :change action' do
    expect_offense(<<~RUBY)
      windows_task 'chef ad-join leave start time' do
        task_name 'chef ad-join leave'
        start_day '06/09/2016'
        start_time '01:00'
        action :change
               ^^^^^^^ The :change action in the windows_task resource was removed when windows_task was added to Chef Infra Client 13+. The default action of :create should can now be used to create an update tasks.
      end
    RUBY

    expect_correction(<<~RUBY)
      windows_task 'chef ad-join leave start time' do
        task_name 'chef ad-join leave'
        start_day '06/09/2016'
        start_time '01:00'
        action :create
      end
    RUBY
  end

  it 'registers an offense when windows_task uses the :change action along with another action' do
    expect_offense(<<~RUBY)
      windows_task 'chef ad-join leave start time' do
        task_name 'chef ad-join leave'
        start_day '06/09/2016'
        start_time '01:00'
        action [:change, :create]
                ^^^^^^^ The :change action in the windows_task resource was removed when windows_task was added to Chef Infra Client 13+. The default action of :create should can now be used to create an update tasks.
      end
    RUBY

    expect_correction(<<~RUBY)
      windows_task 'chef ad-join leave start time' do
        task_name 'chef ad-join leave'
        start_day '06/09/2016'
        start_time '01:00'
        action :create
      end
    RUBY
  end

  it "doesn't register an offense when windows_task uses the :create action" do
    expect_no_offenses(<<~RUBY)
      windows_task 'chef ad-join leave start time' do
        task_name 'chef ad-join leave'
        start_day '06/09/2016'
        start_time '01:00'
        action :create
      end
    RUBY
  end

  it "doesn't register an offense when windows_task uses a variable or method for the action" do
    expect_no_offenses(<<~RUBY)
      windows_task 'chef ad-join leave start time' do
        task_name 'chef ad-join leave'
        start_day '06/09/2016'
        start_time '01:00'
        action foo
      end
    RUBY
  end
end
