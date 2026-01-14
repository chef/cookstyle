# frozen_string_literal: true

module RuboCop
  module Cop
    module Chef
      module Helpers
        module ResourceMatcher
          def search_call?(node)
            node.send_type? && %i[search data_bag_search].include?(node.method_name)
          end

          def batchable_resource?(method_name)
            %i[package user group service].include?(method_name)
          end

          def includes_guard?(node)
            return false unless node.send_type?

            %i[not_if only_if].include?(node.method_name)
          end

          def node_is_chef_resource?(node, resource_name)
            node.block_type? &&
              node.send_node&.method_name == resource_name &&
              node.send_node&.receiver.nil?
          end
        end
      end
    end
  end
end
