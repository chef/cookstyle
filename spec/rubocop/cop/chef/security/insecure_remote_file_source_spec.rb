# frozen_string_literal: true
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

describe RuboCop::Cop::Chef::Security::InsecureRemoteFileSource, :config do
  it 'registers an offense when remote_file fetches over http' do
    expect_offense(<<~RUBY)
      remote_file '/tmp/foo.tar.gz' do
        source 'http://example.com/foo.tar.gz'
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Fetch remote files over HTTPS. A file downloaded over plain HTTP or FTP can be modified in transit and the resource will install whatever it receives.
      end
    RUBY
  end

  it 'registers an offense when remote_file fetches over ftp' do
    expect_offense(<<~RUBY)
      remote_file '/tmp/foo.tar.gz' do
        source 'ftp://example.com/foo.tar.gz'
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Fetch remote files over HTTPS. A file downloaded over plain HTTP or FTP can be modified in transit and the resource will install whatever it receives.
      end
    RUBY
  end

  it 'registers an offense when windows_package fetches over http' do
    expect_offense(<<~RUBY)
      windows_package 'Foo' do
        source 'http://example.com/foo.msi'
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Fetch remote files over HTTPS. A file downloaded over plain HTTP or FTP can be modified in transit and the resource will install whatever it receives.
      end
    RUBY
  end

  it 'registers an offense when the url is interpolated' do
    expect_offense(<<~'RUBY')
      remote_file '/tmp/foo.tar.gz' do
        source "http://example.com/#{node['foo']['version']}/foo.tar.gz"
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Fetch remote files over HTTPS. A file downloaded over plain HTTP or FTP can be modified in transit and the resource will install whatever it receives.
      end
    RUBY
  end

  it 'registers an offense for each insecure mirror in an array of sources' do
    expect_offense(<<~RUBY)
      remote_file '/tmp/foo.tar.gz' do
        source ['https://example.com/foo.tar.gz', 'http://mirror.example.com/foo.tar.gz']
                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Fetch remote files over HTTPS. A file downloaded over plain HTTP or FTP can be modified in transit and the resource will install whatever it receives.
      end
    RUBY
  end

  it "doesn't register an offense when the source is https" do
    expect_no_offenses(<<~RUBY)
      remote_file '/tmp/foo.tar.gz' do
        source 'https://example.com/foo.tar.gz'
      end
    RUBY
  end

  it "doesn't register an offense for a local file source" do
    expect_no_offenses(<<~RUBY)
      remote_file '/tmp/foo.tar.gz' do
        source 'file:///mnt/media/foo.tar.gz'
      end
    RUBY
  end

  it "doesn't register an offense when the source comes from a node attribute" do
    expect_no_offenses(<<~RUBY)
      remote_file '/tmp/foo.tar.gz' do
        source node['foo']['url']
      end
    RUBY
  end

  it "doesn't register an offense when the scheme itself is interpolated" do
    expect_no_offenses(<<~'RUBY')
      remote_file '/tmp/foo.tar.gz' do
        source "#{node['foo']['scheme']}://example.com/foo.tar.gz"
      end
    RUBY
  end

  it "doesn't register an offense on an unrelated resource with a source property" do
    expect_no_offenses(<<~RUBY)
      template '/etc/foo.conf' do
        source 'http://example.com/foo.erb'
      end
    RUBY
  end
end
