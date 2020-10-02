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

describe RuboCop::Cop::Chef::ChefDeprecations::PoiseArchiveUsage, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using the poise_archive resource' do
    expect_offense(<<~RUBY)
      poise_archive 'Precompiled.zip' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The poise_archive resource in the deprecated poise-archive should be replaced with the archive_file resource found in Chef Infra Client 15+
        path "foo/bar.zip"
        extract_to "/foo/bar"
        end
    RUBY
  end

  it 'registers an offense when depending on poise-archive cookbook' do
    expect_offense(<<~RUBY)
      depends 'poise-archive'
      ^^^^^^^^^^^^^^^^^^^^^^^ The poise_archive resource in the deprecated poise-archive should be replaced with the archive_file resource found in Chef Infra Client 15+
    RUBY
  end

  it "doesn't register an offense when using the archive_file resource" do
    expect_no_offenses(<<~RUBY)
      archive_file 'Precompiled.zip' do
        path '/tmp/Precompiled.zip'
        destination '/srv/files'
      end
    RUBY
  end
end
