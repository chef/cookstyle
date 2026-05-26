# frozen_string_literal: true
require 'spec_helper'
require 'benchmark'
require 'json'
require 'stringio'

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

    # Micro-benchmark: .config must resolve in under 5 ms per call (median of 1000).
    # The generous ceiling avoids flaky CI; real-world numbers are ~0.01–0.05 ms.
    it 'resolves within 5 ms per call (1000 iterations)' do
      iterations = 1000
      elapsed = Benchmark.realtime { iterations.times { Cookstyle.config } }
      median_ms = (elapsed / iterations) * 1000.0
      # Print for manual baseline capture; assertion guards against regressions.
      $stderr.puts format("\n  [perf] Cookstyle.config  median=%.4f ms  total=%.2f ms  (n=%d)", median_ms, elapsed * 1000, iterations)
      expect(median_ms).to be < 5.0
    end
  end

  describe '.logger' do
    after { Cookstyle.instance_variable_set(:@logger, nil) }

    it 'returns nil when COOKSTYLE_LOG is not set' do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('COOKSTYLE_LOG').and_return(nil)
      Cookstyle.instance_variable_set(:@logger, nil)
      expect(Cookstyle.logger).to be_nil
    end

    it 'returns a Logger when COOKSTYLE_LOG=stderr' do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('COOKSTYLE_LOG').and_return('stderr')
      Cookstyle.instance_variable_set(:@logger, nil)
      expect(Cookstyle.logger).to be_a(Logger)
    end
  end

  describe 'structured log output' do
    let(:log_output) { StringIO.new }

    before do
      lg = Logger.new(log_output, level: Logger::INFO)
      lg.formatter = proc { |_sev, time, _prog, msg| "#{time.utc.iso8601(3)} #{msg}\n" }
      Cookstyle.instance_variable_set(:@logger, lg)
    end

    after { Cookstyle.instance_variable_set(:@logger, nil) }

    it 'emits JSON with op, status, and elapsed_ms on success' do
      Cookstyle.config
      line = log_output.string.lines.last
      entry = JSON.parse(line.sub(/\A\S+\s/, ''))
      expect(entry).to include('op' => 'config', 'status' => 'ok')
      expect(entry['elapsed_ms']).to be_a(Numeric)
      expect(entry['config']).to end_with('default.yml')
    end

    it 'emits JSON with status=error when config file is missing' do
      allow(Cookstyle).to receive(:config_file_name).and_return('nonexistent.yml')
      expect { Cookstyle.config }.to raise_error(RuntimeError)
      line = log_output.string.lines.last
      entry = JSON.parse(line.sub(/\A\S+\s/, ''))
      expect(entry).to include('op' => 'config', 'status' => 'error')
      expect(entry['elapsed_ms']).to be_a(Numeric)
      expect(entry['reason']).to match(/not found/)
    end
  end

  describe '.debug? toggle' do
    it 'returns false when COOKSTYLE_DEBUG is not set' do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('COOKSTYLE_DEBUG').and_return(nil)
      expect(Cookstyle.debug?).to be false
    end

    it 'returns true when COOKSTYLE_DEBUG is set' do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('COOKSTYLE_DEBUG').and_return('1')
      expect(Cookstyle.debug?).to be true
    end

    it 'prints boot diagnostics to stderr when ON' do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('COOKSTYLE_DEBUG').and_return('1')
      expect { Cookstyle.config }.to output(/\[cookstyle debug\] v#{Regexp.escape(Cookstyle::VERSION)}/).to_stderr
    end

    it 'prints nothing to stderr when OFF' do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('COOKSTYLE_DEBUG').and_return(nil)
      expect { Cookstyle.config }.not_to output.to_stderr
    end
  end
end
