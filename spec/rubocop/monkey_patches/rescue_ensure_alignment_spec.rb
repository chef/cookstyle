# frozen_string_literal: true
#
# Copyright:: Copyright 2020, Chef Software Inc.
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

# this tests the monkey patch we do in lib/rubocop/monkey_patches/rescue_ensure_alignment.rb

require 'spec_helper'

describe RuboCop::Cop::Layout::RescueEnsureAlignment, :config do
  subject(:cop) { described_class.new(config) }

  it 'is not monkeypatching a version of RuboCop with the fix' do
    expect(Cookstyle::RUBOCOP_VERSION).to eq('0.91.0')
  end
end
