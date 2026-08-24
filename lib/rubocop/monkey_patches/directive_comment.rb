# frozen_string_literal: true
module RuboCop
  # we're monkey patching the directive marker to allow for "cookstyle: disable whatever"
  # in addition to the "rubocop: disable whatever" that comes with RuboCop.
  #
  # Everything below the marker is rebuilt exactly the way RuboCop builds it, from
  # RuboCop's own constants, so that directive modes added upstream (push, pop,
  # disable-next, todo-next, ...) keep working here without another patch.
  class DirectiveComment
    remove_const(:DIRECTIVE_MARKER_PATTERN)
    DIRECTIVE_MARKER_PATTERN = '# (?:rubocop|cookstyle) : '

    remove_const(:DIRECTIVE_MARKER_REGEXP)
    DIRECTIVE_MARKER_REGEXP = Regexp.new(DIRECTIVE_MARKER_PATTERN.gsub(' ', '\s*'))

    remove_const(:DIRECTIVE_HEADER_PATTERN)
    DIRECTIVE_HEADER_PATTERN = "#{DIRECTIVE_MARKER_PATTERN}((?:#{MODES_PATTERN}))\\b"

    remove_const(:DIRECTIVE_COMMENT_REGEXP)
    DIRECTIVE_COMMENT_REGEXP = Regexp.new(
      "#{DIRECTIVE_HEADER_PATTERN}(?:\\s+#{COPS_PATTERN}|\\s+#{PUSH_POP_ARGS_PATTERN})?"
        .gsub(' ', '\s*')
    )

    remove_const(:MALFORMED_DIRECTIVE_WITHOUT_COP_NAME_REGEXP)
    MALFORMED_DIRECTIVE_WITHOUT_COP_NAME_REGEXP = Regexp.new(
      "\\A#{DIRECTIVE_HEADER_PATTERN}\\s*\\z".gsub(' ', '\s*')
    )
  end
end
