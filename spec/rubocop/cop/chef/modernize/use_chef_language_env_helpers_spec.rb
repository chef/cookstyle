# frozen_string_literal: true

#
# Copyright:: 2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Modernize::UseChefLanguageEnvHelpers, :config do
  it "registers an offense when using ENV['CI'] in a cookbook" do
    expect_offense(<<~RUBY)
      if ENV['CI']
         ^^^^^^^^^ Chef Infra Client 15.5 and later include a helper `ci?` that should be used to see if the `CI` env var is set.
        foo
      end
    RUBY

    expect_correction(<<~RUBY)
      if ci?
        foo
      end
    RUBY
  end

  it "registers an offense when using ENV['TEST_KITCHEN'] in a cookbook" do
    expect_offense(<<~RUBY)
      if ENV['TEST_KITCHEN']
         ^^^^^^^^^^^^^^^^^^^ Chef Infra Client 15.5 and later include a helper `kitchen?` that should be used to see if the `TEST_KITCHEN` env var is set.
        foo
      end
    RUBY

    expect_correction(<<~RUBY)
      if kitchen?
        foo
      end
    RUBY
  end

  it 'does not alert when checking if the env var is nil' do
    expect_no_offenses(<<~RUBY)
      unless ENV['TEST_KITCHEN'].nil?
        foo
      end
    RUBY
  end

  it 'does not alert when checking any old env var' do
    expect_no_offenses(<<~RUBY)
      if ENV['NOT_TEST_KITCHEN']
        foo
      end
    RUBY
  end
end
