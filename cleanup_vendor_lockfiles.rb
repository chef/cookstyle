#!/usr/bin/env ruby
# frozen_string_literal: true
# Removes stray Gemfile.lock files shipped inside vendored gems to appease security scanners.
# These lock files can contain references to older gem versions with known CVEs.
require 'rubygems'

def cleanup_vendor_lockfiles
  puts 'Cleaning up Gemfile.lock files from all vendored gems...'
  removed = 0

  Gem::Specification.each do |spec|
    gemfile_lock_path = File.join(spec.gem_dir, 'Gemfile.lock')
    next unless File.exist?(gemfile_lock_path)

    puts "  Removing #{gemfile_lock_path}"
    File.delete(gemfile_lock_path)
    removed += 1
  rescue StandardError => e
    warn "  Warning: Failed to remove #{gemfile_lock_path}: #{e.message}"
  end

  puts removed > 0 ? "  Removed #{removed} Gemfile.lock file(s)." : '  No Gemfile.lock files found in vendored gems.'
rescue StandardError => e
  warn "  Warning: Failed to enumerate gem specifications: #{e.message}"
end

cleanup_vendor_lockfiles
