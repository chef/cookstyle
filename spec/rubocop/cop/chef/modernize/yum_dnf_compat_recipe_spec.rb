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

describe RuboCop::Cop::Chef::IncludingYumDNFCompatRecipe, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when including the "yum::dnf_yum_compat" recipe' do
    expect_offense(<<~RUBY)
      include_recipe 'yum::dnf_yum_compat'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not include the yum::dnf_yum_compat default recipe to install yum on dnf systems. Chef Infra Client now includes built in support for DNF packages.
    RUBY

    expect_correction("\n")
  end

  it "doesn't register an offense when including the yum::default recipe" do
    expect_no_offenses(<<~RUBY)
      include_recipe 'yum::default'
    RUBY
  end
end
