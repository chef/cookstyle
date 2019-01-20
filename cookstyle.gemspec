# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cookstyle/version'

Gem::Specification.new do |spec|
  spec.name          = 'cookstyle'
  spec.version       = Cookstyle::VERSION
  spec.authors       = ['Thom May', 'Tim Smith']
  spec.email         = ['thom@chef.io', 'tsmith@chef.io']

  spec.summary       = 'RuboCop configuration for Chef cookbooks'
  spec.homepage      = 'https://github.com/chef/cookstyle'
  spec.license       = 'Apache-2.0'
  spec.required_ruby_version = '>= 2.4'

  # the gemspec and Gemfile are necessary for appbundling of the gem
  spec.files = %w{LICENSE cookstyle.gemspec Gemfile} + Dir.glob("{lib,bin,config}/**/*")
  spec.executables = %w(cookstyle)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_dependency('rubocop', Cookstyle::RUBOCOP_VERSION)
end
