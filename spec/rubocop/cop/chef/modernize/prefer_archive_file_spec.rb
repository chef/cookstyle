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

describe RuboCop::Cop::Chef::Modernize::PreferArchiveFile, :config do
  let(:msg) { 'Use the `archive_file` resource instead of shell-based extraction (`tar`, `unzip`, etc.). Native resources handle idempotence and multiple formats natively.' }

  # ==========================================================================
  # Offense: execute with tar
  # ==========================================================================
  context 'when using execute with tar' do
    it 'registers an offense for execute with tar extract command' do
      expect_offense(<<~RUBY)
        execute 'tar -xzf /tmp/app.tar.gz -C /opt'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end

    it 'registers an offense for execute with tar in command property' do
      expect_offense(<<~RUBY)
        execute 'extract_archive' do
          command 'tar -xvf /tmp/package.tar -C /usr/local'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end

    it 'registers an offense for tar with verbose flags' do
      expect_offense(<<~RUBY)
        execute 'extract' do
          command 'tar -xzvf /tmp/archive.tar.gz -C /opt/app'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end

    it 'registers an offense for tar create command' do
      expect_offense(<<~RUBY)
        execute 'tar -cvf /tmp/backup.tar /etc/config'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end
  end

  # ==========================================================================
  # Offense: bash with unzip
  # ==========================================================================
  context 'when using bash with unzip' do
    it 'registers an offense for bash with unzip in code property' do
      expect_offense(<<~RUBY)
        bash 'unzip_file' do
          code 'unzip -o /tmp/app.zip -d /opt/app'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end

    it 'registers an offense for bash with unzip and quiet flag' do
      expect_offense(<<~RUBY)
        bash 'extract' do
          code 'unzip -q /tmp/files.zip -d /var/data'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end
  end

  # ==========================================================================
  # Offense: gunzip and gzip
  # ==========================================================================
  context 'when using gunzip or gzip' do
    it 'registers an offense for execute with gunzip' do
      expect_offense(<<~RUBY)
        execute 'gunzip /tmp/data.gz'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end

    it 'registers an offense for bash with gzip' do
      expect_offense(<<~RUBY)
        bash 'compress_logs' do
          code 'gzip /var/log/app.log'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end

    it 'registers an offense for gunzip with keep flag' do
      expect_offense(<<~RUBY)
        execute 'decompress' do
          command 'gunzip -k /tmp/archive.gz'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end
  end

  # ==========================================================================
  # Offense: 7z commands
  # ==========================================================================
  context 'when using 7z' do
    it 'registers an offense for execute with 7z extract' do
      expect_offense(<<~RUBY)
        execute '7z x /tmp/archive.7z -o/opt/app'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end

    it 'registers an offense for bash with 7z' do
      expect_offense(<<~RUBY)
        bash 'extract_7z' do
          code '7z x /tmp/package.7z -oC:/app'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end

    it 'registers an offense for 7z create archive' do
      expect_offense(<<~RUBY)
        execute '7z a /tmp/backup.7z /etc/config'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end
  end

  # ==========================================================================
  # Piped commands (detected but not auto-correctable)
  # ==========================================================================
  context 'piped archive commands (detected but not auto-correctable)' do
    it 'registers an offense for curl piped to tar' do
      expect_offense(<<~RUBY)
        execute 'curl -sL https://example.com/app.tar.gz | tar -xz -C /opt'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end

    it 'registers an offense for wget piped to gunzip' do
      expect_offense(<<~RUBY)
        bash 'download_and_extract' do
          code 'wget -qO- https://example.com/data.gz | gunzip > /tmp/data'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end
  end

  # ==========================================================================
  # Correct usage: archive_file (no offense)
  # ==========================================================================
  context 'when using archive_file resource (correct pattern)' do
    it 'does not register an offense for archive_file resource' do
      expect_no_offenses(<<~RUBY)
        archive_file '/tmp/app.tar.gz' do
          destination '/opt'
        end
      RUBY
    end

    it 'does not register an offense for archive_file with options' do
      expect_no_offenses(<<~RUBY)
        archive_file '/tmp/package.zip' do
          destination '/opt/app'
          overwrite true
          owner 'root'
          group 'root'
        end
      RUBY
    end

    it 'does not register an offense for archive_file with strip_components' do
      expect_no_offenses(<<~RUBY)
        archive_file '/tmp/app.tar.gz' do
          destination '/opt/app'
          strip_components 1
        end
      RUBY
    end
  end

  # ==========================================================================
  # False positive prevention: substrings
  # ==========================================================================
  context 'false positive prevention - archive commands as substrings' do
    it 'does not register an offense for tarball in resource name' do
      expect_no_offenses(<<~RUBY)
        execute 'download_tarball' do
          command 'cp /mnt/tarball_source.tar.gz /tmp/app.tar.gz'
        end
      RUBY
    end

    it 'does not register an offense for unzipped in path' do
      expect_no_offenses(<<~RUBY)
        execute 'copy_files' do
          command 'cp -r /tmp/unzipped_files /opt/app'
        end
      RUBY
    end

    it 'does not register an offense for gzipped in filename' do
      expect_no_offenses(<<~RUBY)
        execute 'move_file' do
          command 'mv /tmp/gzipped_data.txt /opt/data.txt'
        end
      RUBY
    end

    it 'does not register an offense for guitar (contains tar)' do
      expect_no_offenses(<<~RUBY)
        execute 'install guitar app' do
          command 'apt-get install -y guitar-tuner'
        end
      RUBY
    end

    it 'does not register an offense for stargazer (contains tar)' do
      expect_no_offenses(<<~RUBY)
        execute 'configure stargazer' do
          command '/opt/stargazer/configure'
        end
      RUBY
    end
  end

  # ==========================================================================
  # Non-archive commands (no offense)
  # ==========================================================================
  context 'when execute resource does not use archive commands' do
    it 'does not register an offense for execute with other commands' do
      expect_no_offenses(<<~RUBY)
        execute 'apt-get update'
      RUBY
    end

    it 'does not register an offense for execute with cp command' do
      expect_no_offenses(<<~RUBY)
        execute 'copy_config' do
          command 'cp /tmp/config /etc/app/config'
        end
      RUBY
    end

    it 'does not register an offense for bash with make command' do
      expect_no_offenses(<<~RUBY)
        bash 'build_app' do
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

    it 'does not register an offense for file resource mentioning tar' do
      expect_no_offenses(<<~RUBY)
        file '/tmp/readme.txt' do
          content 'Extract with tar -xzf'
        end
      RUBY
    end
  end

  # ==========================================================================
  # Additional shell resources
  # ==========================================================================
  context 'additional shell resources' do
    it 'registers an offense for sh resource with tar' do
      expect_offense(<<~RUBY)
        sh 'tar -xzf /tmp/data.tar.gz -C /var/data'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end

    it 'registers an offense for zsh resource with unzip' do
      expect_offense(<<~RUBY)
        zsh 'unzip /tmp/files.zip -d /opt'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    end

    it 'registers an offense for powershell_script with 7z' do
      expect_offense(<<~RUBY)
        powershell_script 'extract_archive' do
          code '7z x C:/temp/archive.7z -oC:/app'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
        end
      RUBY
    end
  end
end
