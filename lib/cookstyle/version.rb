# frozen_string_literal: true

# Version constants for the Cookstyle gem.
#
# VERSION tracks the Cookstyle release itself.
# RUBOCOP_VERSION pins the exact RuboCop engine that Cookstyle wraps;
# changing it requires re-testing every vendored cop.
module Cookstyle
  # @return [String] SemVer version of the Cookstyle gem (e.g. "8.7.0")
  VERSION = "8.7.0" # rubocop: disable Style/StringLiterals

  # @return [String] exact RuboCop version Cookstyle depends on at runtime
  RUBOCOP_VERSION = '1.86.1'
end
