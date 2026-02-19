# frozen_string_literal: true
#
# Copyright:: 2024, Sous Chefs
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

describe RuboCop::Cop::Chef::Correctness::FileUtilsRMRF, :config do
  it 'registers an offense when using FileUtils.rm_rf' do
    expect_offense(<<~RUBY)
      ruby_block 'delete stuff' do
        block do
          FileUtils.rm_rf '/path/to/delete'
          ^^^^^^^^^^^^^^^ Do not use FileUtils.rm_rf. Use the file or directory resources with action :delete instead.
        end
      end
    RUBY
  end

  it 'does not register an offense when using the directory resource' do
    expect_no_offenses(<<~RUBY)
      directory '/path/to/delete' do
        action :delete
        recursive true
      end
    RUBY
  end

  it 'does not register an offense when using the file resource' do
    expect_no_offenses(<<~RUBY)
      file '/path/to/delete.txt' do
        action :delete
      end
    RUBY
  end
end
