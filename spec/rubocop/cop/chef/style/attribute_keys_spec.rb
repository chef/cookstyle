# frozen_string_literal: true
#
# Copyright:: 2016, Noah Kantrowitz
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

describe RuboCop::Cop::Chef::Style::AttributeKeys, :config do
  context 'when EnforcedStyle is `symbols`' do
    let(:cop_config) { { 'EnforcedStyle' => 'symbols' } }

    it 'does not register an offense when accessing a single node attribute with a symbol' do
      expect_no_offenses(<<~RUBY)
        node[:foo]
      RUBY
    end

    it 'registers an offense when accessing a single node attribute with a single quoted string' do
      expect_offense(<<~RUBY)
        node['foo']
             ^^^^^ Use symbols to access node attributes
      RUBY
    end

    it 'registers an offense when accessing a single node attribute with a double quoted string' do
      expect_offense(<<~RUBY)
        node["foo"]
             ^^^^^ Use symbols to access node attributes
      RUBY
    end

    it 'registers an offense when accessing a nested node attributes with strings' do
      expect_offense(<<~RUBY)
        node['foo']["bar"][%q{baz}]
             ^^^^^ Use symbols to access node attributes
                    ^^^^^ Use symbols to access node attributes
                           ^^^^^^^ Use symbols to access node attributes
      RUBY
    end

    it 'registers an offense when accessing a nested node attributes with mixed values' do
      expect_offense(<<~RUBY)
        node["foo"][:bar][0]['other']
             ^^^^^ Use symbols to access node attributes
                             ^^^^^^^ Use symbols to access node attributes
      RUBY
    end

    include_examples 'autocorrect',
                     'node[:foo]["bar"]',
                     'node[:foo][:bar]'

    include_examples 'autocorrect',
                     'node[:foo][\'bar\']',
                     'node[:foo][:bar]'
  end # /context when EnforcedStyle is `symbols`

  context 'when EnforcedStyle is `strings`' do
    let(:cop_config) { { 'EnforcedStyle' => 'strings' } }

    it 'registers an offense when accessing a single node attribute with a symbol' do
      expect_offense(<<~RUBY)
        node[:foo]
             ^^^^ Use strings to access node attributes
      RUBY

      expect_correction(<<~RUBY)
        node["foo"]
      RUBY
    end

    it 'does not register an offense when accessing a single node attribute with a single quoted string' do
      expect_no_offenses(<<~RUBY)
        node['foo']
      RUBY
    end

    it 'does not register an offense when accessing a single node attribute with a double quoted string' do
      expect_no_offenses(<<~RUBY)
        node["foo"]
      RUBY
    end

    it 'registers an offense when accessing a nested node attributes with symbols' do
      expect_offense(<<~RUBY)
        node[:foo][:bar][:baz]
             ^^^^ Use strings to access node attributes
                   ^^^^ Use strings to access node attributes
                         ^^^^ Use strings to access node attributes
      RUBY

      expect_correction(<<~RUBY)
        node["foo"]["bar"]["baz"]
      RUBY
    end

    it 'registers an offense when accessing a nested node attributes with mixed values' do
      expect_offense(<<~RUBY)
        node["foo"][:bar][0]['other']
                    ^^^^ Use strings to access node attributes
      RUBY

      expect_correction(<<~RUBY)
        node["foo"]["bar"][0]['other']
      RUBY
    end

    include_examples 'autocorrect',
                     'node[:foo]["bar"]',
                     'node["foo"]["bar"]'

    include_examples 'autocorrect',
                     'node[:foo][\'bar\']',
                     'node["foo"][\'bar\']'
  end # /context when EnforcedStyle is `strings`
end
