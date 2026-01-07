# frozen_string_literal: true

module RuboCop
  module Cop
    module Chef
      class NoExecuteResource < Base
        MSG = 'Avoid using execute resource for package installation. Use package resource instead.'

        def on_block(node)
          return unless node.send_node.method_name == :execute

          source = node.source
          return unless source.match?(/apt-get|yum|dnf|brew/)

          add_offense(node)
        end
      end
    end
  end
end
