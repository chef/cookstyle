require_relative 'cookstyle/version'

require 'pathname'
require 'yaml'

# ensure the desired target version of RuboCop is gem activated
gem 'rubocop', "= #{Cookstyle::RUBOCOP_VERSION}"
require 'rubocop'
require 'rubocop/monkey_patches/comment_config.rb'

# monkey patches needed for the TargetChefVersion config option
require 'rubocop/monkey_patches/config.rb'
require 'rubocop/monkey_patches/cop.rb'
require 'rubocop/monkey_patches/commissioner.rb'

module RuboCop
  class ConfigLoader
    RUBOCOP_HOME.gsub!(
      /^.*$/,
      File.realpath(File.join(File.dirname(__FILE__), '..'))
    )

    DEFAULT_FILE.gsub!(
      /^.*$/,
      File.join(RUBOCOP_HOME, 'config', 'default.yml')
    )
  end
end

# Cookstyle patches the RuboCop tool to set a new default configuration that
# is vendored in the Cookstyle codebase.
module Cookstyle
  # @return [String] the absolute path to the main RuboCop configuration YAML file
  def self.config
    RuboCop::ConfigLoader::DEFAULT_FILE
  end
end

require_relative 'rubocop/chef'
require_relative 'rubocop/chef/autocorrect_helpers'
require_relative 'rubocop/chef/cookbook_helpers'
require_relative 'rubocop/chef/platform_helpers'
require_relative 'rubocop/chef/cookbook_only'
require_relative 'rubocop/cop/target_chef_version'

# Chef Infra specific cops
Dir.glob(File.dirname(__FILE__) + '/rubocop/cop/chef/**/*.rb') do |file|
  next if File.directory?(file)

  require_relative file # not actually relative but require_relative is faster
end
