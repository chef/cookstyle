# frozen_string_literal: true
require 'spec_helper'

# Unit tests for the top-level Cookstyle module.
# Covers version constants, CONFIG_DIR, and the .config resolver.
RSpec.describe Cookstyle do
  describe 'VERSION' do
    it 'is a valid semver string' do
      expect(Cookstyle::VERSION).to match(/\A\d+\.\d+\.\d+\z/)
    end
  end

  describe 'RUBOCOP_VERSION' do
    it 'is a valid semver string' do
      expect(Cookstyle::RUBOCOP_VERSION).to match(/\A\d+\.\d+\.\d+\z/)
    end
  end

  describe 'CONFIG_DIR' do
    it 'points to the config directory' do
      expect(Cookstyle::CONFIG_DIR).to end_with('config')
    end

    it 'is a directory that exists on disk' do
      expect(Dir.exist?(Cookstyle::CONFIG_DIR)).to be true
    end
  end

  describe '.config' do
    it 'returns a path ending with default.yml' do
      expect(Cookstyle.config).to end_with('config/default.yml')
    end

    it 'points to an existing file' do
      expect(File.exist?(Cookstyle.config)).to be true
    end

    it 'raises with a clear message when the config file is missing' do
      allow(Cookstyle).to receive(:config_file_name).and_return('nonexistent.yml')
      expect { Cookstyle.config }.to raise_error(RuntimeError, /config file not found.*nonexistent\.yml/)
    end

    it 'raises with a clear message when CONFIG_DIR does not exist' do
      stub_const('Cookstyle::CONFIG_DIR', '/no/such/directory')
      expect { Cookstyle.config }.to raise_error(RuntimeError, /CONFIG_DIR not found.*\/no\/such\/directory/)
    end
  end
end
