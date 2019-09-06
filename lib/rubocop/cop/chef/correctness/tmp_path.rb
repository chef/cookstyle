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

module RuboCop
  module Cop
    module Chef
      module ChefCorrectness
        # Use file_cache_path rather than hard-coding tmp paths
        #
        # @example downloading a large file into /tmp/
        #
        #   # bad
        #   remote_file '/tmp/large-file.tar.gz' do
        #
        #   # good
        #   remote_file "#{Chef::Config[:file_cache_path]}/large-file.tar.gz" do
        #
        #
        class TmpPath < Cop
          MSG = 'Use file_cache_path rather than hard-coding tmp paths'.freeze

          def_node_matcher :remote_file?, <<-PATTERN
            (send nil? :remote_file $str)
          PATTERN

          def on_send(node)
            remote_file?(node) do |command|
              if hardcoded_tmp?(command) && !file_cache_path?(command)
                add_offense(command, location: :expression, message: MSG, severity: :refactor)
              end
            end
          end

          def hardcoded_tmp?(path)
            path_str = path.to_s.scan(/"(.*)"/)[0][0]
            path_str.start_with?('/tmp/')
          end

          def file_cache_path?(path)
            path_str = path.to_s.scan(/"(.*)"/)[0][0]
            path_str.start_with?("\#\{Chef::Config[:file_cache_path]\}")
          end
        end
      end
    end
  end
end
