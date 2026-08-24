# frozen_string_literal: true
require 'bundler/gem_tasks'

Dir['tasks/**/*.rake'].each { |t| load t }

require 'cookstyle'
desc 'Run cookstyle against cookstyle'
task :style do
  sh('bundle exec cookstyle')
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/cop/**/*.rb']
end

desc 'Ensure that all cops are defined in the cookstyle.yml and chefstyle.yml configs'
task :validate_config do
  require 'cookstyle'
  require 'yaml' unless defined?(YAML)
  status = 0
  configs = {
    'config/cookstyle.yml' => YAML.load_file('config/cookstyle.yml'),
    'config/chefstyle.yml' => YAML.load_file('config/chefstyle.yml'),
  }

  puts 'Checking that all cops are defined in the cookstyle.yml and chefstyle.yml configs:'

  RuboCop::Cop::Chef.constants.each do |dep|
    department = RuboCop::Cop::Chef.const_get(dep)
    department.constants.each do |cop|
      # Cookstyle and Chefstyle cops share the RuboCop::Cop::Chef namespace but ship separate
      # configs, so check each cop against the config that matches where it's defined.
      source = department.const_source_location(cop)&.first.to_s
      config_file = source.include?('/cop/chefstyle/') ? 'config/chefstyle.yml' : 'config/cookstyle.yml'

      next if configs[config_file]["Chef/#{dep}/#{cop}"]

      puts "Error: Chef/#{dep}/#{cop} not found in #{config_file}"
      status = 1
    end
  end

  puts 'All Cops found in the config. Good work.' if status == 0

  exit status
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new(:docs)
rescue LoadError
  puts 'yard is not available. bundle install first to make sure all dependencies are installed.'
end

task :console do
  require 'irb'
  require 'irb/completion'
  ARGV.clear
  IRB.start
end

task default: [:style, :spec, :validate_config]
