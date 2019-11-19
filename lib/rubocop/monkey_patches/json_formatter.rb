# frozen_string_literal: true

module RuboCop
  module Formatter
    # This formatter formats the report data in JSON format.
    class JSONFormatter < BaseFormatter
      # We need to expose the correctable status until https://github.com/rubocop-hq/rubocop/pull/7514 is merged
      def hash_for_offense(offense)
        {
          severity: offense.severity.name,
          message: offense.message,
          cop_name: offense.cop_name,
          corrected: offense.corrected?,
          correctable: offense.status != :unsupported,
          location: hash_for_location(offense),
        }
      end
    end
  end
end
