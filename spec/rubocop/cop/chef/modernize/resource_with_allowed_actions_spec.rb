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

describe RuboCop::Cop::Chef::ChefModernize::CustomResourceWithAllowedActions, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense with a resource that uses allowed_actions method' do
    expect_offense(<<~RUBY)
      property :something, String

      allowed_actions [:create, :remove]
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Resources no longer need to define the allowed actions using the allowed_actions / actions helper methods or within an initialize method.
    RUBY

    expect_correction(<<~RUBY)
      property :something, String
    RUBY
  end

  it 'registers an offense with a resource that uses actions method' do
    expect_offense(<<~RUBY)
      property :something, String

      actions [:create, :remove]
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ Resources no longer need to define the allowed actions using the allowed_actions / actions helper methods or within an initialize method.
    RUBY

    expect_correction(<<~RUBY)
      property :something, String
    RUBY
  end

  it 'registers an offense with a resource that sets the @allowed_actions variable in an initializer' do
    expect_offense(<<~RUBY)
      def initialize(*args)
        super
        @allowed_actions = [:create, :remove]
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Resources no longer need to define the allowed actions using the allowed_actions / actions helper methods or within an initialize method.
      end
    RUBY

    expect_correction(<<~RUBY)
    def initialize(*args)
      super
    end
    RUBY
  end

  it 'registers an offense with a resource that pushes to the @allowed_actions variable in an initializer' do
    expect_offense(<<~RUBY)
      def initialize(*args)
        super
        @allowed_actions.push(:create, :remove)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Resources no longer need to define the allowed actions using the allowed_actions / actions helper methods or within an initialize method.
      end
    RUBY

    expect_correction(<<~RUBY)
    def initialize(*args)
      super
    end
    RUBY
  end

  it 'does not register an offense with a resource that does not use allowed_actions or actions methods' do
    expect_no_offenses(<<~RUBY)
      property :something, String

      action :create do
        # some action code
      end
    RUBY
  end

  it 'does not register an offense with when an initializer is empty' do
    expect_no_offenses(<<~RUBY)
      def initialize(*args)
      end
    RUBY
  end

  it 'does not register an offense with when an initializer containing other variables' do
    expect_no_offenses(<<~RUBY)
    def initialize(*args)
      super
      @action = :create
    end
    RUBY
  end
end
