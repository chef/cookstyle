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

describe RuboCop::Cop::Chef::Deprecations::ResourceOverridesProvidesMethod, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a resource overrides provides? w/o using provides' do
    expect_offense(<<~RUBY)
      def provides?
      ^^^^^^^^^^^^^ Don't override the provides? method in a resource provider. Use provides :SOME_PROVIDER_NAME instead. This will cause failures in Chef Infra Client 13 and later.
        true
      end
    RUBY
  end

  it "doesn't register an offense when overriding provides? and using provides" do
    expect_no_offenses(<<~RUBY)
      provides :my_cool_provider

      def provides?
       true
      end
    RUBY
  end

  it "doesn't register an offense with any old method" do
    expect_no_offenses(<<~RUBY)
      def foo
       true
      end
    RUBY
  end
end
