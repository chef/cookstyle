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

describe RuboCop::Cop::Chef::Deprecations::ChefRewind, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense with a non-block chef_gem chef-rewind install' do
    expect_offense(<<~RUBY)
      chef_gem 'chef-rewind'
      ^^^^^^^^^^^^^^^^^^^^^^ Use delete_resource / edit_resource introduced in Chef Infra Client 12.10 instead of functionality in the deprecated chef-rewind gem
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense with a block form chef_gem chef-rewind install' do
    expect_offense(<<~RUBY)
      chef_gem 'chef-rewind' do
      ^^^^^^^^^^^^^^^^^^^^^^ Use delete_resource / edit_resource introduced in Chef Infra Client 12.10 instead of functionality in the deprecated chef-rewind gem
        compile_time true
      end
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense with chef_gem installing chef_rewind with the package_name property' do
    expect_offense(<<~RUBY)
      chef_gem 'Install chef-rewind gem' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use delete_resource / edit_resource introduced in Chef Infra Client 12.10 instead of functionality in the deprecated chef-rewind gem
        package_name 'chef-rewind'
      end
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when requiring chef/rewind' do
    expect_offense(<<~RUBY)
      require 'chef/rewind'
      ^^^^^^^^^^^^^^^^^^^^^ Use delete_resource / edit_resource introduced in Chef Infra Client 12.10 instead of functionality in the deprecated chef-rewind gem
    RUBY

    expect_correction("\n")
  end

  it 'registers an offense when using the rewind resource' do
    expect_offense(<<~RUBY)
      rewind 'user[postgres]' do
      ^^^^^^^^^^^^^^^^^^^^^^^ Use delete_resource / edit_resource introduced in Chef Infra Client 12.10 instead of functionality in the deprecated chef-rewind gem
        home '/var/lib/pgsql/9.2'
        cookbook 'my-postgresql'
      end
    RUBY

    expect_correction(<<~RUBY)
      edit_resource 'user[postgres]' do
        home '/var/lib/pgsql/9.2'
        cookbook 'my-postgresql'
      end
    RUBY
  end

  it 'registers an offense when using the unwind resource' do
    expect_offense(<<~RUBY)
      unwind 'user[postgres]'
      ^^^^^^^^^^^^^^^^^^^^^^^ Use delete_resource / edit_resource introduced in Chef Infra Client 12.10 instead of functionality in the deprecated chef-rewind gem
    RUBY

    expect_correction(<<~RUBY)
      delete_resource 'user[postgres]'
    RUBY
  end

  it "doesn't register an offense on a non-rewind chef_gem install" do
    expect_no_offenses(<<~RUBY)
      chef_gem 'aws-sdk'
    RUBY
  end

  it "doesn't register an offense when requiring another library" do
    expect_no_offenses(<<~RUBY)
      require 'chef/resource'
    RUBY
  end

  context 'with TargetChefVersion set to 12.9' do
    let(:config) { target_chef_version(12.9) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        chef_gem 'chef-rewind'

        require 'chef/rewind'

        unwind 'user[postgres]'

        rewind 'user[postgres]' do
          home '/var/lib/pgsql/9.2'
          cookbook 'my-postgresql'
        end
      RUBY
    end
  end
end
