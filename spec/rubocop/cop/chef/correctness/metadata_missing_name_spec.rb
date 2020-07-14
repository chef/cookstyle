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

describe RuboCop::Cop::Chef::ChefCorrectness::MetadataMissingName, :config do
  subject(:cop) { described_class.new(config) }

  # prior to Rubocop 0.87 the autocorrect was not with expect_offense
  # in Rubocop 0.87 the autocorrect method is being executed and this attempts to write data
  before(:each) do
    allow(IO).to receive(:read).with('/foo/bar/metadata.rb').and_return("supports 'ubuntu'")
    allow(IO).to receive(:write).with('/foo/bar/metadata.rb', "name 'bar'\nsupports 'ubuntu'")
  end

  it 'registers an offense when the name method is missing' do
    expect_offense(<<~RUBY, '/foo/bar/metadata.rb')
    source_url 'http://github.com/something/something'
    ^ metadata.rb needs to include the name method or it will fail on Chef Infra Client 12 and later.
    depends 'foo'
    RUBY
  end

  it "doesn't register an offense when the name property is present" do
    expect_no_offenses(<<~RUBY)
      name 'foo'
    RUBY
  end
end
