#
# Copyright:: Copyright 2019-2020, Chef Software Inc.
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
      module ChefCorrectness
        # Libraries should be injected into the Chef::DSL::Recipe class and not Chef::Recipe or Chef::Provider classes directly.
        #
        # @example
        #
        #   # bad
        #   ::Chef::Recipe.send(:include, Filebeat::Helpers)
        #   ::Chef::Provider.send(:include, Filebeat::Helpers)
        #   ::Chef::Recipe.include Filebeat::Helpers
        #   ::Chef::Provider.include Filebeat::Helpers
        #
        #   # good
        #   ::Chef::DSL::Recipe.send(:include, Filebeat::Helpers) # covers previous Recipe & Provider classes
        #
        class IncorrectLibraryInjection < Cop
          MSG = 'Libraries should be injected into the Chef::DSL::Recipe class and not Chef::Recipe or Chef::Provider classes directly.'.freeze

          def_node_matcher :legacy_class_sends?, <<-PATTERN
            (send (const (const (cbase) :Chef) {:Recipe :Provider}) :send (sym :include) ... )
          PATTERN

          def_node_matcher :legacy_class_includes?, <<-PATTERN
            (send (const (const (cbase) :Chef) {:Recipe :Provider}) :include ... )
          PATTERN

          def on_send(node)
            legacy_class_sends?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end

            legacy_class_includes?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, node.source.gsub(/Chef::(Provider|Recipe)/, 'Chef::DSL::Recipe'))
            end
          end
        end
      end
    end
  end
end
