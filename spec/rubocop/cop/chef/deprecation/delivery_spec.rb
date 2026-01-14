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
require 'rubocop/monkey_patches/allow_invalid_ruby'

describe RuboCop::Cop::Chef::Deprecations::Delivery, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when cookbook includes .delivery/project.toml' do
    expect_offense(<<~'TOML', 'cookbook/.delivery/project.toml')
      [delivery_local]
      ^ Do not include Chef Delivery (Workflow) configuration [...]
    TOML
  end

  it 'registers an offense when .delivery/config.json is not valid Ruby' do
    allow_invalid_ruby do
      expect_offense(<<~TOML, 'cookbook/.delivery/config.json')
        This isn't parsable Ruby.
        ^ Do not include Chef Delivery (Workflow) configuration [...]
      TOML
    end
  end
end
