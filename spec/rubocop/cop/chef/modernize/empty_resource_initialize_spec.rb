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

describe RuboCop::Cop::Chef::Modernize::EmptyResourceInitializeMethod, :config do
  it 'registers an offense with an empty initialize method' do
    expect_offense(<<~RUBY)
      def initialize(*args)
      ^^^^^^^^^^^^^^^^^^^^^ There is no need for an empty initialize method in a resource
        super
      end
    RUBY

    expect_correction("\n")
  end

  it "doesn't alert if there's an initializer with real content" do
    expect_no_offenses(<<~RUBY)
      def initialize(*args)
        @foo = bar
        super
      end
    RUBY
  end
end
