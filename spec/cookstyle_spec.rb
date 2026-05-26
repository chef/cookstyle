# frozen_string_literal: true
require 'spec_helper'

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
  end
end
