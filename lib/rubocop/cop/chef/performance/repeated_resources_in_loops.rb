require_relative '../helpers/resource_matcher'

module RuboCop
  module Cop
    module Chef
      module Performance
        class RepeatedResourcesInLoops < Base
          include RuboCop::Cop::Chef::Helpers::ResourceMatcher

          MSG = 'Avoid creating resources inside loops when the resource supports arrays: use batched or bulk resources for efficiency.'

          def on_block(node)
            return unless node.send_node.method_name == :each

            # Get the body of the block, which could be a single node or a begin node (multiple statements)
            body = node.body
            statements = body.begin_type? ? body.children : [body]

            statements.compact.each do |stmt|
              next unless stmt.send_type?

              method = stmt.method_name
              add_offense(stmt.loc.expression, message: MSG) if batchable_resource?(method) && stmt.receiver.nil?
            end
          end
        end
      end
    end
  end
end
