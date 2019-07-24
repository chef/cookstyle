# Cookstyle Changelog

<!-- latest_release 5.1.8 -->
## [v5.1.8](https://github.com/chef/cookstyle/tree/v5.1.8) (2019-07-24)

#### Merged Pull Requests
- Add Chef/EpicFail [#124](https://github.com/chef/cookstyle/pull/124) ([tas50](https://github.com/tas50))
<!-- latest_release -->

<!-- release_rollup since=5.0.4 -->
### Changes not yet released to rubygems.org

#### Merged Pull Requests
- Add Chef/EpicFail [#124](https://github.com/chef/cookstyle/pull/124) ([tas50](https://github.com/tas50)) <!-- 5.1.8 -->
- Force the fail level to :convention and set rules to :refactor level [#117](https://github.com/chef/cookstyle/pull/117) ([tas50](https://github.com/tas50)) <!-- 5.1.7 -->
- Add new UseBuildEssentialResource cop [#118](https://github.com/chef/cookstyle/pull/118) ([tas50](https://github.com/tas50)) <!-- 5.1.6 -->
- Improve detection of double spaces after sentences [#120](https://github.com/chef/cookstyle/pull/120) ([tas50](https://github.com/tas50)) <!-- 5.1.5 -->
- Test the cookstyle binary on Windows in Buildkite [#116](https://github.com/chef/cookstyle/pull/116) ([tas50](https://github.com/tas50)) <!-- 5.1.4 -->
- Add Chef/WhyRunSupportedTrue [#115](https://github.com/chef/cookstyle/pull/115) ([tas50](https://github.com/tas50)) <!-- 5.1.3 -->
- Add Chef/NodeNormal &amp; Chef/NodeNormalUnless for node.normal/node.normal_unless usage [#104](https://github.com/chef/cookstyle/pull/104) ([lamont-granquist](https://github.com/lamont-granquist)) <!-- 5.1.2 -->
- Add Chef/NodeSetUnless to autocorrect node.set_unless usage [#102](https://github.com/chef/cookstyle/pull/102) ([lamont-granquist](https://github.com/lamont-granquist)) <!-- 5.1.1 -->
- Add Chef/CommentSentenceSpacing cop (disabled by default) [#83](https://github.com/chef/cookstyle/pull/83) ([tas50](https://github.com/tas50)) <!-- 5.1.0 -->
- Add an autocorrect for insecure gitlab/github source/issue url metadata [#82](https://github.com/chef/cookstyle/pull/82) ([tas50](https://github.com/tas50)) <!-- 5.0.6 -->
- Add cop to detect old Berksfile sources [#81](https://github.com/chef/cookstyle/pull/81) ([tas50](https://github.com/tas50)) <!-- 5.0.5 -->
<!-- release_rollup -->

<!-- latest_stable_release -->
## [v5.0.4](https://github.com/chef/cookstyle/tree/v5.0.4) (2019-07-15)

#### Merged Pull Requests
- add Chef/NodeSet cop with autocorrect [#70](https://github.com/chef/cookstyle/pull/70) ([lamont-granquist](https://github.com/lamont-granquist))
- Fix version bumps and codeowners [#71](https://github.com/chef/cookstyle/pull/71) ([tas50](https://github.com/tas50))
- Add and update cookstyle cop descriptions [#72](https://github.com/chef/cookstyle/pull/72) ([tas50](https://github.com/tas50))
- Fix node matchers to properly trigger [#73](https://github.com/chef/cookstyle/pull/73) ([tas50](https://github.com/tas50))
<!-- latest_stable_release -->

## [v5.0.0](https://github.com/chef/cookstyle/tree/v5.0.0) (2019-07-02)

#### Merged Pull Requests
- Add buildkite PR test pipeline [#67](https://github.com/chef/cookstyle/pull/67) ([tas50](https://github.com/tas50))
- Fix buildkite pipeline setup [#68](https://github.com/chef/cookstyle/pull/68) ([tas50](https://github.com/tas50))
- Update Rubocop to 0.72 &amp; merge rubocop-chef [#69](https://github.com/chef/cookstyle/pull/69) ([tas50](https://github.com/tas50))

## [v4.0.0](https://github.com/chef/cookstyle/tree/v4.0.0) (2019-01-22)

#### Merged Pull Requests
- Require Ruby 2.2+ and update boilerplate [#57](https://github.com/chef/cookstyle/pull/57) ([tas50](https://github.com/tas50))
- Unpin the bundler dev dep [#59](https://github.com/chef/cookstyle/pull/59) ([tas50](https://github.com/tas50))
- Fix the update version script for expeditor [#60](https://github.com/chef/cookstyle/pull/60) ([tas50](https://github.com/tas50))
- Update cases in the readme [#61](https://github.com/chef/cookstyle/pull/61) ([tas50](https://github.com/tas50))
- Update to Rubocop 0.62 and require Ruby 2.4 [#62](https://github.com/chef/cookstyle/pull/62) ([tas50](https://github.com/tas50))
- Bump to 4.0 and resolve new cookstyle warnings [#63](https://github.com/chef/cookstyle/pull/63) ([tas50](https://github.com/tas50))

## 3.0.2 (2018-12-14)

- Add back the gemspec and gemfile in the gem artifact so this gem can be appbundled in projects like Chef DK / Workstation.

## 3.0.1 (2018-11-20)

Cookstyle now ignores lazy { } for symbol proc check. The autocorrected code produced by the Rubocop engine would cause chef-client failures in this situation. Thanks @martinisoft for the fix

## 3.0.0 (2018-05-07)

The RuboCop engine has been updated from 0.49 to 0.55 in this release of Cookstyle. This fixes a very large number of bugs and may lead to new warnings being shown for existing rules. Additionally the names of many rules were changed which may require updating your .rubocop.yml files if you previously disabled these rules.

### Newly Enabled Cops:

- Bundler/InsecureProtocolSource
- Layout/EmptyComment
- Layout/EmptyLinesAroundArguments
- Lint/BigDecimalNew
- Lint/BooleanSymbol
- Lint/InterpolationCheck:
- Lint/RedundantWithIndex
- Lint/RedundantWithObject
- Lint/RegexpInCondition
- Lint/ShadowedArgument
- Lint/UnneededCopEnableDirective
- Lint/UnneededRequireStatement
- Lint/UriRegexp
- Performance/UnneededSort
- Performance/UriDefaultParser
- Style/MinMax
- Style/RedundantConditional
- Style/TrailingBodyOnMethodDefinition
- Style/UnpackFirst

## 2.2.0 (2017-12-6)

- Style/GuardClause disabled as it forces consistency that may sacrifice readability in a cookbook.

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