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

describe RuboCop::Cop::Chef::Correctness::OpenSSLPasswordHelpers, :config do
  it 'registers an offense when including Opscode::OpenSSL::Password' do
    expect_offense(<<~RUBY)
      ::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^ The `secure_password` helper from the openssl cookbooks `Opscode::OpenSSL::Password` class should not be used to generate passwords.
    RUBY
  end

  it 'registers an offense when using ::Opscode::OpenSSL::Password' do
    expect_offense(<<~RUBY)
      ::Opscode::OpenSSL::Password.random_password
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The `secure_password` helper from the openssl cookbooks `Opscode::OpenSSL::Password` class should not be used to generate passwords.
    RUBY
  end

  it "doesn't register an offense when using OpenSSL::Password without the Opscode namespace" do
    expect_no_offenses(<<~RUBY)
      ::Chef::Recipe.send(:include, OpenSSL::Password)
    RUBY
  end

  it "doesn't register an offense when using another class in the Opscode::OpenSSL namespace" do
    expect_no_offenses(<<~RUBY)
      Opscode::OpenSSL::Certificate.new
    RUBY
  end
end
