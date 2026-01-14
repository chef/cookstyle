# frozen_string_literal: true
#
# Copyright:: Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Ruby::UnlessDefinedRequire, :config do
  subject(:cop) { described_class.new(config) }

  context 'with a require known to the cop' do
    it 'registers an offense without an if defined? check' do
      expect_offense(<<~RUBY)
        require 'digest/md5'
        ^^^^^^^^^^^^^^^^^^^^ Workaround rubygems slow requires by only running require if the class isn't already defined
      RUBY

      expect_correction("require 'digest/md5' unless defined?(Digest::MD5)\n")
    end

    it "doesn't register an offense when using if defined?" do
      expect_no_offenses("require 'digest/md5' unless defined?(Digest::MD5)")
    end

    it "doesn't register an offense when using another conditional" do
      expect_no_offenses("require 'digest/md5' if something?")
    end
  end

  context 'with a require unknown to the cop' do
    it "doesn't register an offense with an if defined? check" do
      expect_no_offenses("require 'foo/bar' unless defined?(Foo::Bar)")
    end

    it "doesn't register an offense without an if defined? check" do
      expect_no_offenses("require 'foo/bar'")
    end
  end
end
