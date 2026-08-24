# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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

# Every cop spec must prove that the cop stays quiet on code it shouldn't flag, not
# just that it fires on code it should. For a linter this is the more important half:
# most of our cops autocorrect, so a false positive silently rewrites a working
# cookbook. Only an `expect_no_offenses` example catches that.
describe 'cop specs' do
  # The Chef/Effortless department is slated for removal, so its specs are not held to
  # this rule. Derived from a glob rather than a hardcoded list so that this exclusion
  # becomes a no-op the moment the directory goes away.
  pending_removal = Dir.glob('spec/rubocop/cop/chef/effortless/*_spec.rb')

  spec_files = Dir.glob('spec/rubocop/cop/**/*_spec.rb') - pending_removal

  it 'finds cop specs to check' do
    expect(spec_files).not_to be_empty
  end

  it 'all assert that clean code registers no offense' do
    missing = spec_files.reject { |f| File.read(f).include?('expect_no_offenses') }.sort

    expect(missing).to eq([]), <<~MSG
      #{missing.count} cop spec(s) have no `expect_no_offenses` example:

      #{missing.map { |f| "  #{f}" }.join("\n")}

      A cop spec needs both halves: `expect_offense` proves the cop fires on the code
      it targets, and `expect_no_offenses` proves it leaves everything else alone.
      Write the negative case against a near miss — the method with a similar name, the
      resource with a similar property, the string that starts the same way — rather
      than against unrelated code, which proves nothing.

      spec/rubocop/cop/chef/correctness/node_save_spec.rb is a short example of both.
    MSG
  end
end
