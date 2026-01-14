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

describe RuboCop::Cop::Chef::Modernize::NodeRolesInclude, :config do
  it "registers an offense when using node['roles'].include? with a string" do
    expect_offense(<<~RUBY)
      node['roles'].include?('foo')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `node.role?('foo')` to check if a node includes a role instead of `node['roles'].include?('foo')`.
    RUBY

    expect_correction(<<~RUBY)
      node.role?('foo')
    RUBY
  end

  it "registers an offense when using node['roles'].include? with a non-string values" do
    expect_offense(<<~RUBY)
      node['roles'].include?(foo+bar)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `node.role?('foo')` to check if a node includes a role instead of `node['roles'].include?('foo')`.
    RUBY

    expect_correction(<<~RUBY)
      node.role?(foo+bar)
    RUBY
  end
end
