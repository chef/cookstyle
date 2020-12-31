# frozen_string_literal: true
source 'https://rubygems.org'

# Specify your gem's dependencies in cookstyle.gemspec
gemspec

group :debug do
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-stack_explorer', '< 0.4.13' # 0.4.13+ drops support for Ruby < 2.6
end

group :docs do
  gem 'yard'
end

group :profiling do
  gem 'memory_profiler'
  gem 'stackprof'
end

group :rubocop_gems do
  gem 'rubocop-performance'
end

group :development do
  gem 'rake'
  gem 'rspec', '>= 3.4'
end