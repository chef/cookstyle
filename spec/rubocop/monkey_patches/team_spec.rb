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

# this tests the monkey patch we do in lib/rubocop/monkey_patches/team.rb
#
# That patch is a copy of RuboCop's private Team#roundup_relevant_cops with a
# TargetChefVersion check added. When RuboCop changes the method upstream the
# copy keeps running the old logic without any error, so these examples pin
# both the Chef addition and the upstream behavior the copy has to keep.

require 'spec_helper'

describe RuboCop::Cop::Team do
  def offenses_for(source, overrides = {})
    hash = RuboCop::ConfigLoader.default_configuration.to_h.merge(overrides) do |_key, default, override|
      default.is_a?(Hash) ? default.merge(override) : override
    end
    config = RuboCop::Config.new(hash, File.expand_path('.rubocop.yml'))
    registry = RuboCop::Cop::Registry.global

    processed_source = RuboCop::ProcessedSource.new(source, config.target_ruby_version,
                                                    File.expand_path('cookbook/recipes/default.rb'))
    processed_source.config = config
    processed_source.registry = registry

    described_class.mobilize(registry, config, {}).investigate(processed_source).offenses.map(&:cop_name)
  end

  describe 'TargetChefVersion' do
    let(:source) { "libarchive_file 'foo'\n" }

    it 'runs a Chef cop when the target Chef version is new enough' do
      expect(offenses_for(source, 'AllCops' => { 'TargetChefVersion' => 15.0 }))
        .to include('Chef/Modernize/LibarchiveFileResource')
    end

    it 'skips a Chef cop when the target Chef version is too old' do
      expect(offenses_for(source, 'AllCops' => { 'TargetChefVersion' => 14.0 }))
        .not_to include('Chef/Modernize/LibarchiveFileResource')
    end
  end

  describe 'enable comment directives' do
    # Style/Documentation is disabled in cookstyle.yml, so it is never mobilized
    # with the team. RuboCop 1.89 loads such a cop on demand when a comment opts
    # it back in for the file.
    it 'runs a cop that is disabled in the config when a comment enables it' do
      source = <<~RUBY
        # rubocop:enable Style/Documentation
        class Foo
          def bar; end
        end
      RUBY
      expect(offenses_for(source)).to include('Style/Documentation')
    end

    it 'does not run a config-disabled cop the file never enables' do
      source = <<~RUBY
        class Foo
          def bar; end
        end
      RUBY
      expect(offenses_for(source)).not_to include('Style/Documentation')
    end

    # An enable comment opts a cop in, but the file's exclusion still wins.
    it 'does not run an enabled cop on a file it excludes' do
      source = <<~RUBY
        # rubocop:enable Style/GlobalVars
        $foo = 1
      RUBY
      overrides = { 'Style/GlobalVars' => { 'Exclude' => ['**/recipes/default.rb'] } }
      expect(offenses_for(source, overrides)).not_to include('Style/GlobalVars')
    end

    it 'runs an enabled cop on a file it does not exclude' do
      expect(offenses_for("$foo = 1\n")).to include('Style/GlobalVars')
    end
  end
end
