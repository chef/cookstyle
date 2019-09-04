#
# Copyright:: Copyright 2019, Chef Software Inc.
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

RSpec.describe RuboCop::Chef::CookbookHelpers do
  include RuboCop::AST::Sexp

  subject(:match_property) { described_class.new(match_property_in_resource?(source)) }

  subject(:arg_string) { described_class.new(method_arg_ast_to_string(source)) }

  describe 'extracts a property from a resource with a single property' do
    # service 'single_property' do
    #   running true
    # end
  end

  describe 'extracts a property from a resource with a multiple properties' do
    # service 'multiple properties' do
    #   running true
    #   not_running true
    # end
  end

  describe 'extracts a property from a resource with an if statement' do
    # service 'if statement' do
    #   if platform?('mac_os_x')
    #     running true
    #   end
    # end
  end

  describe 'extracts a property from a resource with a case statement' do
    # service 'case statement' do
    #   case node['platform']
    #   when 'windows'
    #     running true
    #   else
    #     running true
    #   end
    # end
  end

  describe 'extracts a property from a resource with nested conditionals' do
    # service 'nested conditionals' do
    #   case node['platform']
    #   when 'windows'
    #     if node['platform_version'].to_f == '6.1'
    #       running true
    #     else
    #       running false
    #     end
    #   else
    #     running true
    #   end
    # end
  end

  describe 'extracts a property from a resource with case statement with an empty when' do
    # service 'case statement with an empty when' do
    #   case node['platform']
    #   when 'windows'
    #     running false
    #   when 'mac_os_x'
    #     # haha there's nothing here
    #   end
    # end
  end

  describe 'extracts a property from a resource with a while loop' do
    # service 'while conditional' do
    #   while true
    #     running false
    #   end
    # end
  end

  describe "doesn't extract methods that look like properties but aren't" do
    # service 'while conditional' do
    #   while true
    #     running false
    #   end
    # end
  end

  describe "doesn't extract methods from blocks that don't look like resources" do
    # method_with_a_block_and_no_string_arg do |desired|
    #   running false
    # end
  end
end
