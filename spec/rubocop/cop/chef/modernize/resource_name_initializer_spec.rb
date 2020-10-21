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

describe RuboCop::Cop::Chef::Modernize::ResourceNameFromInitialize, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense with a HWRP specifies the resource_name in the initializer' do
    expect_offense(<<~RUBY)
      def initialize(*args)
        super
        @resource_name = :foo
        ^^^^^^^^^^^^^^^^^^^^^ The name of a resource can be set with the "resource_name" helper instead of using the initialize method.
      end
    RUBY

    expect_correction(<<~RUBY)
      resource_name :foo

      def initialize(*args)
        super
      end
    RUBY
  end

  it 'does not register an offense with an empty initialize method' do
    expect_no_offenses(<<~RUBY)
      def initialize(*args)
      end
    RUBY
  end
end
