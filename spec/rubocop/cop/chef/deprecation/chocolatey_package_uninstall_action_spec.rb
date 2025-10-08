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

describe RuboCop::Cop::Chef::Deprecations::ChocolateyPackageUninstallAction, :config do
  it 'registers an offense when chocolatey_package uses the :uninstall action' do
    expect_offense(<<~RUBY)
      chocolatey_package 'nginx' do
        action :uninstall
               ^^^^^^^^^^ Use the :remove action in the chocolatey_package resource instead of :uninstall which was removed in Chef Infra Client 14+
      end
    RUBY

    expect_correction("chocolatey_package 'nginx' do\n  action :remove\nend\n")
  end

  it "doesn't register an offense when chocolatey_package uses the :remove action" do
    expect_no_offenses(<<~RUBY)
      chocolatey_package 'nginx' do
        action :remove
      end
    RUBY
  end
end
