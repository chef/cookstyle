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
      module Correctness
        # The `checksum` property of the file downloading resources is a SHA-256 digest. An MD5 or
        # SHA-1 digest can never match, so the resource fails the run with a checksum mismatch rather
        # than installing anything.
        #
        # Only digests that are unambiguously the wrong algorithm are flagged: 32 character (MD5) and
        # 40 character (SHA-1) hex strings. Anything else is left alone.
        #
        # @example
        #
        #   # bad
        #   remote_file '/tmp/foo.tar.gz' do
        #     source 'https://example.com/foo.tar.gz'
        #     checksum 'd41d8cd98f00b204e9800998ecf8427e'
        #   end
        #
        #   # good
        #   remote_file '/tmp/foo.tar.gz' do
        #     source 'https://example.com/foo.tar.gz'
        #     checksum 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
        #   end
        #
        class InvalidChecksum < Base
          include RuboCop::Chef::CookbookHelpers

          MSG = 'The checksum property takes a SHA-256 digest. An MD5 or SHA-1 digest can never match, so the run fails with a checksum mismatch.'

          # the file downloading resources that validate a SHA-256 checksum
          RESOURCES = %i(remote_file windows_package msu_package dmg_package).freeze

          # hex digest lengths of the algorithms people reach for by mistake, with the article that
          # reads correctly in front of each name
          WRONG_ALGORITHM_LENGTHS = { 32 => 'an MD5', 40 => 'a SHA-1' }.freeze

          def on_block(node)
            match_property_in_resource?(RESOURCES, 'checksum', node) do |checksum|
              value = checksum.arguments.first
              next unless value&.str_type?

              algorithm = WRONG_ALGORITHM_LENGTHS[value.value.length]
              next unless algorithm && hex?(value.value)

              add_offense(checksum, message: "#{MSG} This looks like #{algorithm} digest.", severity: :refactor)
            end
          end

          private

          # @param [String] string
          #
          # @return [Boolean]
          def hex?(string)
            string.match?(/\A\h+\z/)
          end
        end
      end
    end
  end
end
