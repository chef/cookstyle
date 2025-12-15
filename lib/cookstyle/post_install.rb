# frozen_string_literal: true
module Cookstyle
  module PostInstall
    def self.run
      puts 'Hello World'
      spec = Gem::Specification.find_all_by_name('lint_roller').find { |s| s.version.to_s == '1.1.0' }
      return unless spec

      lock_path = File.join(spec.gem_dir, 'Gemfile.lock')
      File.delete(lock_path) if File.exist?(lock_path)
    rescue StandardError => e
      warn "Cookstyle post-install hook warning: #{e.message}"
    end
  end
end
