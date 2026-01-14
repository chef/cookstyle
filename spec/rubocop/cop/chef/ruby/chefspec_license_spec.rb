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

describe RuboCop::Cop::Chef::Ruby::GemspecLicense, :config do
  subject(:cop) { described_class.new(config) }

  before do
    allow(IO).to receive(:read).and_call_original
    allow(IO).to receive(:read).with('/foo/bar/chef.gemspec').and_return("Gem::Specification.new do |spec|\n  spec.name          = 'chef'\nend")
  end

  it 'registers an offense when the license method is missing' do
    expect_offense(<<~RUBY, '/foo/bar/chef.gemspec')
      Gem::Specification.new do |spec|
      ^ All gemspec files should define their license.
        spec.name          = "chef"
      end
    RUBY
  end

  it "doesn't register an offense when the name property is present" do
    expect_no_offenses(<<~RUBY)
      Gem::Specification.new do |spec|
        spec.name          = "chef"
        spec.license       = "Apache-2.0"
      end
    RUBY
  end
end
