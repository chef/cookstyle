# frozen_string_literal: true

#
# Copyright:: 2019, Chef Software, Inc.
# Author:: Tim Smith (<tsmith84@gmail.com>)
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

describe RuboCop::Cop::Chef::Deprecations::VerifyPropertyUsesFileExpansion, :config do
  it 'registers an offense when using the file variable in the verify property' do
    expect_offense(<<~RUBY)
      file '/etc/nginx.conf' do
        verify 'nginx -t -c %<file>s'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the 'path' variable in the verify property and not the 'file' variable which was removed in Chef Infra Client 13.
      end
    RUBY

    expect_correction(<<~RUBY)
      file '/etc/nginx.conf' do
        verify 'nginx -t -c %<path>s'
      end
    RUBY
  end

  it "doesn't register an when using path variable in the verify property" do
    expect_no_offenses(<<~RUBY)
      file '/etc/nginx.conf' do
        verify 'nginx -t -c %<path>s'
      end
    RUBY
  end
end
