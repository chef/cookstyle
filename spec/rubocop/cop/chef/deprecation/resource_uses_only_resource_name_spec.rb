# frozen_string_literal: true
#
# Copyright:: Copyright (c) Chef Software Inc.
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

describe RuboCop::Cop::Chef::Deprecations::ResourceUsesOnlyResourceName, :config do
  before do
    skip 'Test not currently supported on Windows!' if RuboCop::Platform.windows?
  end

  let(:non_match_json) do
    <<~DATA
      {
      	"name": "default",
      	"description": "Installs some stuff",
      	"maintainer": "Bob Boberson",
      	"maintainer_email": "bob@example.com",
      	"license": "Apache-2.0",
      	"platforms": {},
      	"dependencies": {},
      	"recommendations": {},
      	"suggestions": {},
      	"conflicting": {},
      	"providing": {},
      	"replacing": {},
      	"attributes": {},
      	"groupings": {},
      	"recipes": {},
      	"version": "1.0.0"
      }
    DATA
  end

  let(:match_json) do
    non_match_json.gsub('default', 'my_cookbook')
  end

  it 'registers an offense when a resource has resource_name and does not use provides' do
    expect_offense(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook_foo
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Starting with Chef Infra Client 16, using `resource_name` without also using `provides` will result in resource failures. Make sure to use both `resource_name` and `provides` to change the name of the resource. You can also omit `resource_name` entirely if the value set matches the name Chef Infra Client automatically assigns based on COOKBOOKNAME_FILENAME.
    RUBY
  end

  it 'autocorrect deletes the resource_name if it the default name based on metadata.json data' do
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:read).and_call_original
    allow(File).to receive(:exist?).with('/my_dev_dir/cookbooks/my_cookbook/metadata.rb').and_return(false)
    allow(File).to receive(:exist?).with('/my_dev_dir/cookbooks/my_cookbook/metadata.json').and_return(true)
    allow(File).to receive(:read).with('/my_dev_dir/cookbooks/my_cookbook/metadata.json').and_return(match_json)
    corrected = autocorrect_source(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook_foo
    RUBY

    expect(corrected).to eq("\n")
  end

  it 'adds provides in addition to resource_name if it is not the default name based on metadata.json data' do
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:read).and_call_original
    allow(File).to receive(:exist?).with('/my_dev_dir/cookbooks/my_cookbook/metadata.rb').and_return(false)
    allow(File).to receive(:exist?).with('/my_dev_dir/cookbooks/my_cookbook/metadata.json').and_return(true)
    allow(File).to receive(:read).with('/my_dev_dir/cookbooks/my_cookbook/metadata.json').and_return(non_match_json)
    corrected = autocorrect_source(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook_foo
    RUBY

    expect(corrected).to eq("resource_name :my_cookbook_foo\nprovides :my_cookbook_foo\n")
  end

  it 'is not an offense if the resource_name if it the default name based on metadata.json data, but the provides line contains a platform constraint' do
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:read).and_call_original
    allow(File).to receive(:exist?).with('/my_dev_dir/cookbooks/my_cookbook/metadata.rb').and_return(false)
    allow(File).to receive(:exist?).with('/my_dev_dir/cookbooks/my_cookbook/metadata.json').and_return(true)
    allow(File).to receive(:read).with('/my_dev_dir/cookbooks/my_cookbook/metadata.json').and_return(match_json)
    expect_no_offenses(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook_foo
      provides :my_cookbook_foo, platform: "windows"
    RUBY
  end

  it "doesn't register an offense when a resource has resource_name and provides" do
    expect_no_offenses(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook_foo
      provides :my_cookbook_foo
    RUBY
  end

  it "doesn't register an offense when a resource has resource_name and provides (and the cookbook name doesn't match)" do
    expect_no_offenses(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook_bar
      provides :my_cookbook_bar
    RUBY
  end

  it "corrects a cookbook that has a non-matching resource_name (when the cookbook name doesn't match)" do
    corrected = autocorrect_source(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook_bar
    RUBY

    expect(corrected).to eq("resource_name :my_cookbook_bar\nprovides :my_cookbook_bar\n")
  end

  it 'corrects a cookbook that has a non-matching resource_name and provides' do
    corrected = autocorrect_source(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook_bar
      provides :my_cookbook
    RUBY

    expect(corrected).to eq("resource_name :my_cookbook_bar\nprovides :my_cookbook_bar\nprovides :my_cookbook\n")
  end

  it 'corrects a cookbook that has a non-matching resource_name and provides (flip the script)' do
    corrected = autocorrect_source(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook
      provides :my_cookbook_bar
    RUBY

    expect(corrected).to eq("resource_name :my_cookbook\nprovides :my_cookbook\nprovides :my_cookbook_bar\n")
  end

  it 'does not correct a cookbook that has an out of order set of provides' do
    expect_no_offenses(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook
      provides :my_cookbook_bar
      provides :my_cookbook
    RUBY
  end

  it 'does not correct a cookbook that has an out of order set of provides (flipped around)' do
    expect_no_offenses(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook_bar
      provides :my_cookbook
      provides :my_cookbook_bar
    RUBY
  end

  it 'does not correct a cookbook that matches, but also has a platform constraint' do
    expect_no_offenses(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook
      provides :my_cookbook, platform: "windows"
    RUBY
  end

  it 'does not correct a cookbook that matches, but also has a platform constraint, following some other provides' do
    expect_no_offenses(<<~RUBY, '/my_dev_dir/cookbooks/my_cookbook/resources/foo.rb')
      resource_name :my_cookbook
      provides :my_cookbook_bar
      provides :my_cookbook, platform: "windows"
    RUBY
  end
end
