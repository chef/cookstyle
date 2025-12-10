# frozen_string_literal: true

#
# Copyright:: 2021, Chef Software, Inc.
# Author:: Tim Smith (<tsmith84@gmail.com>)
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

describe RuboCop::Cop::Chef::Modernize::UseChefLanguageSystemdHelper, :config do
  it "registers an offense when using node['init_package'] == 'systemd' in a cookbook" do
    expect_offense(<<~RUBY)
      if node['init_package'] == 'systemd'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include a `systemd?` helper for checking if a Linux system uses systemd.
        foo
      end
    RUBY

    expect_correction(<<~RUBY)
      if systemd?
        foo
      end
    RUBY
  end

  it "does not alert when checking for other node['init_package'] values" do
    expect_no_offenses(<<~RUBY)
      if node['init_package'] == 'upstart'
        foo
      end
    RUBY
  end
end
