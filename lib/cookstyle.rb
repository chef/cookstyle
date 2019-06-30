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
require 'rubocop/chef/inject'
require 'rubocop/chef/cookbook_only'

RuboCop::Chef::Inject.defaults!

# cops
require 'rubocop/cop/chef/attribute_keys'
require 'rubocop/cop/chef/file_mode'
require 'rubocop/cop/chef/service_resource'
require 'rubocop/cop/chef/comments_format'
require 'rubocop/cop/chef/comments_copyright_format'
