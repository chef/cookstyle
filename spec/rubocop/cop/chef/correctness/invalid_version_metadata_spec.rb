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

describe RuboCop::Cop::Chef::ChefCorrectness::InvalidVersionMetadata, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a cookbook sets has an invalid version in metadata.rb' do
    expect_offense(<<~RUBY)
      version '1.2.3.4'
              ^^^^^^^^^ Cookbook metadata.rb version field should follow X.Y.Z version format.
    RUBY
  end

  it 'registers an offense when a cookbook has a rubygems prerelease style version in metadata.rb' do
    expect_offense(<<~RUBY)
      version '1.2.3-alpha'
              ^^^^^^^^^^^^^ Cookbook metadata.rb version field should follow X.Y.Z version format.
    RUBY
  end

  it "doesn't register an offense with a valid version in metadata.rb" do
    expect_no_offenses(<<~RUBY)
    version '1.2.3'
    RUBY
  end
end
