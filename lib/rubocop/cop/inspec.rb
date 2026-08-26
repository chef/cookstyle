# frozen_string_literal: true
#
# Copyright:: 2026, Tim Smith
# Author:: Tim Smith (<tsmith84@proton.me>)
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
    # Registers the InSpec cops for lazy loading. See `rubocop/cop/chef` for details.
    module InSpec
      # The InSpec/Deprecations department.
      module Deprecations
        extend LazyLoader

        register_cop :AttributeDefault, "#{__dir__}/inspec/deprecation/attribute_default"
        register_cop :AttributeHelper, "#{__dir__}/inspec/deprecation/attribute_helper"
      end
    end
  end
end
