#
# Copyright:: 2019, Chef Software, Inc.
# Author:: Tim Smith (<tsmith@chef.io>)
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
module RuboCop
  module Cop
    module Chef
      module ChefModernize
        # The openssl_x509 resource was renamed to openssl_x509_certificate in Chef Infra Client 14.4.
        # The new resource name should be used.
        #
        #   # bad
        #   openssl_x509 '/etc/httpd/ssl/mycert.pem' do
        #     common_name 'www.f00bar.com'
        #     org 'Foo Bar'
        #     org_unit 'Lab'
        #     country 'US'
        #   end
        #
        #   # good
        #   openssl_x509_certificate '/etc/httpd/ssl/mycert.pem' do
        #     common_name 'www.f00bar.com'
        #     org 'Foo Bar'
        #     org_unit 'Lab'
        #     country 'US'
        #   end
        #
        class OpensslX509Resource < Cop
          MSG = 'The openssl_x509 resource was renamed to openssl_x509_certificate in Chef Infra Client 14.4. The new resource name should be used.'.freeze

          def on_send(node)
            add_offense(node, location: :expression, message: MSG, severity: :refactor) if node.method_name == :openssl_x509
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, node.source.gsub(/^openssl_x509/, 'openssl_x509_certificate'))
            end
          end
        end
      end
    end
  end
end
