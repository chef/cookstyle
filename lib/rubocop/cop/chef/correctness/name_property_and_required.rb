#
# Copyright:: Copyright 2019, Chef Software Inc.
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
        # When using properties in a custom resource you shouldn't set a property to
        # be both required and a name_property. Name properties are a way to optionally
        # override the name given to the resource block in cookbook code. In your resource
        # code you use the name_property and if the user doesn't pass in anything to that
        # property its value will be populated with resource block's name. This
        # allows users to provide more friendly resource names for logging that give
        # additional context on the change being made.
        #
        # How about a nice example! Here we have a resource called ntp_config that has a
        # name_property of config_file. All throughout the code of this resource we'd
        # use new_resource.config_file when referencing the path to the config.
        #
        # We can use a friendly name for the block and specific a value to config_file
        # ntp_config 'Configure the main config file' do
        #   config_file '/etc/ntp/ntp.conf'
        #   action :create
        # end
        #
        # We can also just set the config path as the resource block and Chef will
        # make sure to pass this in as new_resource.config_file as well.
        # ntp_config '/etc/ntp/ntp.conf' do
        #   action :create
        # end
        #
        # The core tenant of the name property feature is that these properties are optional
        # and making them required effectively turns off the functionality provided by name
        # properties. If the goal is to always require the user to pass the config_file property
        # then it should just be made a required property and not a name_property.
        #
        #
        # @example
        #
        #
        #   # bad
        #   property :config_file, String, required: true, name_property: true
        #
        #   # good
        #   property :config_file, String, required: true
        #
        class NamePropertyIsRequired < Cop
          MSG = 'Resource properties marked as name properties should not also be required properties'.freeze

          def on_send(node)
            if required_property?(node) && property_is_name_property?(node)
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          private

          def property_is_name_property?(node)
            if node.method_name == :property
              node.arguments.each do |arg|
                if arg.type == :hash
                  return true if arg.source.match?(/name_property:\s*true/)
                end
              end
              false # no required: true found
            end
          end

          def required_property?(node)
            if node.method_name == :property
              node.arguments.each do |arg|
                if arg.type == :hash
                  return true if arg.source.match?(/required:\s*true/)
                end
              end
              false # no default: found
            end
          end
        end
      end
    end
  end
end
