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
  # Tests for curl detection
  context 'when using curl' do
    it 'registers an offense for execute resource with curl command as name' do
      expect_offense(<<~RUBY)
        execute 'curl https://example.com/file.tar.gz -o /tmp/file.tar.gz'
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
      RUBY
    end

    it 'registers an offense for execute with curl in command property' do
      expect_offense(<<~RUBY)
        execute 'download_file' do
          command 'curl https://example.com/file.tar.gz -o /tmp/file.tar.gz'
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
        end
      RUBY
    end

    it 'registers an offense for bash resource with curl in code property' do
      expect_offense(<<~RUBY)
        bash 'download_script' do
          code 'curl https://example.com/install.sh -o /tmp/install.sh'
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
        end
      RUBY
    end

    it 'registers an offense for sh resource with curl' do
      expect_offense(<<~RUBY)
        sh 'curl -L https://example.com/app.tar.gz -o /tmp/app.tar.gz'
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
      RUBY
    end

    it 'registers an offense for curl with multiple flags' do
      expect_offense(<<~RUBY)
        execute 'download' do
          command 'curl -L -f -s https://example.com/file.tar.gz -o /tmp/file.tar.gz'
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
        end
      RUBY
    end

    it 'registers an offense for curl piped to bash' do
      expect_offense(<<~RUBY)
        execute 'curl https://example.com/install.sh | bash'
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
      RUBY
    end

    it 'registers an offense for curl with environment variables' do
      expect_offense(<<~RUBY)
        bash 'download_with_auth' do
          code 'curl -H "Authorization: Bearer $TOKEN" https://example.com/file -o /tmp/file'
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
        end
      RUBY
    end
  end

  # Tests for wget detection
  context 'when using wget' do
    it 'registers an offense for execute resource with wget command as name' do
      expect_offense(<<~RUBY)
        execute 'wget https://example.com/file.tar.gz -O /tmp/file.tar.gz'
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
      RUBY
    end

    it 'registers an offense for execute with wget in command property' do
      expect_offense(<<~RUBY)
        execute 'download_file' do
          command 'wget https://example.com/file.tar.gz -O /tmp/file.tar.gz'
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
        end
      RUBY
    end

    it 'registers an offense for bash resource with wget in code property' do
      expect_offense(<<~RUBY)
        bash 'download_script' do
          code 'wget https://example.com/app.tar.gz -O /tmp/app.tar.gz'
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
        end
      RUBY
    end

    it 'registers an offense for wget with quiet flag' do
      expect_offense(<<~RUBY)
        execute 'silent_download' do
          command 'wget -q https://example.com/file.tar.gz -O /tmp/file.tar.gz'
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
        end
      RUBY
    end

    it 'registers an offense for zsh resource with wget' do
      expect_offense(<<~RUBY)
        zsh 'wget https://example.com/script.sh -O /tmp/script.sh'
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
      RUBY
    end
  end

  # Tests for correct usage (no offense)
  context 'when using remote_file resource' do
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

  # Tests for non-curl/wget execute commands
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

    it 'does not register an offense for execute with cp command' do
      expect_no_offenses(<<~RUBY)
        execute 'copy_file' do
          command 'cp /tmp/source /tmp/dest'
        end
      RUBY
    end
  end

  # Tests for false positive prevention (curl/wget as substrings in non-command contexts)
  context 'when curl/wget appear as substrings in non-command names' do
    it 'does not register an offense for package names containing curl substring' do
      expect_no_offenses(<<~RUBY)
        execute 'install libcurl-dev package'
      RUBY
    end

    it 'does not register an offense for variable names containing wget substring' do
      expect_no_offenses(<<~RUBY)
        execute 'set_wget_proxy_env' do
          command 'export HTTP_PROXY=http://proxy:8080'
        end
      RUBY
    end

    it 'does not register an offense for paths containing curl substring' do
      expect_no_offenses(<<~RUBY)
        execute 'cleanup' do
          command 'rm -rf /var/cache/curlcache'
        end
      RUBY
    end
  end

  # Edge cases
  context 'edge cases' do
    it 'registers an offense for curl at the start of command' do
      expect_offense(<<~RUBY)
        execute 'curl -o /tmp/file https://example.com/file'
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
      RUBY
    end

    it 'registers an offense for full path to curl' do
      expect_offense(<<~RUBY)
        execute '/usr/bin/curl https://example.com/file -o /tmp/file'
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
      RUBY
    end

    it 'registers an offense for full path to wget' do
      expect_offense(<<~RUBY)
        execute '/usr/bin/wget https://example.com/file -O /tmp/file'
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
      RUBY
    end

    it 'registers an offense for powershell_script with curl' do
      expect_offense(<<~RUBY)
        powershell_script 'download' do
          code 'curl https://example.com/file.zip -o C:/temp/file.zip'
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `remote_file` resource instead of curl/wget in execute resources. The `remote_file` resource provides better idempotency, error handling, and checksum verification.
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

    it 'does not register an offense for file resource' do
      expect_no_offenses(<<~RUBY)
        file '/tmp/readme.txt' do
          content 'Download with curl or wget'
        end
      RUBY
    end
  end
end
