# frozen_string_literal: true
#
# Copyright:: Copyright 2021-2022, Chef Software Inc.
# Author:: Tim Smith (<tsmith84@gmail.com>)
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

describe RuboCop::Cop::Chef::Security::SshPrivateKey, :config do
  it 'registers an offense setting an attribute to an RSA private key' do
    expect_offense(<<~RUBY)
      default['jenkins-server']['dev_mode']['security']['private_key'] =
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not include plain text SSH private keys in your cookbook code. This sensitive data should be fetched from secrets management systems so that secrets are not uploaded in plain text to the Chef Infra Server or committed to source control systems.
      '-----BEGIN RSA PRIVATE KEY-----
      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
      -----END RSA PRIVATE KEY-----'
    RUBY
  end

  it 'registers an offense setting an attribute to an EC private key' do
    expect_offense(<<~RUBY)
      default['jenkins-server']['dev_mode']['security']['private_key'] =
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not include plain text SSH private keys in your cookbook code. This sensitive data should be fetched from secrets management systems so that secrets are not uploaded in plain text to the Chef Infra Server or committed to source control systems.
      '-----BEGIN EC PRIVATE KEY-----
      MIIJJwIBAAKCAgEA59t0+NWVEuT1YZJ7OPpH9JxaB9lKMR5aXOTt8wBTrLAUW1XH
      xlXUJPTGEgPLqXlUK9ad3HIDnQ4r6WMfgoNqEwE50ByQh4oc7njMbCMZlTpu2+/D
      BfCFiF1s3cbGTG4yJ4UxbhAuCNsFoNQQsaLbVs6oAy2Le+dynVtfg+4uzGiSAQeL
      CfTy8dzIB57E4gAeQQyFbZCVDNqt1E7M1d0TGvIG29EJAo2pk8qSqHk4zP600ECy
      Dh+/cr1Ur9hUZXBs8KbAJ2U+Ok/SvgMqxHAJR+RKNgZPdsW3B4Rp6BpczgQIMaiy
      d7+qQ1Z1Hn0Yqo8WezfrT224c3mg9KVkHvfRpigLgTHxX2w8wP0OwyIUUPHXVbPT
      pe4jTadcZMZLIDtRnpMMW6wwZCDuKJcRMwEwi5Lwyy0RENg7VnjkDeT9FNx0eati
      n/KgpeL54g3O9kCU8ROChtih64F4rhZ96aHPZOkZCNO+p02NDeZlynf5RM3vt8Vc
      QQZx3v2tIm1htPBTLoeEw5M1+OfT1tMSFpl1bdjgrYrGTkrNCRuxNEKOspiBXB6X
      0Trx/xWMQ6K1iXb0attytmaJPe2/N44e1uxYxJ6ycsk/TomiXFt31HKyb5b78a4w
      BZnkYlIF55kqnwkS7A4kUOJoH5ye3WWEg/kWEooojm/u/UyU4ocPow6AAzkCAwEA
      AQKCAgApmPf9hORABY/4t30gFdc/DaYhblyfP2Da9b+zL0XT36tnT5aOAOwUzU2U
      AdZSS5BMZS7hVBtN3DMIpl4K3mTzj+69ZcKQbrkOF+IlLI70dQ1arEODF0n90zUq
      /PSq1cJt0Lmzk3eO4yy5VBLCrANKKb1/BHbX/ghULwaN9veyeLhpMt9BJA9KUWAZ
      7eRI39iNtx9hLuVu7vTs+E5LuGQrG20blv9U0/GusFNrooQMU05BZroLSqrgfRNq
      kRdjM6535pLm/oURlSysJolPwQIJQe4Gj09GceaKlLkjiUdJNvP5ZNjQHzT+684L
      cEoyn4VbCgdPstG69gFooxu5aqDUJTsmPpK1qspfNnizyDO4tYF2Hu89dfyqrcWZ
      oYpdO2yVttTSNa1XHY1i1DwvJbDal5UZf1atre0qCHwnsVjY5kYs/9ObV8jbLri/
      /M97iH4oH+n7ltT3OweLiNKhgtJAXkQaWmZ/sTGjmNC5kw2df7De3OJ9G0XmhWEU
      EjB+hC3HvjfwiVycaJ/Q0INLhBQtuBzGs1ZQwSz37Vw0v5HB3zihSD8eUoFCFgkS
      5wX+3oXTCSWXoBuc4r8IhIIpWg9G8NedkV3zLRDN5Glw4ViU8tgQ54nCCAlgkErg
      N0AvnTEjS/tdviL4IU30tN+TRCxAQbRQYNGQRyqiDK0cCjVlAQKCAQEA+lkCiLSc
      J7hE9veTsh7eVnnOFKwsiyIXRT78T5wYaWwsEJzU+rMjyA5uVXXVhX0kWyH74Ii9
      KQQgQMJZXwB/8z9LDEOfNrej4r69CjS8oVePDjbY2qhHbLgwvIotCuZiU+UHENfh
      J4aOX5vq7GkAGXB/OqrRT3Or290YTzUhqC4C5o6TZOIK1oM6TLGWXY67JX0SZfLc
      sXSNB6uonD4aY3MTUVchANB4mrm9uRU8fLyIZVeutIpYDD346T80brwUXwwSzioN
      zvYf50hM1aqUFGhWK8LznU9j3DCB5KAtOZUhXHCEqukgYaw7Z+BXFEK4Cf3+VOel
      eh8diwV1Ad49MQKCAQEA7ReS3zZQGjwRwY2I29SCCeDefCh3kx51xmR8eCoSRnhB
      cnyRIhsgq69tlQRHMOQJXpHHq0hAE3skgRCs3s5rNtMij0HxoyD8Qx4KjGNlCWin
      KxcWnNCIhG1v+aCaM3WA2f5jxQ9mOdpTlHRi4ZUL2cNmZljo8uOC4No9sN1DzED0
      JxYtXaLWkfD/zMlbMOQW+mZgDRJoVcUmBsf4hEBzm7k6+p4fiSyHfybOMeQaMV/e
      Ta6sebV1s5xCLl+SjGdTBD4epGVR6EPAUxsqin4IHMpOI5IuCLNJwahGFsToDFnF
      AkoTr0W60L123QUlik5yBA0UzjeF9raJpeIEFkSEiQKCAQBIDEfTag8qyzhlzxid
      gY7BWmq5vldPb289CYR5sNXBuVTxLwGIaPfaQnT0eWYK9dn5tE0V8KRn4n0ZxhUM
      Z0triQKjM+7lQ3KR9gzXnBfRYy6Ti6tbOmTb4CJ+kFGoOmd/94DSEx8EThA5adjx
      UsKpj5u+GZ0FfaevLfEqEoNuMFe7XLsEpJ0z4S5tFgrNQB+SCW27E2r6Uy2nUHrF
      BIZ5qoubtDSWVGjxNpVoZ7kxuNyUNejcopf2Zft1vS/s0ooWVJYw6R9yOZky6bbb
      Iy1cti5eh8uusUNvAjLPxl1dnhKs1OEJgvBDy9qI6aKF/TGUBpoke0o/XCcXdGmZ
      MQlxAoIBADulDY7X1Aj1iaX+nCppaJlhl7b2WzaImCpjxyhXtSdDQ3uwuLYyyuJG
      DLRLUjmLdIv08p01XOFJvmI1treKiFBPh0cw2MAoIS4lVZQBwT4/tKZTdZ3XnDBs
      c5oB/Cjr65FrvN+rQxVUxmf3a5TCcSvES3N99IR+FcPJQ3HGCDNPN9zJaHpA5+fp
      EAENusIu71TpAkrnkZXaNfnIvs1OhYbsb1jzBI32xNOJCKBmeOxo6Lz0L3Gi48xe
      iAuwgWaO68SKeBz1XEipGq4NjIMwt4u+nS+3q5sGt4xfb9p0iMfqoXQ0/ITAbwHq
      WAe8Lrh/iZFZVR2XvDzXqQMxO8P6UrkCggEAcIAxZEDMl3D2fs8/6rC0/Bf5nUXG
      b19Y9xuCFIr3cAV5+l4bT5+rjcpS57w+RD0oj3qzJYB4NdY2PbA4utp9fWt+jHDW
      EDDBp0i/f8M08j07J2//A2agBpH3sLZ0H+5bO/nEQdIFeivVrk0N+ifVSIq1uHMl
      0OyEQqeg0yt4xKpj747/hpd8v366EAuleT8+g5A1RkiJdgx+hLc9Ob/k8V+p+1be
      LXLgeSQQBfnbBz/uAHxaob97sT2LgUJQelRTl17ZetEklIMObKgHBom4lZHW3RXN
      0r6JSDHSi7AXmzvWtceE9XmY5d6AwHHO1J38AK3TQL/PAn/WU1BbK+o2pg==
      -----END EC PRIVATE KEY-----'
    RUBY
  end

  it 'registers an offense setting a property to an RSA private key' do
    expect_offense(<<~RUBY)
      file '/Users/bob_bobberson/.ssh/id_rsa' do
        content '-----BEGIN RSA PRIVATE KEY-----
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not include plain text SSH private keys in your cookbook code. This sensitive data should be fetched from secrets management systems so that secrets are not uploaded in plain text to the Chef Infra Server or committed to source control systems.
          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
          -----END RSA PRIVATE KEY-----'
        mode '600'
      end
    RUBY
  end

  it 'does not register an offense with an RSA public key' do
    expect_no_offenses(<<~RUBY)
      default['jenkins-server']['dev_mode']['security']['private_key'] = 'ssh-rsa foo/bar/baz== tsmith84@gmail.com'
    RUBY
  end
end
