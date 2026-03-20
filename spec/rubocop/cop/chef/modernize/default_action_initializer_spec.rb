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

describe RuboCop::Cop::Chef::Modernize::DefaultActionFromInitialize, :config do
  it 'registers an offense when a HWRP specifies @action in the initializer' do
    expect_offense(<<~RUBY)
      def initialize(*args)
        super
        @action = :create
        ^^^^^^^^^^^^^^^^^ The default action of a resource can be set with the "default_action" helper instead of using the initialize method.
      end
    RUBY

    expect_correction(<<~RUBY)
      default_action :create

      def initialize(*args)
        super
      end
    RUBY
  end

  it 'registers an offense when a HWRP specifies @default_action in the initializer' do
    expect_offense(<<~RUBY)
      def initialize(*args)
        super
        @default_action = :create
        ^^^^^^^^^^^^^^^^^^^^^^^^^ The default action of a resource can be set with the "default_action" helper instead of using the initialize method.
      end
    RUBY

    expect_correction(<<~RUBY)
      default_action :create

      def initialize(*args)
        super
      end
    RUBY
  end

  it 'Detects @action in the initializer regardless of the order of other variables' do
    expect_offense(<<~RUBY)
      default_action :create

      def initialize(*args)
        super
        @action = :create
        ^^^^^^^^^^^^^^^^^ The default action of a resource can be set with the "default_action" helper instead of using the initialize method.
        @foo ||= name
      end
    RUBY
  end

  it 'Deletes the initializer usage it if the DSL method already exists' do
    expect_offense(<<~RUBY)
      default_action :create

      def initialize(*args)
        super
        @action = :create
        ^^^^^^^^^^^^^^^^^ The default action of a resource can be set with the "default_action" helper instead of using the initialize method.
      end
    RUBY

    expect_correction(<<~RUBY)
      default_action :create

      def initialize(*args)
        super
      end
    RUBY
  end

  it 'does not register an offense with an empty initialize method' do
    expect_no_offenses(<<~RUBY)
      def initialize(*args)
      end
    RUBY
  end

  it 'does not register an offense when using ||= on the @action variable' do
    expect_no_offenses(<<~RUBY)
      def initialize(*args)
        @default_action ||= :create
        super
      end
    RUBY
  end
end
