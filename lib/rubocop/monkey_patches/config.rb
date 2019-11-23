# frozen_string_literal: true

module RuboCop
  class Config
    DEFAULT_CHEF_VERSION = 15

    # This is a copy of the #target_rails_version method from Rubocop
    def target_chef_version
      @target_chef_version ||=
        if for_all_cops['TargetChefVersion']
          for_all_cops['TargetChefVersion'].to_f
        else
          DEFAULT_CHEF_VERSION
        end
    end
  end
end
