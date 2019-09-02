require 'bundler/gem_tasks'

upstream = Gem::Specification.find_by_name('rubocop')

desc "Vendor rubocop-#{upstream.version} configuration into gem"
task :vendor do
  src = Pathname.new(upstream.gem_dir).join('config')
  dst = Pathname.new(__FILE__).dirname.join('config')

  mkdir_p dst
  cp(src.join('default.yml'), dst.join('upstream.yml'))

  require 'rubocop'
  require 'yaml'
  cfg = RuboCop::Cop::Cop.all.each_with_object({}) { |cop, acc| acc[cop.cop_name] = { 'Enabled' => false }; }
  File.open(dst.join('disable_all.yml'), 'w') { |fh| fh.write cfg.to_yaml }

  sh %(git add #{dst}/{upstream,disable_all}.yml)
  sh %(git commit -m "Vendor rubocop-#{upstream.version} upstream configuration.")
end

require 'cookstyle'
require 'rubocop/rake_task'
RuboCop::RakeTask.new(:style) do |task|
  task.options << '--display-cop-names'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc 'Run RSpec with code coverage'
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task['spec'].execute
end

desc 'Run Cookstyle over this gem'
task :internal_investigation do
  sh('bundle exec cookstyle')
end

desc 'Ensure that all cops are defined in the cookstyle.yml config'
task :validate_config do
  require 'cookstyle'
  require 'yaml'
  status = 0
  config = YAML.load_file('config/cookstyle.yml')

  RuboCop::Cop::Chef.constants.each do |cop|
    unless config["Chef/#{cop}"]
      puts "Error: Chef/#{cop} not found in config/cookstyle.yml"
      status = 1
    end
  end

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
task default: [:style, :spec]
