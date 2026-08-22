# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

# this is shamelessly copied from the rubocop rspec for this class
# since we're just monkeypatching it and we want to ensure our monkeypatch
# continues to function when we upgrade the engine
require 'spec_helper'

RSpec.describe RuboCop::CommentConfig do
  subject(:comment_config) { described_class.new(parse_source(source)) }

  describe '#cop_enabled_at_line?' do
    let(:source) do
      <<~RUBY
        node.normal[:foo] # rubocop: disable Chef/Correctness/Bar
        node.normal[:foo] # cookstyle: disable Chef/Correctness/Foo
      RUBY
    end

    def disabled_lines_of_cop(cop)
      (1..source.size).each_with_object([]) do |line_number, disabled_lines|
        enabled = comment_config.cop_enabled_at_line?(cop, line_number)
        disabled_lines << line_number unless enabled
      end
    end

    it 'supports disabling cops with the rubocop: disable comment' do
      expect(disabled_lines_of_cop('Chef/Correctness/Bar')).to eq([1])
    end

    it 'supports disabling cops with the cookstyle: disable comment' do
      expect(disabled_lines_of_cop('Chef/Correctness/Foo')).to eq([2])
    end
  end

  describe '#cop_enabled_at_line? with only cookstyle directives (no rubocop string)' do
    let(:source) do
      <<~RUBY
        node.normal[:foo] # cookstyle:disable Chef/Correctness/Foo
        node.normal[:bar]
      RUBY
    end

    def disabled_lines_of_cop(cop)
      (1..source.size).each_with_object([]) do |line_number, disabled_lines|
        enabled = comment_config.cop_enabled_at_line?(cop, line_number)
        disabled_lines << line_number unless enabled
      end
    end

    it 'supports disabling cops when only cookstyle directives are present' do
      expect(disabled_lines_of_cop('Chef/Correctness/Foo')).to eq([1])
    end

    it 'does not disable cops on lines without a directive' do
      expect(comment_config.cop_enabled_at_line?('Chef/Correctness/Foo', 2)).to be true
    end
  end

  # RuboCop grows new directive modes over time (`push`/`pop` in 1.86, `disable-next`
  # and `todo-next` in 1.90). The `cookstyle:` alias is built from RuboCop's own mode
  # list rather than a copy of it, so every mode has to work under both spellings.
  describe 'directive modes' do
    def disabled_lines(source, cop)
      config = described_class.new(parse_source(source))
      (1..source.lines.size).reject { |line| config.cop_enabled_at_line?(cop, line) }
    end

    %w(rubocop cookstyle).each do |keyword|
      context "with the #{keyword}: spelling" do
        it 'supports disable/enable' do
          source = <<~RUBY
            # #{keyword}:disable Chef/Correctness/Foo
            node.normal[:foo]
            # #{keyword}:enable Chef/Correctness/Foo
            node.normal[:bar]
          RUBY
          expect(disabled_lines(source, 'Chef/Correctness/Foo')).to eq([1, 2, 3])
        end

        it 'supports todo' do
          source = <<~RUBY
            node.normal[:foo] # #{keyword}:todo Chef/Correctness/Foo
            node.normal[:bar]
          RUBY
          expect(disabled_lines(source, 'Chef/Correctness/Foo')).to eq([1])
        end

        it 'supports disable-next' do
          source = <<~RUBY
            # #{keyword}:disable-next Chef/Correctness/Foo
            node.normal[:foo]
            node.normal[:bar]
          RUBY
          expect(disabled_lines(source, 'Chef/Correctness/Foo')).to eq([2])
        end

        it 'supports todo-next' do
          source = <<~RUBY
            # #{keyword}:todo-next Chef/Correctness/Foo
            node.normal[:foo]
            node.normal[:bar]
          RUBY
          expect(disabled_lines(source, 'Chef/Correctness/Foo')).to eq([2])
        end

        # Unlike `enable`, a `pop` reopens the cop on its own line, so line 3 is
        # enabled again. That asymmetry is RuboCop's, and both spellings share it.
        it 'supports push/pop' do
          source = <<~RUBY
            # #{keyword}:push -Chef/Correctness/Foo
            node.normal[:foo]
            # #{keyword}:pop
            node.normal[:bar]
          RUBY
          expect(disabled_lines(source, 'Chef/Correctness/Foo')).to eq([1, 2])
        end
      end
    end
  end
end
