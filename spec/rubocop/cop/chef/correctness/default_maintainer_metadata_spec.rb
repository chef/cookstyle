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

describe RuboCop::Cop::Chef::DefaultMetadataMaintainer, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a cookbook uses the default maintainer from the generator' do
    expect_offense(<<~RUBY)
      maintainer 'YOUR_COMPANY_NAME'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Metadata contains default maintainer information from the cookbook generator. Add actual cookbook maintainer information to the metadata.rb.
    RUBY
  end

  it 'registers an offense when a cookbook the default default maintainer_email from the generator' do
    expect_offense(<<~RUBY)
      maintainer_email 'YOUR_EMAIL'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Metadata contains default maintainer information from the cookbook generator. Add actual cookbook maintainer information to the metadata.rb.
    RUBY
  end

  it "doesn't register an offense with a unique maintainer" do
    expect_no_offenses(<<~RUBY)
      maintainer 'Tim Smith'
    RUBY
  end
end
