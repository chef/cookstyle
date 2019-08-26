#
# Copyright:: 2019, Chef Software, Inc.
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
      # The xml::ruby recipe was used to install nokogiri into the Chef installation. Nokogiri is included
      # in Chef Infra Client 12 and later so this recipe is no longer necessary.
      #
      # @example
      #
      #   # bad
      #   include_recipe 'xml::ruby'
      #
      class IncludingXMLRubyRecipe < Cop
        MSG = 'The xml::ruby recipe installs nokogiri which is included in Chef Infra Client 12 and later.'.freeze

        def_node_matcher :xml_ruby_recipe?, <<-PATTERN
          (send nil? :include_recipe (str "xml::ruby"))
        PATTERN

        def on_send(node)
          xml_ruby_recipe?(node) do
            add_offense(node, location: :expression, message: MSG, severity: :refactor)
          end
        end

        def autocorrect(node)
          lambda do |corrector|
            corrector.remove(node.loc.expression)
          end
        end
      end
    end
  end
end
