# Copyright:: 2025, Your Name
# Licensed under the Apache License, Version 2.0 (the "License");

module RuboCop
  module Cop
    module Chef
      module BestPractice
        class HardcodedPortNumbers < RuboCop::Cop::Base
          MSG = 'Avoid hardcoding port numbers. Use node attributes instead for flexibility and easy reconfiguration.'

          def on_int(node)
            # Flag integers that look like port numbers (1024-65535 for dynamic ports)
            # Skip very small numbers like 1, 2, 3 as they're unlikely to be ports
            return unless node.value.between?(1024, 65535)
            add_offense(node)
          end
        end
      end
    end
  end
end