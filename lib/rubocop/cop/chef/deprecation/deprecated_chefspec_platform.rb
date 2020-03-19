#
# Copyright:: 2020, Chef Software Inc.
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

module RuboCop
  module Cop
    module Chef
      module ChefDeprecations
        # Use currently supported platforms in ChefSpec listed at https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md. Fauxhai / ChefSpec will perform fuzzy matching on platform version so it's always best to be less specific ie. 10 instead of 10.3
        #
        # @example
        #
        #   let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') }
        #
        class DeprecatedChefSpecPlatform < Cop
          include RuboCop::Chef::CookbookHelpers

          MSG = "Use currently supported platforms in ChefSpec listed at https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md. Fauxhai / ChefSpec will perform fuzzy matching on platform version so it's always best to be less specific ie. 10 instead of 10.3".freeze

          Gem::Dependency.new('', ['~> 1.4.5', '>= 1.4.6']).match?('', '1.4.6')

          DEPRECATED_MAPPING = {
            'amazon' => {
              '2017.12' => '2',
            },
            'aix' => {
              '~> 6' => true,
            },
            'smartos' => {
              '5.10' => true,
            },
            'ubuntu' => {
              '< 16.04' => true,
              '> 16.04, < 18.04' => true,
            },
            'fedora' => {
              '< 30' => '30',
            },
            'freebsd' => {
              '< 11' => '12',
            },
            'mac_os_x' => {
              '< 10.12' => '10.15',
            },
            'opensuse' => {
              '< 14' => true,
              '~> 42.0' => true,
            },
            'debian' => {
              '< 8' => true,
              '> 8.0, < 8.9' => '8',
              '> 9.0, < 9.8' => '9',
            },
            'centos' => {
              '< 6.0' => true,
              '~> 6.0, < 6.8' => '6',
              '~> 7.0, < 7.6 ' => '7',
            },
            'redhat' => {
              '< 6.0' => true,
              '~> 6.0, < 6.8' => '6',
              '~> 7.0, < 7.6' => '7',
            },
            'oracle' => {
              '< 6.0' => true,
              '~> 6.0, < 6.8' => '6',
              '~> 7.0, < 7.6 ' => '7',
            },
          }.freeze

          def_node_matcher :chefspec_definition?, <<-PATTERN
            (send (const (const nil? :ChefSpec) ... ) :new (hash <(pair (sym :platform) $(str ... )) (pair (sym :version) $(str ... )) ... >))
          PATTERN

          def legacy_chefspec_platform(platform, version)
            return false unless DEPRECATED_MAPPING.key?(platform)

            DEPRECATED_MAPPING[platform].each_pair do |match_string, replacement|
              return true if Gem::Dependency.new('', match_string.split(',')).match?('', version) &&
                             replacement != version # we want to catch '7.0' and suggest '7', but not alert on '7'
            end

            false
          end

          def replacement_string(platform, version)
            DEPRECATED_MAPPING[platform].each_pair do |match_string, replacement|
              return replacement if Gem::Dependency.new('', match_string.split(',')).match?('', version) &&
                                    replacement != version && # we want to catch '7.0' and suggest '7', but not alert on '7'
                                    replacement != true # true means it's busted, but requires human intervention to fix
            end

            nil # we don't have a replacement os return nil
          end

          def on_send(node)
            chefspec_definition?(node) do |plat, ver|
              add_offense(node, location: :expression, message: MSG, severity: :warning) if legacy_chefspec_platform(plat.value, ver.value)
            end
          end

          def autocorrect(node)
            chefspec_definition?(node) do |plat, ver|
              if replacement = replacement_string(plat.value, ver.value) # rubocop: disable Lint/AssignmentInCondition
                lambda do |corrector|
                  corrector.replace(ver.loc.expression, "'#{replacement}'")
                end
              end
            end
          end
        end
      end
    end
  end
end
