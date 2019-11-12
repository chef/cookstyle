#
# Copyright:: Copyright 2019, Chef Software Inc.
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

# this is shamelessly copied from the rubocop rspec for this class
# since we're just monkeypatching it and we want to ensure our monkeypatch
# continues to function when we upgrade the engine
RSpec.describe RuboCop::CommentConfig do
  subject(:comment_config) { described_class.new(parse_source(source)) }

  describe '#cop_enabled_at_line?' do
    let(:source) do
      [
        'node.normal[:foo] # rubocop: disable ChefCorrectness/Bar',
        'node.normal[:foo] # cookstyle: disable ChefCorrectness/Foo'
      ].join("\n")
    end

    def disabled_lines_of_cop(cop)
      (1..source.size).each_with_object([]) do |line_number, disabled_lines|
        enabled = comment_config.cop_enabled_at_line?(cop, line_number)
        disabled_lines << line_number unless enabled
      end
    end

    it 'supports disabling cops with the rubocop: disable comment' do
      expect(disabled_lines_of_cop('ChefCorrectness/Bar')).to eq([1])
    end

    it 'supports disabling cops with the cookstyle: disable comment' do
      expect(disabled_lines_of_cop('ChefCorrectness/Foo')).to eq([2])
    end
  end
end
