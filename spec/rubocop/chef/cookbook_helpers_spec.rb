# frozen_string_literal: true
# rubocop:disable Lint/ParenthesesAsGroupedExpression, Lint/BooleanSymbol
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

RSpec.describe RuboCop::Chef::CookbookHelpers do
  include RuboCop::AST::Sexp
  include described_class

  let (:running_false_ast) { s(:send, nil, :running, s(:false)) }

  let (:running_true_ast) { s(:send, nil, :running, s(:true)) }

  describe '#resource_block_name_if_string' do
    describe 'when the the resource name is a string' do
      let(:resource_source) { "service 'foo' do; running true; end" }

      it 'returns the resource name string' do
        expect(resource_block_name_if_string(parse_source(resource_source).ast)).to eq 'foo'
      end
    end

    describe 'when the the resource name is a variable' do
      let(:resource_source) { 'service foo_service do; running true; end' }

      it 'returns nil' do
        expect(resource_block_name_if_string(parse_source(resource_source).ast)).to be_nil
      end
    end
  end

  describe '#match_resource_type?' do
    describe 'when the passed name matches the resource' do
      let(:resource_source) { "service 'foo' do; running true; end" }

      it 'yields a the service block ast objects' do
        expect { |b| match_resource_type?(:service, parse_source(resource_source).ast, &b) }.to yield_successive_args(s(:block, s(:send, nil, :service, s(:str, 'foo')), s(:args), s(:send, nil, :running, s(:true))))
      end
    end

    describe "when the passed name doesn't match the resource" do
      let(:resource_source) { "service 'foo' do; running true; end" }

      it 'does not yield anything' do
        expect { |b| match_resource_type?(:archive_file, parse_source(resource_source).ast, &b) }.not_to yield_control
      end
    end
  end

  describe '#match_property_in_resource?' do
    describe 'single property in a resource' do
      let(:resource_source) { "service 'single_property' do; running true; end" }

      it "yields a single 'running' property ast objects" do
        expect { |b| match_property_in_resource?(:service, 'running', parse_source(resource_source).ast, &b) }.to yield_successive_args(running_true_ast)
      end

      it "yields a single 'running' property ast objects when passed an array" do
        expect { |b| match_property_in_resource?(%i(service file), 'running', parse_source(resource_source).ast, &b) }.to yield_successive_args(running_true_ast)
      end
    end

    describe 'multiple properties in a resource' do
      let(:resource_source) { "service 'single_property' do; not_running true; running true; end" }

      it "yields a single 'running' property ast objects" do
        expect { |b| match_property_in_resource?(:service, 'running', parse_source(resource_source).ast, &b) }.to yield_successive_args(running_true_ast)
      end
    end

    describe 'matches on multiple properties in a resource as an array' do
      let(:resource_source) do
        <<~RUBY
          service 'if statement' do
            if platform?('mac_os_x')
              running true
            end
          end
        RUBY
      end

      it "yields a single 'running' property ast objects" do
        expect { |b| match_property_in_resource?(:service, %w(running verify), parse_source(resource_source).ast, &b) }.to yield_successive_args(running_true_ast)
      end
    end

    describe 'extracts a property from a resource with an if statement' do
      let(:resource_source) do
        <<~RUBY
          service 'if statement' do
            if platform?('mac_os_x')
              running true
            end
          end
        RUBY
      end

      it "yields a single 'running' property ast objects" do
        expect { |b| match_property_in_resource?(:service, 'running', parse_source(resource_source).ast, &b) }.to yield_successive_args(running_true_ast)
      end
    end

    describe 'extracts a property from a resource with a case statement' do
      let(:resource_source) do
        <<~RUBY
          service 'case statement' do
            case node['platform']
            when 'windows'
              running true
            else
              running false
            end
          end
        RUBY
      end

      it "yields both 'running' property ast objects" do
        expect { |b| match_property_in_resource?(:service, 'running', parse_source(resource_source).ast, &b) }.to yield_successive_args(running_true_ast, running_false_ast)
      end
    end

    describe 'extracts a property from a resource with nested conditionals' do
      let(:resource_source) do
        <<~RUBY
          service 'nested conditionals' do
            case node['platform']
            when 'windows'
              if node['platform_version'].to_f == '6.1'
                running true
              else
                running false
              end
            else
              running true
            end
          end
        RUBY
      end

      it "yields three 'running' property ast objects" do
        expect { |b| match_property_in_resource?(:service, 'running', parse_source(resource_source).ast, &b) }.to yield_successive_args(running_true_ast, running_false_ast, running_true_ast)
      end
    end

    describe 'extracts a property from a resource with case statement with an empty when' do
      let(:resource_source) do
        <<~RUBY
          service 'case statement with an empty when' do
            case node['platform']
            when 'windows'
              running false
            when 'mac_os_x'
              # haha there's nothing here
            end
          end
        RUBY
      end

      it "yields a single 'running' property ast objects" do
        expect { |b| match_property_in_resource?(:service, 'running', parse_source(resource_source).ast, &b) }.to yield_successive_args(running_false_ast)
      end
    end

    describe 'extracts a property from a resource with a while loop' do
      let(:resource_source) do
        <<~RUBY
          service 'while conditional' do
            while true
              running false
            end
          end
        RUBY
      end

      it "yields a single 'running' property ast objects" do
        expect { |b| match_property_in_resource?(:service, 'running', parse_source(resource_source).ast, &b) }.to yield_successive_args(running_false_ast)
      end
    end

    describe "doesn't extract methods that look like properties but aren't" do
      let(:resource_source) do
        <<~RUBY
          service 'while conditional' do
            while true
              running false
            end
          end
        RUBY
      end

      it "yields a single 'running' property ast objects" do
        expect { |b| match_property_in_resource?(:service, 'running', parse_source(resource_source).ast, &b) }.to yield_successive_args(running_false_ast)
      end
    end

    describe "doesn't extract methods from blocks that don't look like resources" do
      let(:resource_source) do
        <<~RUBY
          method_with_a_block_and_no_string_arg do |desired|
            running false
          end
        RUBY
      end

      it 'does not yield anything' do
        expect { |b| match_property_in_resource?(:service, 'running', parse_source(resource_source).ast, &b) }.not_to yield_control
      end
    end
  end
end
