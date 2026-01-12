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

describe RuboCop::Cop::Chef::Deprecations::LibrarianChefSpec, :config do
  it 'registers an offense when a cookbook requires chefspec/librarian' do
    expect_offense(<<~RUBY)
      require 'chefspec/librarian'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The Librarian-Chef depsolving project is no longer maintained and ChefSpec should not use Librarian-Chef for cookbook depsolving. Consider using Policyfiles instead.
      name 'foo'
    RUBY
  end
end
