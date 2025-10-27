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

describe RuboCop::Cop::Chef::Deprecations::UseInlineResourcesDefined, :config do
  it 'registers an offense when a resource includes use_inline_resources' do
    expect_offense(<<~RUBY)
      use_inline_resources
      ^^^^^^^^^^^^^^^^^^^^ use_inline_resources is now the default for resources in Chef Infra Client 13+ and does not need to be specified.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when a resource includes use_inline_resources if defined?(use_inline_resources)' do
    expect_offense(<<~RUBY)
      use_inline_resources if defined?(use_inline_resources)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ use_inline_resources is now the default for resources in Chef Infra Client 13+ and does not need to be specified.
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when a resource includes use_inline_resources if respond_to?(:use_inline_resources)' do
    expect_offense(<<~RUBY)
      use_inline_resources if respond_to?(:use_inline_resources)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ use_inline_resources is now the default for resources in Chef Infra Client 13+ and does not need to be specified.
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when a resource calls not_use_inline_resources" do
    expect_no_offenses(<<~RUBY)
      not_use_inline_resources
    RUBY
  end
end
