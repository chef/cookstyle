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

describe RuboCop::Cop::Chef::ChefStyle::SimplifyPlatformMajorVersionCheck do
  subject(:cop) { described_class.new }

  it "registers an offense when checking platform major version using node['platform_version'].split('.').first" do
    expect_offense(<<~RUBY)
      node['platform_version'].split('.').first
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['platform_version'].to_i instead of node['platform_version'].split('.').first or node['platform_version'].split('.')[0]
    RUBY

    expect_correction("node['platform_version'].to_i\n")
  end

  it "registers an offense when checking platform major version using node['platform_version'].split('.')[0]" do
    expect_offense(<<~RUBY)
      node['platform_version'].split('.')[0]
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['platform_version'].to_i instead of node['platform_version'].split('.').first or node['platform_version'].split('.')[0]
    RUBY

    expect_correction("node['platform_version'].to_i\n")
  end

  it "registers an offense when checking platform major version using node['platform_version'].split('.').first.to_i" do
    expect_offense(<<~RUBY)
      node['platform_version'].split('.').first.to_i
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['platform_version'].to_i instead of node['platform_version'].split('.').first or node['platform_version'].split('.')[0]
    RUBY

    expect_correction("node['platform_version'].to_i\n")
  end

  it "registers an offense when checking platform major version using node['platform_version'].split('.')[0].to_i" do
    expect_offense(<<~RUBY)
      node['platform_version'].split('.')[0].to_i
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use node['platform_version'].to_i instead of node['platform_version'].split('.').first or node['platform_version'].split('.')[0]
    RUBY

    expect_correction("node['platform_version'].to_i\n")
  end

  it "does not register an offense when with node['platform_version'].split('.')[1]" do
    expect_no_offenses("node['platform_version'].split('.')[1]")
  end

  it "does not register an offense when with node['platform_version'].split('.')[1].to_i" do
    expect_no_offenses("node['platform_version'].split('.')[1].to_i")
  end

  it "does not register an offense when with node['platform_version'].split('.')[0..1]" do
    expect_no_offenses("node['platform_version'].split('.')[0..1]")
  end
end
