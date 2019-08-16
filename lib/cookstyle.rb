require 'cookstyle/version'

require 'pathname'
require 'yaml'

# ensure the desired target version of RuboCop is gem activated
gem 'rubocop', "= #{Cookstyle::RUBOCOP_VERSION}"
require 'rubocop'

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

require 'rubocop/chef'
require 'rubocop/chef/cookbook_helpers'
require 'rubocop/chef/cookbook_only'

# Chef specific cops
Dir.glob(File.dirname(__FILE__) + '/rubocop/cop/chef/**/*.rb') do |file|
  next if File.directory?(file)

  require_relative file # not actually relative but require_relative is faster
end
