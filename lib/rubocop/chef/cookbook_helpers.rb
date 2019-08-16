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

        # bail out if we're not in the resource we care about or nil was passed (all resources)
        return unless resource_name.nil? || node.children.first.method?(resource_name.to_sym) # see if we're in the right resource

        if node.children[2] && node.children[2].begin_type? # nil would be an empty block. begin_type is the parent of our properties
          node.children[2].children.each do |property|
            extract_properties(property) do |p|
              yield(p) if p.method_name == property_name.to_sym
            end
          end
        end
      end

      private

      def extract_properties(node)
        yield(node) if node.send_type?
        if node.conditional?
          node.branches.each do |n|
            yield(n)
          end
        end
      end
    end
  end
end
