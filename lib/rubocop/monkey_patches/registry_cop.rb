# frozen_string_literal: true

module RuboCop
  module Cop
    class Registry
      # we monkeypatch this warning to replace rubocop with cookstyle
      def print_warning(name, path)
        message = "#{path}: Warning: no department given for #{name}."
        message += ' Run `cookstyle -a --only Migration/DepartmentName` to fix.' if path.end_with?('.rb')
        warn message
      end
    end
  end
end
