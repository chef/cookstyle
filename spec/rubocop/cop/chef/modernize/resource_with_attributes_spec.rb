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

describe RuboCop::Cop::Chef::ChefModernize::CustomResourceWithAttributes, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense with a custom resource that contains attributes' do
    expect_offense(<<~RUBY)
      attribute :something, String
      ^^^^^^^^^ Custom Resources should contain properties not attributes
      action :create do
        # some action code because we're in a custom resource
      end
    RUBY

    expect_correction(<<~RUBY)
      property :something, String
      action :create do
        # some action code because we're in a custom resource
      end
    RUBY
  end

  it 'does not register an offense with a LWRP that contains attributes' do
    expect_no_offenses(<<~RUBY)
      attribute :something, String
    RUBY
  end
end
