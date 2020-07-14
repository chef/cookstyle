# frozen_string_literal: true
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
      module ChefModernize
        # There is no need to check if the chef_gem resource supports compile_time as Chef Infra Client 12.1 and later support the compile_time property.
        #
        #   # bad
        #   chef_gem 'ultradns-sdk' do
        #     compile_time true if Chef::Resource::ChefGem.method_defined?(:compile_time)
        #     action :nothing
        #   end
        #
        #   chef_gem 'ultradns-sdk' do
        #     compile_time true if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
        #     action :nothing
        #   end
        #
        #   chef_gem 'ultradns-sdk' do
        #     compile_time true if respond_to?(:compile_time)
        #     action :nothing
        #   end
        #
        #   # good
        #   chef_gem 'ultradns-sdk' do
        #     compile_time true
        #     action :nothing
        #   end
        #
        class RespondToCompileTime < Cop
          extend TargetChefVersion

          minimum_target_chef_version '12.1'

          MSG = 'There is no need to check if the chef_gem resource supports compile_time as Chef Infra Client 12.1 and later support the compile_time property.'

          def_node_matcher :compile_time_method_defined?, <<-PATTERN
          (if
            {
              (send
              (const
                (const
                  (const nil? :Chef) :Resource) :ChefGem) :method_defined?
              (sym :compile_time))

              (send
                (send
                  (const
                    (const
                      (const nil? :Chef) :Resource) :ChefGem) :instance_methods
                  (false)) :include?
                (sym :compile_time))

              (send nil? :respond_to?
                (sym :compile_time))
            }
            (send nil? :compile_time
              $(_)) nil?)
          PATTERN

          def on_if(node)
            compile_time_method_defined?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              compile_time_method_defined?(node) do |val|
                corrector.replace(node.loc.expression, "compile_time #{val.source}")
              end
            end
          end
        end
      end
    end
  end
end
