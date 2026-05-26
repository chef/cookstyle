# frozen_string_literal: true
require_relative 'cookstyle/version'

require 'pathname' unless defined?(Pathname)
require 'yaml' unless defined?(YAML)
require 'logger'
require 'json'

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
#
# == Configuration resolution
# Cookstyle ships two YAML profiles:
#   * +default.yml+  — the standard Cookstyle rule set (most users)
#   * +chefstyle.yml+ — the stricter internal Chef style (activated when
#     the +CHEFSTYLE_CONFIG+ constant is defined)
#
# +CONFIG_DIR+ points to the vendored +config/+ directory so that paths
# are resolved once, at load time, and reused by every caller.
module Cookstyle
  # Absolute path to the vendored +config/+ directory.
  # Frozen to prevent accidental mutation at runtime.
  CONFIG_DIR = File.expand_path('../config', __dir__).freeze

  # Optional structured logger, activated by setting COOKSTYLE_LOG.
  #   COOKSTYLE_LOG=stderr  → log to $stderr
  #   COOKSTYLE_LOG=/path   → log to file
  # When unset, logging is a no-op (zero overhead).
  def self.logger
    @logger ||= build_logger
  end

  # Resolve the active configuration file.
  # Emits a structured log line with {op, status, elapsed_ms, config}.
  #
  # @return [String] absolute, symlink-resolved path to the YAML config
  # @raise [RuntimeError] if CONFIG_DIR is missing or the config file is not found
  def self.config
    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    unless Dir.exist?(CONFIG_DIR)
      log_event(t0, 'config', 'error', config_dir: CONFIG_DIR, reason: 'CONFIG_DIR not found')
      raise "Cookstyle CONFIG_DIR not found: #{CONFIG_DIR}"
    end

    config_path = File.join(CONFIG_DIR, config_file_name)

    unless File.exist?(config_path)
      log_event(t0, 'config', 'error', path: config_path, reason: 'config file not found')
      raise "Cookstyle config file not found: #{config_path}"
    end

    resolved = File.realpath(config_path)
    log_event(t0, 'config', 'ok', config: resolved)
    resolved
  end

  # Select the YAML filename based on whether the caller opted into
  # Chefstyle mode by defining +Cookstyle::CHEFSTYLE_CONFIG+.
  #
  # @return [String] +'chefstyle.yml'+ or +'default.yml'+
  # @api private
  def self.config_file_name
    const_defined?(:CHEFSTYLE_CONFIG) ? 'chefstyle.yml' : 'default.yml'
  end
  private_class_method :config_file_name

  # Emit a structured log entry with consistent fields.
  # @api private
  def self.log_event(t0, op, status, extra = {})
    return unless logger

    elapsed_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0) * 1000).round(3)
    entry = { op: op, status: status, elapsed_ms: elapsed_ms }.merge(extra)
    logger.info(JSON.generate(entry))
  end
  private_class_method :log_event

  # @api private
  def self.build_logger
    dest = ENV['COOKSTYLE_LOG']
    return nil if dest.nil? || dest.empty?

    io = dest == 'stderr' ? $stderr : File.open(dest, 'a')
    lg = Logger.new(io, level: Logger::INFO)
    lg.formatter = proc { |_sev, time, _prog, msg| "#{time.utc.iso8601(3)} #{msg}\n" }
    lg
  end
  private_class_method :build_logger
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

# stub default value of TargetChefVersion to avoid STDERR noise when ConfigLoader.configuration_from_file runs
RuboCop::ConfigLoader.default_configuration['AllCops']['TargetChefVersion'] ||= nil

RuboCop::ConfigLoader.default_configuration = RuboCop::ConfigLoader.configuration_from_file(Cookstyle.config)

# re-stub TargetChefVersion to avoid STDERR noise on *next* configuration load
RuboCop::ConfigLoader.default_configuration['AllCops']['TargetChefVersion'] ||= nil
