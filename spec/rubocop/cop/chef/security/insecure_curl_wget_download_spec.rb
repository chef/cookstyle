# frozen_string_literal: true
#
# Copyright:: 2024-2026, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Security::InsecureCurlWgetDownload, :config do
  #
  # ==================== curl -k tests ====================
  #
  it 'registers an offense when using execute with curl -k' do
    expect_offense(<<~RUBY)
      execute 'curl -k https://example.com/file.tar.gz -o /tmp/file.tar.gz'
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use curl/wget with insecure flags [...]
    RUBY
  end

  it 'registers an offense when using curl -k at the end of command' do
    expect_offense(<<~RUBY)
      execute 'curl https://example.com/file.tar.gz -k '
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use curl/wget with insecure flags [...]
    RUBY
  end

  it 'registers an offense when using command property with curl -k' do
    expect_offense(<<~RUBY)
      execute 'download' do
        command 'curl -k https://example.com/script.sh'
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use curl/wget with insecure flags [...]
      end
    RUBY
  end

  it 'registers an offense for curl with multiple flags including -k' do
    expect_offense(<<~RUBY)
      execute 'curl -s -k -L https://example.com/file.sh'
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use curl/wget with insecure flags [...]
    RUBY
  end

  #
  # ==================== curl --insecure tests ====================
  #
  it 'registers an offense when using curl --insecure' do
    expect_offense(<<~RUBY)
      execute 'curl --insecure https://example.com/install.sh | bash'
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use curl/wget with insecure flags [...]
    RUBY
  end

  it 'registers an offense when using bash resource with curl --insecure' do
    expect_offense(<<~RUBY)
      bash 'install_app' do
        code 'curl --insecure https://example.com/app.sh | bash'
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use curl/wget with insecure flags [...]
      end
    RUBY
  end

  it 'registers an offense when using curl --insecure in middle of command' do
    expect_offense(<<~RUBY)
      execute 'curl --insecure -L https://example.com/file.tar.gz -o /tmp/file.tar.gz'
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use curl/wget with insecure flags [...]
    RUBY
  end

  #
  # ==================== wget --no-check-certificate tests ====================
  #
  it 'registers an offense when using wget --no-check-certificate' do
    expect_offense(<<~RUBY)
      execute 'wget --no-check-certificate https://example.com/file.tar.gz'
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use curl/wget with insecure flags [...]
    RUBY
  end

  it 'registers an offense when using bash with wget --no-check-certificate' do
    expect_offense(<<~RUBY)
      bash 'download' do
        code 'wget --no-check-certificate https://example.com/archive.zip -O /tmp/archive.zip'
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use curl/wget with insecure flags [...]
      end
    RUBY
  end

  it 'registers an offense when using sh resource with insecure wget' do
    expect_offense(<<~RUBY)
      sh 'fetch_package' do
        code 'wget --no-check-certificate https://example.com/pkg.deb'
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use curl/wget with insecure flags [...]
      end
    RUBY
  end

  #
  # ==================== Multiple shell interpreters ====================
  #
  it 'registers an offense when using zsh resource with curl -k' do
    expect_offense(<<~RUBY)
      zsh 'download_file' do
        code 'curl -k https://example.com/file.sh'
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use curl/wget with insecure flags [...]
      end
    RUBY
  end

  #
  # ==================== Negative tests - NO false positives ====================
  #
  it 'does not register an offense for secure curl commands' do
    expect_no_offenses(<<~RUBY)
      execute 'curl https://example.com/file.tar.gz -o /tmp/file.tar.gz'
    RUBY
  end

  it 'does not register an offense for secure wget commands' do
    expect_no_offenses(<<~RUBY)
      execute 'wget https://example.com/file.tar.gz -O /tmp/file.tar.gz'
    RUBY
  end

  it 'does not register an offense for execute resources without curl/wget' do
    expect_no_offenses(<<~RUBY)
      execute 'apt-get update'
    RUBY
  end

  it 'does not register an offense for bash resources without insecure flags' do
    expect_no_offenses(<<~RUBY)
      bash 'build_app' do
        code 'make && make install'
      end
    RUBY
  end

  it 'does not register an offense for curl with other flags' do
    expect_no_offenses(<<~RUBY)
      execute 'curl -L https://example.com/file.tar.gz -o /tmp/file.tar.gz'
    RUBY
  end

  it 'does not register an offense for curl with -K (config file flag, uppercase)' do
    expect_no_offenses(<<~RUBY)
      execute 'curl -K /etc/curlrc https://example.com/file.tar.gz'
    RUBY
  end

  #
  # ==================== CRITICAL: False positive prevention tests ====================
  #
  it 'does not register an offense for words containing -k like check-kernel' do
    expect_no_offenses(<<~RUBY)
      execute 'check-kernel-version' do
        command '/usr/bin/check-kernel --status'
      end
    RUBY
  end

  it 'does not register an offense for backup command that contains -k substring' do
    expect_no_offenses(<<~RUBY)
      execute 'backup-data' do
        command 'backup-tool --keep-old'
      end
    RUBY
  end

  it 'does not register an offense for package names containing k' do
    expect_no_offenses(<<~RUBY)
      execute 'install-package' do
        command 'yum install -y check-mk-agent'
      end
    RUBY
  end

  it 'does not register an offense for commands with -key flag' do
    expect_no_offenses(<<~RUBY)
      execute 'generate_key' do
        command 'openssl genrsa -key /tmp/mykey.pem'
      end
    RUBY
  end

  it 'does not register an offense for insecure word in non-curl context' do
    expect_no_offenses(<<~RUBY)
      execute 'check_insecure_files' do
        command 'find /tmp -name "*.insecure" -delete'
      end
    RUBY
  end

  it 'does not register an offense for wget without insecure flags' do
    expect_no_offenses(<<~RUBY)
      execute 'wget -q https://example.com/file.tar.gz'
    RUBY
  end

  it 'does not register an offense for non-curl command with -k flag' do
    expect_no_offenses(<<~RUBY)
      execute 'grep -k pattern /var/log/messages'
    RUBY
  end

  it 'does not register an offense for curl-like words' do
    expect_no_offenses(<<~RUBY)
      execute 'curlew-backup -k /tmp/data'
    RUBY
  end

  it 'does not register an offense for check-certificate in non-wget context' do
    expect_no_offenses(<<~RUBY)
      execute 'openssl verify --no-check-certificate-revocation cert.pem'
    RUBY
  end
end
