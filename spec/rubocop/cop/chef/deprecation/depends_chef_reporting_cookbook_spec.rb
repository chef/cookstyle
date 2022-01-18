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

describe RuboCop::Cop::Chef::Deprecations::DependsOnChefReportingCookbook, :config do
  it 'registers an offense when a cookbook depends on "chef-reporting"' do
    expect_offense(<<~RUBY)
      depends 'chef-reporting'
      ^^^^^^^^^^^^^^^^^^^^^^^^ Don't depend on the chef-reporting cookbook made obsolete by Chef Infra Client 11.6. This cookbook installs a gem that is not compatible with newer Chef Infra Client releases.
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when depending on any old cookbook" do
    expect_no_offenses(<<~RUBY)
      depends 'foo'
    RUBY
  end
end
