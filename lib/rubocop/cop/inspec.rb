# frozen_string_literal: true

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
