# frozen_string_literal: true

# require "pry"

module RuboCop
  module Cop
    class Team
      def support_target_chef_version?(cop)
        return true unless cop.class.respond_to?(:support_target_chef_version?)

        cop.class.support_target_chef_version?(cop.target_chef_version)
      end

      ### START COOKSTYLE MODIFICATION
      def roundup_relevant_cops(filename)

 #       binding.pry
        cops.reject do |cop|
          cop.excluded_file?(filename) ||
            !support_target_ruby_version?(cop) ||
            !support_target_chef_version?(cop) ||
            !support_target_rails_version?(cop)
        end
      end
      ### END COOKSTYLE MODIFICATION
    end
  end
end
