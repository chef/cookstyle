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

describe RuboCop::Cop::Chef::IncludingOhaiDefaultRecipe, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when including the "ohai" recipe' do
    expect_offense(<<~RUBY)
      include_recipe 'ohai'
      ^^^^^^^^^^^^^^^^^^^^^ Use the ohai_plugin resource to ship custom Ohai plugins instead of using the ohai::default recipe. If you're not shipping custom Ohai plugins, then you can remove this recipe entirely
    RUBY
  end

  it 'registers an offense when including the "ohai::default" recipe' do
    expect_offense(<<~RUBY)
      include_recipe 'ohai::default'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the ohai_plugin resource to ship custom Ohai plugins instead of using the ohai::default recipe. If you're not shipping custom Ohai plugins, then you can remove this recipe entirely
    RUBY
  end

  it "doesn't register an offense when including any other recipe" do
    expect_no_offenses(<<~RUBY)
      include_recipe 'foo'
    RUBY
  end
end
