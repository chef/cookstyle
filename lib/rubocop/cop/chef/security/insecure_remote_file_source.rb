# frozen_string_literal: true
#
# Copyright:: Copyright (c) 2016-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
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
module RuboCop
  module Cop
    module Chef
      module Security
        # Files downloaded over plain HTTP or FTP can be modified in transit, and the resource will
        # use whatever it receives. Fetch them over HTTPS so the transport is authenticated.
        #
        # Where an HTTPS endpoint genuinely isn't available, a `checksum` on the resource at least
        # detects tampering, since the digest is compared before the file is used.
        #
        # @example
        #
        #   # bad
        #   remote_file '/tmp/foo.tar.gz' do
        #     source 'http://example.com/foo.tar.gz'
        #   end
        #
        #   # good
        #   remote_file '/tmp/foo.tar.gz' do
        #     source 'https://example.com/foo.tar.gz'
        #   end
        #
        class InsecureRemoteFileSource < Base
          include RuboCop::Chef::CookbookHelpers

          MSG = 'Fetch remote files over HTTPS. A file downloaded over plain HTTP or FTP can be modified in transit and the resource will use whatever it receives.'

          # the resources that download a file from the source property
          RESOURCES = %i(remote_file windows_package msu_package dmg_package cab_package).freeze

          # transports with no authentication of the server or the payload
          INSECURE_SCHEME = %r{\A(?:http|ftp)://}i.freeze

          def on_block(node)
            match_property_in_resource?(RESOURCES, 'source', node) do |source|
              source.arguments.each do |argument|
                # remote_file also accepts an array of mirrors, any one of which may be insecure
                urls = argument.array_type? ? argument.values : [argument]
                urls.each { |url| add_offense(url, severity: :warning) if insecure_url?(url) }
              end
            end
          end

          private

          # A dstr's leading literal is enough to read the scheme off an interpolated URL. Anything
          # that isn't a literal string, such as a node attribute, tells us nothing and is left alone.
          #
          # @param [RuboCop::AST::Node] node
          #
          # @return [Boolean]
          def insecure_url?(node)
            literal = if node.str_type?
                        node.value
                      elsif node.dstr_type? && node.children.first&.str_type?
                        node.children.first.value
                      end

            literal ? INSECURE_SCHEME.match?(literal) : false
          end
        end
      end
    end
  end
end
