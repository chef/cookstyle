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

describe RuboCop::Cop::Chef::WindowsZipfileUsage, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when including the "build-essential" recipe' do
    expect_offense(<<~RUBY)
      windows_zipfile 'Precompiled.zip' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the archive_file resource built into Chef Infra Client 15+ instead of the windows_zipfile from the Windows cookbook
        some_prop 'foo'
        another_prop 'bar'
      end
    RUBY
  end

  it "doesn't register an offense when using the build_essential resource" do
    expect_no_offenses(<<~RUBY)
      archive_file 'Precompiled.zip' do
        path '/tmp/Precompiled.zip'
        destination '/srv/files'
      end
    RUBY
  end
end
