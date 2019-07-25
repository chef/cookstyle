source 'https://rubygems.org'

# Specify your gem's dependencies in cookstyle.gemspec
gemspec

group :debug do
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
end

group :docs do
  gem 'github-markup'
  gem 'redcarpet'
  gem 'yard'
end

group :development do
  gem 'adamantium'
  gem 'anima'
  gem 'concord'
  gem 'rake'
  gem 'rspec', '>= 3.4'
  gem 'simplecov'
end

instance_eval(ENV['GEMFILE_MOD']) if ENV['GEMFILE_MOD']

# If you want to load debugging tools into the bundle exec sandbox,
# add these additional dependencies into Gemfile.local
eval_gemfile(__FILE__ + '.local') if File.exist?(__FILE__ + '.local')
