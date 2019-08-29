module RuboCop
  module Chef
    # Common node helpers used for matching against Chef Infra Cookbooks
    module CookbookHelpers
      # Match particular properties within a resource
      #
      # @param [String] resource_name The name of the resource to match
      # @param [String] property_name The name of the property to match (or action)
      # @param [<Type>] node The rubocop ast node to search
      #
      # @yield
      #
      def match_property_in_resource?(resource_name, property_name, node)
        return unless node.block_type? # resources are blocks if they have properties
        return unless node.children.first.receiver.nil? # resource blocks don't have a receiver
        return if node.send_node.arguments.first.is_a?(RuboCop::AST::SymbolNode) # resources have a string name. resource actions have symbols

        # bail out if we're not in the resource we care about or nil was passed (all resources)
        return unless resource_name.nil? || node.children.first.method?(resource_name.to_sym) # see if we're in the right resource

        resource_block = node.children[2] # the 3rd child is the actual block in the resource
        return unless resource_block # nil would be an empty block
        if resource_block.begin_type? # if begin_type we need to iterate over the children
          resource_block.children.each do |resource_blk_child|
            extract_send_types(resource_blk_child) do |p|
              yield(p) if p.method_name == property_name.to_sym
            end
          end
        else # there's only a single property to check
          extract_send_types(resource_block) do |p|
            yield(p) if p.method_name == property_name.to_sym
          end
        end
      end

      private

      def extract_send_types(node)
        return if node.nil? # there are cases we can be passed an empty node
        case node.type
        when :send
          yield(node)
        when :while
          extract_send_types(node.body) { |t| yield(t) }
        when :if
          node.branches.each { |n| extract_send_types(n) { |t| yield(t) } }
        when :case
          node.when_branches.each { |n| extract_send_types(n.body) { |t| yield(t) } } # unless node.when_branches.nil?
          extract_send_types(node.else_branch) { |t| yield(t) } if node.else_branch
        end
      end
    end
  end
end
