# frozen_string_literal: true
#
# Copyright:: Chef Software, Inc.
# Author:: Tim Smith (<tsmith@chef.io>)
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

describe RuboCop::Cop::Chef::Ruby::RequireNetHttps, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when requiring net/https' do
    expect_offense(<<~RUBY)
      require 'net/https'
      ^^^^^^^^^^^^^^^^^^^ net/https is deprecated and just includes net/http and openssl. We should include those directly instead.
    RUBY

    expect_correction(<<~RUBY)
      require "net/http"
      require "openssl"
    RUBY
  end

  it "doesn't register an offense when requiring net/http" do
    expect_no_offenses("require 'net/http'")
  end
end
