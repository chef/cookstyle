# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::ChefModernize::OpensslRsaKeyResource, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using the openssl_rsa_key resource' do
    expect_offense(<<~RUBY)
      openssl_rsa_key '/etc/httpd/ssl/server.key' do
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The openssl_rsa_key resource was renamed to openssl_rsa_private_key in Chef Infra Client 14.0. The new resource name should be used.
        key_length 2048
      end
    RUBY

    expect_correction(<<~RUBY)
      openssl_rsa_private_key '/etc/httpd/ssl/server.key' do
        key_length 2048
      end
    RUBY
  end

  it "doesn't register an offense when using the openssl_rsa_private_key resource" do
    expect_no_offenses(<<~RUBY)
      openssl_rsa_private_key '/etc/httpd/ssl/server.key' do
        key_length 2048
      end
    RUBY
  end

  context 'with TargetChefVersion set to 13' do
    let(:config) { target_chef_version(13) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        openssl_rsa_key '/etc/httpd/ssl/server.key' do
          key_length 2048
        end
      RUBY
    end
  end
end
