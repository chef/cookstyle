# frozen_string_literal: true

module RuboCop
  module Cop
    class Team
      def support_target_chef_version?(cop)
        return true unless cop.class.respond_to?(:support_target_chef_version?)

        cop.class.support_target_chef_version?(cop.target_chef_version)
      end

      # Copied from RuboCop 1.92.2. The only change is the added
      # support_target_chef_version? condition. Re-sync with upstream on every
      # RuboCop bump: if the original changes, this copy silently keeps the old logic.
      ### START COOKSTYLE MODIFICATION
      def roundup_relevant_cops(processed_source)
        (cops + opted_in_standby_cops(processed_source)).select do |cop|
          next false if cop.excluded_file?(processed_source.file_path)
          next true if processed_source.comment_config.cop_opted_in?(cop)
          next false unless @registry.enabled?(cop, @config)

          support_target_ruby_version?(cop) && support_target_rails_version?(cop) && support_target_chef_version?(cop)
        end
      end
      ### END COOKSTYLE MODIFICATION
    end
  end
end
