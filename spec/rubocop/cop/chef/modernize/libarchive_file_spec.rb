# frozen_string_literal: true
#
# Copyright:: 2019-2020, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Modernize::LibarchiveFileResource, :config do
  it 'registers an offense when using the libarchive_file resource' do
    expect_offense(<<~RUBY)
      libarchive_file 'Precompiled.zip' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of the libarchive file resource from the libarchive cookbook
        path "foo/bar.zip"
        extract_to "/foo/bar"
      end
    RUBY

    expect_correction(<<~RUBY)
      archive_file 'Precompiled.zip' do
        path "foo/bar.zip"
        extract_to "/foo/bar"
      end
    RUBY
  end

  it 'registers an offense when notifying a libarchive_file resource' do
    expect_offense(<<~RUBY)
      remote_file archive_path do
        action :create_if_missing
        notifies :extract, 'libarchive_file[extract_yajsw]', :immediately
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of the libarchive file resource from the libarchive cookbook
      end
    RUBY

    expect_correction(<<~RUBY)
      remote_file archive_path do
        action :create_if_missing
        notifies :extract, 'archive_file[extract_yajsw]', :immediately
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
        libarchive_file 'Precompiled.zip' do
          path "foo/bar.zip"
          extract_to "/foo/bar"
        end
      RUBY
    end
  end
end
