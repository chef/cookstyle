# frozen_string_literal: true
require_relative 'cookstyle/version'

require 'pathname' unless defined?(Pathname)
require 'yaml' unless defined?(YAML)

# ensure the desired target version of RuboCop is gem activated
gem 'rubocop', "= #{Cookstyle::RUBOCOP_VERSION}"
require 'rubocop'
require_relative 'rubocop/monkey_patches/directive_comment'

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
    File.realpath(File.join(__dir__, '..', 'config', 'default.yml'))
  end
end

require_relative 'rubocop/chef'
require_relative 'rubocop/chef/autocorrect_helpers'
require_relative 'rubocop/chef/cookbook_helpers'
require_relative 'rubocop/chef/platform_helpers'
require_relative 'rubocop/chef/cookbook_only'
require_relative 'rubocop/cop/target_chef_version'

# Chef Infra specific cops
Dir.glob(__dir__ + '/rubocop/cop/**/*.rb') do |file|
  next if File.directory?(file)

  require_relative file # not actually relative but require_relative is faster
end

# stub default value of TargetChefVersion to avoid STDERR noise
RuboCop::ConfigLoader.default_configuration['AllCops']['TargetChefVersion'] = '~'

RuboCop::ConfigLoader.default_configuration = RuboCop::ConfigLoader.configuration_from_file(Cookstyle.config)
