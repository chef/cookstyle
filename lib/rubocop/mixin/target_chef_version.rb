module RuboCop
  module Cop
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
