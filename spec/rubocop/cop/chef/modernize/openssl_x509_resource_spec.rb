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

describe RuboCop::Cop::Chef::ChefModernize::OpensslX509Resource, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using the openssl_x509 resource' do
    expect_offense(<<~RUBY)
    openssl_x509 '/etc/httpd/ssl/mycert.pem' do
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The openssl_x509 resource was renamed to openssl_x509_certificate in Chef Infra Client 14.4. The new resource name should be used.
      common_name 'www.f00bar.com'
      org 'Foo Bar'
      org_unit 'Lab'
      country 'US'
    end
    RUBY

    expect_correction(<<~RUBY)
    openssl_x509_certificate '/etc/httpd/ssl/mycert.pem' do
      common_name 'www.f00bar.com'
      org 'Foo Bar'
      org_unit 'Lab'
      country 'US'
    end
    RUBY
  end

  it "doesn't register an offense when using the openssl_x509_certificate resource" do
    expect_no_offenses(<<~RUBY)
    openssl_x509_certificate '/etc/httpd/ssl/mycert.pem' do
      common_name 'www.f00bar.com'
      org 'Foo Bar'
      org_unit 'Lab'
      country 'US'
    end
    RUBY
  end

  context 'with TargetChefVersion set to 14.3' do
    let(:config) { target_chef_version(14.3) }

    it "doesn't register an offense" do
      expect_no_offenses(<<~RUBY)
        openssl_x509 '/etc/httpd/ssl/mycert.pem' do
          common_name 'www.f00bar.com'
          org 'Foo Bar'
          org_unit 'Lab'
          country 'US'
        end
      RUBY
    end
  end
end
