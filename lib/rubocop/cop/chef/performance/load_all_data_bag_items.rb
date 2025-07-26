module RuboCop
  module Cop
    module Chef
      module Performance
        # Flags use of broad data bag searches or loads that can cause excessive IO and memory use.
        #
        # @example
        #   # bad
        #   search(:users, '*:*')
        #
        #   # bad
        #   search(:my_bag, '')
        #
        #   # good
        #   search(:users, 'id:john')
        #
        class LoadAllDataBagItems < Base
          MSG = "Avoid loading all data bag items with broad or empty search queries which cause high IO and memory usage."

          def on_send(node)
            # Look for calls to :search or :data_bag_search
            return unless [:search, :data_bag_search].include?(node.method_name)

            # Extract the query argument - usually the 2nd argument for `search` and 3rd for `data_bag_search`
            query_arg = node.arguments[1] || node.arguments[2]

            if query_arg&.str_type?
              query_str = query_arg.value.to_s.strip
              if query_str.empty? || query_str == '*:*'
                add_offense(node.loc.expression, message: MSG)
              end
            end
          end
        end
      end
    end
  end
end
