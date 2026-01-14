# frozen_string_literal: true
#
# Copyright:: 2021, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Deprecations::DependsOnOmnibusUpdaterCookbook, :config do
  it 'registers an offense when a cookbook depends on "omnibus_updater"' do
    expect_offense(<<~RUBY)
      depends 'omnibus_updater'
      ^^^^^^^^^^^^^^^^^^^^^^^^^ Don't depend on the EOL `omnibus_updater` cookbook. This cookbook no longer works with newer Chef Infra Client releases and has been replaced with the more reliable `chef_client_updater` cookbook.
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when depending on any chef_client_updater cookbook" do
    expect_no_offenses(<<~RUBY)
      depends 'chef_client_updater'
    RUBY
  end
end
