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

describe RuboCop::Cop::Chef::Deprecations::LocaleDeprecatedLcAllProperty, :config do
  it 'registers an offense when a the locale resource includes the lc_all property' do
    expect_offense(<<~RUBY)
      locale 'set locale' do
        lang 'en_gb.utf-8'
        lc_all 'en_gb.utf-8'
        ^^^^^^^^^^^^^^^^^^^^ The local resource's lc_all property has been deprecated and will be removed in Chef Infra Client 17
      end
    RUBY
  end

  it "doesn't register an offense when when locale sets lang property" do
    expect_no_offenses(<<~RUBY)
      locale 'set locale' do
        lang 'en_gb.utf-8'
      end
    RUBY
  end
end
