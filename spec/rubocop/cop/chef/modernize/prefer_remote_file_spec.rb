# frozen_string_literal: true
#
# Copyright:: 2024-2026, Chef Software, Inc.
# Author:: Suhas Kumar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require 'spec_helper'

describe RuboCop::Cop::Chef::Modernize::PreferRemoteFile, :config do
  let(:msg) { 'Use the `remote_file` resource instead of `curl` or `wget`. Native resources ensure idempotence, support retries, and handle permissions correctly.' }

  # ==========================================================================
  # Offense: execute resource name contains curl/wget
  # ==========================================================================
  context 'when using execute with curl' do
    it 'registers an offense for execute resource with curl command' do
      expect_offense(<<~RUBY)
        execute 'curl https://example.com/file.tar.gz -o /tmp/file.tar.gz'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end

    it 'registers an offense for execute with curl in command property' do
      expect_offense(<<~RUBY)
        execute 'download_file' do
          command 'curl https://example.com/file.tar.gz -o /tmp/file.tar.gz'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end

    it 'registers an offense for curl with multiple flags' do
      expect_offense(<<~RUBY)
        execute 'download' do
          command 'curl -L -f -s https://example.com/file.tar.gz -o /tmp/file.tar.gz'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end
  end

  # ==========================================================================
  # Offense: bash block with wget
  # ==========================================================================
  context 'when using bash with wget' do
    it 'registers an offense for bash resource with wget in code property' do
      expect_offense(<<~RUBY)
        bash 'download_script' do
          code 'wget https://example.com/app.tar.gz -O /tmp/app.tar.gz'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end

    it 'registers an offense for bash resource with wget and flags' do
      expect_offense(<<~RUBY)
        bash 'fetch_file' do
          code 'wget -q --progress=bar https://example.com/archive.zip -O /tmp/archive.zip'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end
  end

  # ==========================================================================
  # False positive prevention: curl/wget as substrings
  # ==========================================================================
  context 'false positive prevention - curl/wget as substrings' do
    it 'does not register an offense for libcurl-dev (curl embedded in word)' do
      expect_no_offenses(<<~RUBY)
        execute 'install libcurl-dev package'
      RUBY
    end

    it 'does not register an offense for curlcache path (curl embedded in word)' do
      expect_no_offenses(<<~RUBY)
        execute 'cleanup' do
          command 'rm -rf /var/cache/curlcache'
        end
      RUBY
    end

    it 'does not register an offense for wgetrc path (wget embedded in word)' do
      expect_no_offenses(<<~RUBY)
        execute 'show_wget_config' do
          command 'cat /etc/wgetrc'
        end
      RUBY
    end

    it 'does not register an offense for scurl (curl as suffix)' do
      expect_no_offenses(<<~RUBY)
        execute 'run_scurl' do
          command 'scurl https://example.com'
        end
      RUBY
    end
  end

  # ==========================================================================
  # Edge case: curl | bash (detected but no autocorrect)
  # ==========================================================================
  context 'edge case: curl | bash patterns (detected but not auto-correctable)' do
    it 'registers an offense for curl piped to bash' do
      expect_offense(<<~RUBY)
        execute 'curl https://example.com/install.sh | bash'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end

    it 'registers an offense for curl piped to sh' do
      expect_offense(<<~RUBY)
        execute 'curl -sL https://example.com/setup.sh | sh'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end

    it 'registers an offense for wget piped to bash' do
      expect_offense(<<~RUBY)
        execute 'wget -qO- https://example.com/install.sh | bash'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end
  end

  # ==========================================================================
  # Additional shell resources
  # ==========================================================================
  context 'additional shell resources' do
    it 'registers an offense for sh resource with curl' do
      expect_offense(<<~RUBY)
        sh 'curl -L https://example.com/app.tar.gz -o /tmp/app.tar.gz'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end

    it 'registers an offense for zsh resource with wget' do
      expect_offense(<<~RUBY)
        zsh 'wget https://example.com/script.sh -O /tmp/script.sh'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end

    it 'registers an offense for powershell_script with curl' do
      expect_offense(<<~RUBY)
        powershell_script 'download' do
          code 'curl https://example.com/file.zip -o C:/temp/file.zip'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end

    it 'registers an offense for curl with authentication headers' do
      expect_offense(<<~RUBY)
        bash 'download_with_auth' do
          code 'curl -H "Authorization: Bearer $TOKEN" https://example.com/file -o /tmp/file'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end
  end

  # ==========================================================================
  # Correct usage: remote_file (no offense)
  # ==========================================================================
  context 'when using remote_file resource (correct pattern)' do
    it 'does not register an offense for remote_file resource' do
      expect_no_offenses(<<~RUBY)
        remote_file '/tmp/file.tar.gz' do
          source 'https://example.com/file.tar.gz'
        end
      RUBY
    end

    it 'does not register an offense for remote_file with checksum' do
      expect_no_offenses(<<~RUBY)
        remote_file '/tmp/file.tar.gz' do
          source 'https://example.com/file.tar.gz'
          checksum 'abc123def456'
        end
      RUBY
    end

    it 'does not register an offense for remote_file with multiple properties' do
      expect_no_offenses(<<~RUBY)
        remote_file '/tmp/app.tar.gz' do
          source 'https://example.com/app.tar.gz'
          owner 'root'
          group 'root'
          mode '0644'
          checksum 'sha256checksum'
        end
      RUBY
    end
  end

  # ==========================================================================
  # Non-curl/wget commands (no offense)
  # ==========================================================================
  context 'when execute resource does not use curl or wget' do
    it 'does not register an offense for execute with other commands' do
      expect_no_offenses(<<~RUBY)
        execute 'apt-get update'
      RUBY
    end

    it 'does not register an offense for execute with tar command' do
      expect_no_offenses(<<~RUBY)
        execute 'extract' do
          command 'tar -xzf /tmp/file.tar.gz -C /opt'
        end
      RUBY
    end

    it 'does not register an offense for bash with other commands' do
      expect_no_offenses(<<~RUBY)
        bash 'configure' do
          code './configure && make && make install'
        end
      RUBY
    end

    it 'does not register an offense for non-shell resources' do
      expect_no_offenses(<<~RUBY)
        template '/etc/config' do
          source 'config.erb'
        end
      RUBY
    end

    it 'does not register an offense for file resource mentioning curl' do
      expect_no_offenses(<<~RUBY)
        file '/tmp/readme.txt' do
          content 'Download with curl or wget'
        end
      RUBY
    end
  end
end
