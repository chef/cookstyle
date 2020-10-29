# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Modernize::ZipfileResource, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when depending on the zipfile cookbook' do
    expect_offense(<<~RUBY)
      depends 'zipfile'
      ^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of the zipfile resource from the zipfile cookbook.
    RUBY
  end

  it 'registers an offense when using the zipfile resource' do
    expect_offense(<<~RUBY)
      zipfile 'extract files' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of the zipfile resource from the zipfile cookbook.
        path 'C:\path'
        source 'C:\file.zip'
      end
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

  context 'with TargetChefVersion set to 14' do
    let(:config) { target_chef_version(14) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        depends 'zipfile'
      RUBY
    end
  end
end
