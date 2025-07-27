# frozen_string_literal: true

module RuboCop
  module Cop
    module Chef
      class DeprecatedNotIfOnlyIf < Base
        MSG = "Avoid using string commands in 'not_if' or 'only_if'. Use Ruby blocks instead for reliability."

        def_node_matcher :deprecated_guard?, <<-PATTERN
          (send _ {:not_if :only_if} (str _))
        PATTERN

        def on_send(node)
          return unless deprecated_guard?(node)

          add_offense(node, message: MSG)
        end
      end
    end
  end
end