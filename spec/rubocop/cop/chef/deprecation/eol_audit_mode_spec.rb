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

describe RuboCop::Cop::Chef::Deprecations::EOLAuditModeUsage, :config do
  it "registers an offense when using the audit mode control_group resource'" do
    expect_offense(<<~RUBY)
      control_group 'Baseline' do
      ^^^^^^^^^^^^^ The beta Audit Mode feature in Chef Infra Client was removed in Chef Infra Client 15.0.
        control 'SSH' do
          it 'should be listening on port 22' do
            expect(port(22)).to be_listening
          end
        end
      end
    RUBY
  end
end
