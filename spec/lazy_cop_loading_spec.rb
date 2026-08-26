# frozen_string_literal: true
#
# Copyright:: 2026, Tim Smith
# Author:: Tim Smith (<tsmith84@proton.me>)
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

require 'English'
require 'spec_helper'

# Cops are registered for lazy loading in lib/rubocop/cop/chef.rb and
# lib/rubocop/cop/inspec.rb rather than being required by a glob over the cop
# directories. That's a large speedup, but it means adding a cop file is no longer
# enough to ship the cop: it also has to be registered. These examples make a missing
# or duplicated registration a test failure instead of a silently absent cop.
describe 'lazy cop loading' do
  # Registration files and mixins, i.e. everything under lib/rubocop/cop that is not
  # itself a cop.
  let(:non_cop_files) do
    %w(
      lib/rubocop/cop/chef.rb
      lib/rubocop/cop/inspec.rb
      lib/rubocop/cop/target_chef_version.rb
    )
  end

  let(:registration_files) { non_cop_files.grep(%r{/(chef|inspec)\.rb\z}) }

  let(:cop_files) do
    (Dir.glob('lib/rubocop/cop/**/*.rb') - non_cop_files).sort
  end

  let(:registered_paths) do
    registration_files.flat_map do |registration_file|
      dir = File.dirname(registration_file)
      File.read(registration_file).scan(%r{register_cop :\w+, "\#\{__dir__\}/(.+?)"}).flatten.map do |path|
        "#{dir}/#{path}.rb"
      end
    end
  end

  it 'finds cop files to check' do
    expect(cop_files).not_to be_empty
  end

  it 'registers every cop file' do
    unregistered = (cop_files - registered_paths).sort

    expect(unregistered).to eq([]), <<~MSG
      #{unregistered.count} cop file(s) are not registered for lazy loading, so their cops
      will never run. Add a `register_cop` entry in lib/rubocop/cop/chef.rb or
      lib/rubocop/cop/inspec.rb for:

      #{unregistered.join("\n")}
    MSG
  end

  it 'does not register a path that has no file' do
    missing = (registered_paths - cop_files).sort

    expect(missing).to eq([]), <<~MSG
      #{missing.count} registered path(s) do not exist on disk:

      #{missing.join("\n")}
    MSG
  end

  it 'registers each cop file exactly once' do
    duplicates = registered_paths.tally.select { |_path, count| count > 1 }.keys.sort

    expect(duplicates).to eq([]), <<~MSG
      #{duplicates.count} cop file(s) are registered more than once:

      #{duplicates.join("\n")}
    MSG
  end

  it 'registers each cop under the name its class actually uses' do
    mismatched = %w(Chef InSpec).flat_map do |namespace|
      top = RuboCop::Cop.const_get(namespace)

      top.constants.flat_map do |dept_name|
        department = top.const_get(dept_name)

        department.constants.filter_map do |cop_name|
          badge = "#{namespace}/#{dept_name}/#{cop_name}"
          # Resolving the constant fires the autoload. If the file defines the class under a
          # different name, the constant will not be defined afterwards and Ruby raises here.
          cop_class = department.const_get(cop_name)
          badge unless cop_class.respond_to?(:badge) && cop_class.badge.to_s == badge
        end
      end
    end

    expect(mismatched).to eq([])
  end

  # Guards the actual win. Runs in a subprocess because this process has already loaded
  # cop classes by the time the examples above are done with them.
  it 'loads no cop classes when cookstyle is required' do
    script = <<~RUBY
      $LOAD_PATH.unshift(#{File.expand_path('lib').inspect})
      require 'cookstyle'
      cop_dir = #{File.expand_path('lib/rubocop/cop').inspect}
      loaded = $LOADED_FEATURES.select { |f| f.start_with?(cop_dir + '/') }
      puts "REGISTERED:\#{RuboCop::Cop::Registry.global.length}"
      puts(loaded - #{non_cop_files.map { |f| File.expand_path(f) }.inspect})
    RUBY

    # stderr is left alone rather than merged into stdout: Ruby or RubyGems warnings are
    # not this example's business, and merging them would corrupt the parse below.
    output = IO.popen([RbConfig.ruby, '-e', script], &:read)
    status = $CHILD_STATUS

    # Without this the example would pass for the wrong reason if the subprocess failed
    # to boot at all and printed nothing.
    expect(status).to be_success, "subprocess exited #{status.exitstatus}, see stderr above"

    registered, *cop_files_loaded = output.split("\n")

    expect(registered.to_s[/\d+/].to_i).to be > 0
    expect(cop_files_loaded).to eq([])
  end
end
