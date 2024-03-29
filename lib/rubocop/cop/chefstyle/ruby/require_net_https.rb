# frozen_string_literal: true
#
# Copyright:: Chef Software, Inc.
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
      module Ruby
        # net/https is deprecated and just includes net/http and openssl. We should include those directly instead.
        #
        # @example
        #
        #   # bad
        #   require 'net/https'
        #
        #   # good
        #   require 'net/http'
        #   require 'openssl'
        #
        class RequireNetHttps < Base
          extend RuboCop::Cop::AutoCorrector

          MSG = 'net/https is deprecated and just includes net/http and openssl. We should include those directly instead.'

          def_node_matcher :require_net_https?, <<-PATTERN
            (send nil? :require (str "net/https"))
          PATTERN

          def on_send(node)
            require_net_https?(node) do
              add_offense(node.loc.expression, message: MSG, severity: :refactor) do |corrector|
                corrector.replace(node, %(require "net/http"\nrequire "openssl"))
              end
            end
          end
        end
      end
    end
  end
end
