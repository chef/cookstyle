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

  describe '.config' do
    it 'returns a path ending with default.yml' do
      expect(Cookstyle.config).to end_with('config/default.yml')
    end

    it 'points to an existing file' do
      expect(File.exist?(Cookstyle.config)).to be true
    end
  end
end
