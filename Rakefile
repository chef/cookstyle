require "bundler/gem_tasks"

upstream = Gem::Specification.find_by_name("rubocop")

desc "Vendor rubocop-#{upstream.version} configuration into gem"
task :vendor do
  src = Pathname.new(upstream.gem_dir).join("config")
  dst = Pathname.new(__FILE__).dirname.join("config")

  mkdir_p dst
  cp(src.join("default.yml"), dst.join("upstream.yml"))
  cp(src.join("enabled.yml"), dst.join("enabled.yml"))
  cp(src.join("disabled.yml"), dst.join("disabled.yml"))

  require 'rubocop'
  require 'yaml'
  cfg = RuboCop::Cop::Cop.all.inject({}) { |acc, cop| acc[cop.cop_name] = {"Enabled" => false}; acc }
  File.open(dst.join("disable_all.yml"), "w"){|fh| fh.write cfg.to_yaml }

  sh %{git add #{dst}/{upstream,enabled,disabled,disable_all}.yml}
  sh %{git commit -m "Vendor rubocop-#{upstream.version} upstream configuration."}
end

require "cookstyle"
require "rubocop/rake_task"
RuboCop::RakeTask.new(:style) do |task|
  task.options << "--display-cop-names"
end

task default: [:build, :install]
