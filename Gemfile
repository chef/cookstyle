# frozen_string_literal: true
source 'https://rubygems.org'

# Specify your gem's dependencies in cookstyle.gemspec
gemspec

group :debug do
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-stack_explorer', '~> 0.4.0' # 0.5.0 drops support for Ruby < 2.6
end

group :docs do
  gem 'github-markup'
  gem 'redcarpet'
  gem 'yard'
end

group :profiling do
  gem 'stackprof'
  gem 'memory_profiler'
end

group :development do
  gem 'adamantium'
  gem 'anima'
  gem 'concord'
  gem 'rake'
  gem 'rspec', '>= 3.4'
  gem 'simplecov'
end
