# frozen_string_literal: true

# shamelessly borrowed from rubocop-rails. Thanks!

module RuboCop
  module Cop
    # Common functionality for checking target chef version.
    module TargetChefVersion
      def minimum_target_chef_version(version)
        @minimum_target_chef_version = version
      end

      def support_target_chef_version?(version)
        @minimum_target_chef_version <= version
      end
    end
  end
end
