# frozen_string_literal: true

module RuboCop
  # RuboCop >= 1.40.0 introduced a performance fast-path in CommentConfig that
  # skips directive parsing when the raw source does not contain the literal
  # string "rubocop".  Because Cookstyle also supports "# cookstyle:disable"
  # directives, we must also check for "cookstyle" so that those directives
  # are not silently ignored.
  class CommentConfig
    alias_method :original_initialize, :initialize

    def initialize(processed_source)
      original_initialize(processed_source)
      # Re-evaluate @no_directives to also consider "cookstyle" comments
      if @no_directives && processed_source.raw_source.include?('cookstyle')
        @no_directives = false
      end
    end
  end
end
