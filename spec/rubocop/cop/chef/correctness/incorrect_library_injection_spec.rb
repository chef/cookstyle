#
# Copyright:: Copyright 2019, Chef Software Inc.
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

describe RuboCop::Cop::Chef::ChefCorrectness::IncorrectLibraryInjection do
  subject(:cop) { described_class.new }

  it 'registers an offense when calling ::Chef::Recipe.send' do
    expect_offense(<<~RUBY)
      ::Chef::Recipe.send(:include, Foo::Helpers)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Libraries should be injected into the Chef::DSL::Recipe or Chef::DSL::Resources classes and not Recipe/Resource/Provider classes directly.
    RUBY

    expect_correction("::Chef::DSL::Recipe.send(:include, Foo::Helpers)\n")
  end

  it 'registers an offense when calling ::Chef::Provider.send' do
    expect_offense(<<~RUBY)
      ::Chef::Provider.send(:include, Foo::Helpers)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Libraries should be injected into the Chef::DSL::Recipe or Chef::DSL::Resources classes and not Recipe/Resource/Provider classes directly.
    RUBY

    expect_correction("::Chef::DSL::Recipe.send(:include, Foo::Helpers)\n")
  end

  it 'registers an offense when calling ::Chef::Resource.send' do
    expect_offense(<<~RUBY)
      ::Chef::Resource.send(:include, Foo::Helpers)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Libraries should be injected into the Chef::DSL::Recipe or Chef::DSL::Resources classes and not Recipe/Resource/Provider classes directly.
    RUBY

    expect_correction("::Chef::DSL::Resources.send(:include, Foo::Helpers)\n")
  end

  it 'does not register an offense when calling ::Chef::DSL::Recipe.send' do
    expect_no_offenses(<<~RUBY)
      ::Chef::DSL::Recipe.send
    RUBY
  end

  it 'does not register an offense when calling ::Chef::DSL::Resources.send' do
    expect_no_offenses(<<~RUBY)
      ::Chef::DSL::Resources.send
    RUBY
  end
end
