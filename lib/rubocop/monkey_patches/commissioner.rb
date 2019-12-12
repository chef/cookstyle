# frozen_string_literal: true

module RuboCop
  module Cop
    class Commissioner
      def remove_irrelevant_cops(filename)
        @cops.reject! { |cop| cop.excluded_file?(filename) }
        @cops.reject! do |cop|
          cop.class.respond_to?(:support_target_ruby_version?) &&
            !cop.class.support_target_ruby_version?(cop.target_ruby_version)
        end
        @cops.reject! do |cop|
          cop.class.respond_to?(:support_target_rails_version?) &&
            !cop.class.support_target_rails_version?(cop.target_rails_version)
        end

        ### START COOKSTYLE MODIFICATION
        @cops.reject! do |cop|
          cop.class.respond_to?(:support_target_chef_version?) &&
            !cop.class.support_target_chef_version?(cop.target_chef_version)
        end
        ### END COOKSTYLE MODIFICATION
      end
    end
  end
end
