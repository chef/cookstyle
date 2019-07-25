#
# Copyright:: 2016, Chris Henry
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

describe RuboCop::Cop::Chef::TmpPath, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when hardcoding a path in /tmp' do
    expect_violation(<<-RUBY)
      remote_file '/tmp/large-file.tar.gz' do
                  ^^^^^^^^^^^^^^^^^^^^^^^^ Use file_cache_path rather than hard-coding tmp paths
        source 'http://www.example.org/large-file.tar.gz'
      end
    RUBY
  end

  it "doesn't register an offense when using file_cache_path" do
    expect_no_violations(<<-RUBY)
      remote_file "\#\{Chef::Config[:file_cache_path]\}/large-file.tar.gz" do
        source 'http://www.example.org/large-file.tar.gz'
      end
    RUBY
  end
end
