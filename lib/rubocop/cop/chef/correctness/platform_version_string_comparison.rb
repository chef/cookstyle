# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# Author:: Tim Smith (<tsmith84@gmail.com>)
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
      module Correctness
        # Ohai reports version attributes as strings, so comparing one with `<`, `>`, `<=`, or `>=`
        # compares them character by character rather than as versions. That gives the wrong answer
        # whenever the version numbers have different digit counts:
        #
        #   '7.9' >= '10'   # => true, because '7' sorts after '1'
        #   '9' > '10'      # => true
        #
        # Compare the major version as an integer with `node['platform_version'].to_i`, or compare
        # full versions with `Gem::Version`.
        #
        # @example
        #
        #   # bad
        #   node['platform_version'] >= '10'
        #   node['platform_version'] < '7.4'
        #
        #   # good
        #   node['platform_version'].to_i >= 10
        #   Gem::Version.new(node['platform_version']) >= Gem::Version.new('7.4')
        #
        #   # good - equality is a plain string match, which is fine
        #   node['platform_version'] == '10'
        #
        class PlatformVersionStringComparison < Base
          MSG = 'Ohai version attributes are strings, so comparing them with an ordering operator compares them character by character. Use .to_i for a major version comparison, or Gem::Version to compare full versions.'
          RESTRICT_ON_SEND = %i(< > <= >=).freeze

          # the flat Ohai attributes that hold a dotted version string
          def_node_matcher :version_attribute_comparison?, <<-PATTERN
            (send
              (send (send nil? :node) :[] (str {"platform_version" "os_version"}))
              {:< :> :<= :>=}
              (str _))
          PATTERN

          def on_send(node)
            version_attribute_comparison?(node) do
              add_offense(node, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
