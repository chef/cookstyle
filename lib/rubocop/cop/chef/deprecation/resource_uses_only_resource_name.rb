#
# Copyright:: 2020, Chef Software, Inc.
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
        # Starting with Chef Infra Client 16, using `resource_name` without also using `provides` will result in resource failures. Use `provides` to change the name of the resource instead and omit `resource_name` entirely if it matches the name Chef Infra Client automatically assigns based on COOKBOOKNAME_FILENAME.
        #
        # @example
        #
        #   # bad
        #   mycookbook/resources/myresource.rb:
        #   resource_name :mycookbook_myresource
        #
        class ResourceUsesOnlyResourceName < Cop
          include RuboCop::Chef::CookbookHelpers
          include RangeHelp

          MSG = 'Starting with Chef Infra Client 16 using `resource_name` without also using `provides` will result in resource failures. Use `provides` to change the name of the instead and skip the `resource_name` entirely if it matches the name Chef Infra Client automatically assigned based on COOKBOOKNAME_FILENAME.'.freeze

          def_node_matcher :resource_name?, <<-PATTERN
          (send nil? :resource_name (sym $_ ))
          PATTERN

          def_node_search :cb_name_match, <<~PATTERN
          (send nil? :name (str $_))
          PATTERN

          def_node_search :provides_methods?, '(send nil? {:provides :chef_version_for_provides} ... )'

          def cookbook_name
            cb_path = File.expand_path(File.join(processed_source.file_path, '../..'))

            if File.exist?(File.join(cb_path, 'metadata.rb'))
              cb_metadata_ast = ProcessedSource.from_file(File.join(cb_path, 'metadata.rb'), @config.target_ruby_version).ast
              cb_name_match(cb_metadata_ast).first
            elsif File.exist?(File.join(cb_path, 'metadata.json')) # this exists only for supermarket files that lack metadata.rb
              JSON.parse(File.read(File.join(cb_path, 'metadata.json')))['name']
            end
          end

          def on_send(node)
            resource_name?(node) do |_name|
              add_offense(node, location: :expression, message: MSG, severity: :warning) unless provides_methods?(processed_source.ast)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              resource_name?(node) do |name|
                if name.to_s == "#{cookbook_name}_#{File.basename(processed_source.path, '.rb')}"
                  corrector.remove(range_with_surrounding_space(range: node.loc.expression, side: :left))
                else
                  corrector.replace(node.loc.expression, node.source.gsub('resource_name', 'provides'))
                end
              end
            end
          end
        end
      end
    end
  end
end
