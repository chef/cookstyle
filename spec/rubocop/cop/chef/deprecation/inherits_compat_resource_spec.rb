# frozen_string_literal: true

#
# Copyright:: 2019, Chef Software, Inc.
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

describe RuboCop::Cop::Chef::Deprecations::ResourceInheritsFromCompatResource, :config do
  it 'registers an offense when a HWRP inherits from ChefCompat::Resource' do
    expect_offense(<<~RUBY)
      class AptUpdate < ChefCompat::Resource
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ HWRP style resource should inherit from the 'Chef::Resource' class and not the 'ChefCompat::Resource' class from the deprecated compat_resource cookbook.
        # some resource code
      end
    RUBY

    expect_correction(<<~RUBY)
      class AptUpdate < Chef::Resource
        # some resource code
      end
    RUBY
  end

  it 'does not register an offense when a HWRP inherits from Chef::Resource' do
    expect_no_offenses(<<~RUBY)
      class AptUpdate < Chef::Resource
        # some resource code
      end
    RUBY
  end
end
