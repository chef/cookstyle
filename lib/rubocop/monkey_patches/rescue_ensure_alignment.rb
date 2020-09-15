# frozen_string_literal: true
module RuboCop
  module Cop
    module Layout
      class RescueEnsureAlignment < Base
        # @TODO remove this monkeypatch after we upgrade from RuboCop 0.91.0
        def begin_end_alignment_style
          # FIXME: Workaround for pending status for `Layout/BeginEndAlignment` cop
          #        When RuboCop 1.0 is released, please replace it with the following condition.
          #
          # config.for_cop('Layout/BeginEndAlignment')['Enabled'] &&
          #   config.for_cop('Layout/BeginEndAlignment')['EnforcedStyleAlignWith']
          if config.for_all_cops['NewCops'] == 'enable' ||
             config.for_cop('Layout/BeginEndAlignment')['Enabled'] &&
             config.for_cop('Layout/BeginEndAlignment')['Enabled'] != 'pending'
            config.for_cop('Layout/BeginEndAlignment')['EnforcedStyleAlignWith']
          end
        end
      end
    end
  end
end