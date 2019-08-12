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

describe RuboCop::Cop::Chef::InvalidLicenseString, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a cookbook sets its license to a non-standard form of the the Apache 2.0 license' do
    expect_violation(<<-RUBY)
      license 'Apache 2.0'
              ^^^^^^^^^^^^ Cookbook metadata.rb does not use a SPDX compliant license string or \"all rights reserved\". See https://spdx.org/licenses/ for a complete list of license identifiers.
    RUBY
  end

  it 'registers an offense when a cookbook sets its license to bogus junk' do
    expect_violation(<<-RUBY)
      license 'I am not a license'
              ^^^^^^^^^^^^^^^^^^^^ Cookbook metadata.rb does not use a SPDX compliant license string or \"all rights reserved\". See https://spdx.org/licenses/ for a complete list of license identifiers.
    RUBY
  end

  it "doesn't register an offense with a valid SPDX compliant license string" do
    expect_no_violations(<<-RUBY)
      license 'Apache-2.0'
    RUBY
  end
end
