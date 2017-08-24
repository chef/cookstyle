# Cookstyle Changelog

## 2.1.0 (2017-08-24)

- The Layout/EndOfLine cop now enforces a LF for line endings. This prevents users on Windows from seeing the "Carriage return character missing" error message.

## 2.0.0 (2017-05-31)

### Security Update

Rubocop has been upgraded from 0.47.1 to 0.49.1 to resolve <http://www.cvedetails.com/cve/CVE-2017-8418/>. Unfortunately between these versions a large number of rules were moved from the style namespace to the layout namespace. If you previously enabled/disabled whitespace or layout related rules in your own .rubocop.yml there is a good chance you'll need to update your config.

### Newly Enabled Cops:

- Style/YodaCondition which alerts on backwards and confusing condition logic
- Layout/EmptyLinesAroundExceptionHandlingKeywords which makes our empty line policy more consistent when using exception handling

## 1.4.0 (2017-05-30)

- Our configuration of Lint/AmbiguousRegexpLiteral now ignores files in the test dir even if you run Cookstyle against a chef-repo directory instead of individual cookbook directories.
- We now explicitly set TargetRubyVersion to 2.0, as Ruby 2.0 shipped in older Chef 12 releases.

### Newly Disabled Cops:

- BlockLength which completes Cookstyle ignoring length in cookbooks.
- Performance/Casecmp which resulted in confusing code.

## 1.3.1 (2017-04-17)

### Newly Disabled Cops:

- Style/DoubleNegation which is needed in some situations to avoid Chef deprecation warnings

## 1.3.0 (2017-02-13)

- Upgraded the Rubocop engine from 0.46 -> 0.47.1, but disabled all new cops. This aligns cookstyle with the Rubocop in Chefstyle and also resolves multiple bugs in Rubocop 0.46\. If you previously disabled the Lint/Eval cop in your own Rubocop config you'll need to update that with the new cop name of Security/Eval.

## 1.2.0 (2017-01-19)

- Change Style/NumericPredicate to use comparisons. We found that cookstyle autocorrecting code from foo == 0 to foo.zero? was breaking a lot of cookbooks. Additionally .zero? is significantly slower than just using foo == 0.

## 1.1.1 (2016-12-22)

- Properly disabled the correct cop to avoid warning on InSpec matchers: Lint/AmbiguousRegexpLiteral

## 1.1.0 (2016-12-13)

### Newly Disabled Cops:

- All Rails cops since they don't apply to us
- Metrics/ClassLength

## 1.0.1 (2016-12-12)

### Newly Disabled Cops:

- Style/TernaryParentheses

### Newly Enabled Cops:

- Lint/ShadowedException

## 1.0.0 (2016-12-12)

### Newly Disabled Cops:

- Metrics/CyclomaticComplexity
- Style/NumericLiterals
- Style/RegexpLiteral in /tests/ directory
- Style/AsciiComments

### Newly Enabled Cops:

- Bundler/DuplicatedGem
- Style/SpaceInsideArrayPercentLiteral
- Style/NumericPredicate
- Style/EmptyCaseCondition
- Style/EachForSimpleLoop
- Style/PreferredHashMethods
- Lint/UnifiedInteger
- Lint/PercentSymbolArray
- Lint/PercentStringArray
- Lint/EmptyWhen
- Lint/EmptyExpression
- Lint/DuplicateCaseCondition
- Style/TrailingCommaInLiteral
