# frozen_string_literal: true
require_relative 'cookstyle/version'

require 'pathname' unless defined?(Pathname)
require 'yaml' unless defined?(YAML)

# ensure the desired target version of RuboCop is gem activated
gem 'rubocop', "= #{Cookstyle::RUBOCOP_VERSION}"
require 'rubocop'
require_relative 'rubocop/monkey_patches/directive_comment'
require_relative 'rubocop/monkey_patches/comment_config'

# monkey patches needed for the TargetChefVersion config option
require_relative 'rubocop/monkey_patches/config'
require_relative 'rubocop/monkey_patches/base'
require_relative 'rubocop/monkey_patches/team'
require_relative 'rubocop/monkey_patches/registry_cop'

# Cookstyle patches the RuboCop tool to set a new default configuration that
# is vendored in the Cookstyle codebase.
module Cookstyle
  # @return [String] the absolute path to the main RuboCop configuration YAML file
  def self.config
    config_file = const_defined?(:CHEFSTYLE_CONFIG) ? 'chefstyle.yml' : 'default.yml'
    File.realpath(File.join(__dir__, '..', 'config', config_file))
  end
end

require_relative 'rubocop/chef'
require_relative 'rubocop/chef/autocorrect_helpers'
require_relative 'rubocop/chef/cookbook_helpers'
require_relative 'rubocop/chef/platform_helpers'
require_relative 'rubocop/chef/cookbook_only'
require_relative 'rubocop/cop/target_chef_version'

# Chef Infra, Chefstyle, and InSpec cops. These files only register the cops with
# RuboCop's global registry; each cop class is loaded on first use rather than at
# require time. See lib/rubocop/cop/chef.rb for details.
require_relative 'rubocop/cop/chef'
require_relative 'rubocop/cop/inspec'

# stub default value of TargetChefVersion to avoid STDERR noise when ConfigLoader.configuration_from_file runs
RuboCop::ConfigLoader.default_configuration['AllCops']['TargetChefVersion'] ||= nil

RuboCop::ConfigLoader.default_configuration = RuboCop::ConfigLoader.configuration_from_file(Cookstyle.config)

# re-stub TargetChefVersion to avoid STDERR noise on *next* configuration load
RuboCop::ConfigLoader.default_configuration['AllCops']['TargetChefVersion'] ||= nil
