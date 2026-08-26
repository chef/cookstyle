# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# Author:: Tim Smith (<tsmith84@proton.me>)
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

describe RuboCop::Cop::Chef::Correctness::InvalidChecksum, :config do
  it 'registers an offense when remote_file is given an MD5 digest' do
    expect_offense(<<~RUBY)
      remote_file '/tmp/foo.tar.gz' do
        source 'https://example.com/foo.tar.gz'
        checksum 'd41d8cd98f00b204e9800998ecf8427e'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The checksum property takes a SHA-256 digest. An MD5 or SHA-1 digest can never match, so the run fails with a checksum mismatch. This looks like an MD5 digest.
      end
    RUBY
  end

  it 'registers an offense when remote_file is given a SHA-1 digest' do
    expect_offense(<<~RUBY)
      remote_file '/tmp/foo.tar.gz' do
        checksum 'da39a3ee5e6b4b0d3255bfef95601890afd80709'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The checksum property takes a SHA-256 digest. An MD5 or SHA-1 digest can never match, so the run fails with a checksum mismatch. This looks like a SHA-1 digest.
      end
    RUBY
  end

  it 'registers an offense when windows_package is given an MD5 digest' do
    expect_offense(<<~RUBY)
      windows_package 'Foo' do
        source 'https://example.com/foo.msi'
        checksum 'd41d8cd98f00b204e9800998ecf8427e'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The checksum property takes a SHA-256 digest. An MD5 or SHA-1 digest can never match, so the run fails with a checksum mismatch. This looks like an MD5 digest.
      end
    RUBY
  end

  it "doesn't register an offense for a SHA-256 digest" do
    expect_no_offenses(<<~RUBY)
      remote_file '/tmp/foo.tar.gz' do
        source 'https://example.com/foo.tar.gz'
        checksum 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
      end
    RUBY
  end

  it "doesn't register an offense when the checksum is not a hex string" do
    expect_no_offenses(<<~RUBY)
      remote_file '/tmp/foo.tar.gz' do
        checksum 'this-is-not-a-digest-but-is-32-ch'
      end
    RUBY
  end

  it "doesn't register an offense when the checksum comes from a node attribute" do
    expect_no_offenses(<<~RUBY)
      remote_file '/tmp/foo.tar.gz' do
        checksum node['foo']['checksum']
      end
    RUBY
  end

  it "doesn't register an offense on a resource without a checksum property" do
    expect_no_offenses(<<~RUBY)
      remote_file '/tmp/foo.tar.gz' do
        source 'https://example.com/foo.tar.gz'
      end
    RUBY
  end

  it "doesn't register an offense on an unrelated resource with a checksum property" do
    expect_no_offenses(<<~RUBY)
      my_custom_resource 'foo' do
        checksum 'd41d8cd98f00b204e9800998ecf8427e'
      end
    RUBY
  end

  it 'registers an offense when msu_package is given an MD5 digest' do
    expect_offense(<<~RUBY)
      msu_package 'Windows Update' do
        source 'https://example.com/foo.msu'
        checksum 'd41d8cd98f00b204e9800998ecf8427e'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The checksum property takes a SHA-256 digest. An MD5 or SHA-1 digest can never match, so the run fails with a checksum mismatch. This looks like an MD5 digest.
      end
    RUBY
  end

  it 'registers an offense when dmg_package is given a SHA-1 digest' do
    expect_offense(<<~RUBY)
      dmg_package 'Foo' do
        source 'https://example.com/foo.dmg'
        checksum 'da39a3ee5e6b4b0d3255bfef95601890afd80709'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The checksum property takes a SHA-256 digest. An MD5 or SHA-1 digest can never match, so the run fails with a checksum mismatch. This looks like a SHA-1 digest.
      end
    RUBY
  end
end
