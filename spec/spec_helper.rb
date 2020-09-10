# frozen_string_literal: true
require 'rubocop'
require 'rubocop/rspec/support'

module SpecHelper
  ROOT = Pathname.new(__dir__).parent.freeze
end

spec_helper_glob = File.expand_path('{support,shared}/*.rb', __dir__)
Dir.glob(spec_helper_glob).map(&method(:require))

RSpec.configure do |config|
  # Basic configuration
  config.run_all_when_everything_filtered = true
  config.filter_run(:focus)
  config.order = :random

  config.include RuboCop::RSpec::ExpectOffense
end

$LOAD_PATH.unshift(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift(__dir__)

# small helper for use in let blocks
def target_chef_version(version)
  RuboCop::Config.new('AllCops' => { 'TargetChefVersion' => version })
end

require 'cookstyle'
