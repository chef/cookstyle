# Cookstyle Changelog

<!-- latest_release 5.5.8 -->
## [v5.5.8](https://github.com/chef/cookstyle/tree/v5.5.8) (2019-09-10)

#### Merged Pull Requests
- Add ChefDeprecations/WindowsTaskChangeAction [#288](https://github.com/chef/cookstyle/pull/288) ([tas50](https://github.com/tas50))
<!-- latest_release -->

<!-- release_rollup since=5.5.7 -->
### Changes not yet released to rubygems.org

#### Merged Pull Requests
- Add ChefDeprecations/WindowsTaskChangeAction [#288](https://github.com/chef/cookstyle/pull/288) ([tas50](https://github.com/tas50)) <!-- 5.5.8 -->
<!-- release_rollup -->

<!-- latest_stable_release -->
## [v5.5.7](https://github.com/chef/cookstyle/tree/v5.5.7) (2019-09-06)

#### Merged Pull Requests
- Validate that all cops are in the config in CI + add missing Chef/CookbookUsesNodeSave [#272](https://github.com/chef/cookstyle/pull/272) ([tas50](https://github.com/tas50))
- Add Chef/LibarchiveFile and Chef/SevenZipArchiveResource [#271](https://github.com/chef/cookstyle/pull/271) ([tas50](https://github.com/tas50))
- Catch additional formats for default maintainer information in metadata [#275](https://github.com/chef/cookstyle/pull/275) ([tas50](https://github.com/tas50))
- Add Chef/UsesChefRESTHelpers [#276](https://github.com/chef/cookstyle/pull/276) ([tas50](https://github.com/tas50))
- Add helpers for matching on resource properties and add 11 new cops using those helpers [#226](https://github.com/chef/cookstyle/pull/226) ([tas50](https://github.com/tas50))
- Add the documentation generation rake task from rubocop-rspec [#278](https://github.com/chef/cookstyle/pull/278) ([tas50](https://github.com/tas50))
- Add release notes for Cookstyle 5.5 [#279](https://github.com/chef/cookstyle/pull/279) ([tas50](https://github.com/tas50))
- Add additional autocorrect and improve autocorrection testing [#282](https://github.com/chef/cookstyle/pull/282) ([tas50](https://github.com/tas50))
- Break up the Chef namespace into 4 namespaces [#283](https://github.com/chef/cookstyle/pull/283) ([tas50](https://github.com/tas50))
<!-- latest_stable_release -->

## [v5.4.13](https://github.com/chef/cookstyle/tree/v5.4.13) (2019-08-30)

#### Merged Pull Requests
- Add Chef/NodeMethodsInsteadofAttributes cop [#224](https://github.com/chef/cookstyle/pull/224) ([tas50](https://github.com/tas50))
- Avoid scanning metadata.rb files for rules that don&#39;t apply there [#225](https://github.com/chef/cookstyle/pull/225) ([tas50](https://github.com/tas50))
- Add Chef/MinitestHandlerUsage Chef/WindowsVersionHelper Chef/WindowsZipfileUsage [#237](https://github.com/chef/cookstyle/pull/237) ([tas50](https://github.com/tas50))
- Add autocorrect to MetadataMissingName [#244](https://github.com/chef/cookstyle/pull/244) ([tas50](https://github.com/tas50))
- Add Chef/UsesDeprecatedMixins [#243](https://github.com/chef/cookstyle/pull/243) ([tas50](https://github.com/tas50))
- Add Chef/DefaultMetadataMaintainer [#242](https://github.com/chef/cookstyle/pull/242) ([tas50](https://github.com/tas50))
- Add Chef/IncludingOhaiDefaultRecipe Chef/IncludingXMLRubyRecipe &amp; Chef/LegacyYumCookbookRecipes [#246](https://github.com/chef/cookstyle/pull/246) ([tas50](https://github.com/tas50))
- Improve error messages in CookbooksDependsOnSelf &amp; PropertyWithRequiredAndDefault [#262](https://github.com/chef/cookstyle/pull/262) ([tas50](https://github.com/tas50))
- Fix Chef/WhyRunSupportedTrue to find the correct method [#261](https://github.com/chef/cookstyle/pull/261) ([tas50](https://github.com/tas50))
- Add UseInlineResourcesDefined cop [#260](https://github.com/chef/cookstyle/pull/260) ([tas50](https://github.com/tas50))
- Exclude the files directory for scans [#248](https://github.com/chef/cookstyle/pull/248) ([tas50](https://github.com/tas50))
- Add Chef/IncludingMixinShelloutInResources cop [#249](https://github.com/chef/cookstyle/pull/249) ([tas50](https://github.com/tas50))
- Add spec for Chef/PropertyWithRequiredAndDefault [#263](https://github.com/chef/cookstyle/pull/263) ([tas50](https://github.com/tas50))
- Remove old spec helpers leftover from rubocop-rspec [#265](https://github.com/chef/cookstyle/pull/265) ([tas50](https://github.com/tas50))

## [v5.3.6](https://github.com/chef/cookstyle/tree/v5.3.6) (2019-08-20)

#### Merged Pull Requests
- Add 3 new cops for detecting legacy recipes being included [#214](https://github.com/chef/cookstyle/pull/214) ([tas50](https://github.com/tas50))
- Use Rubocop::RSpec::ExpectOffense for better specs [#215](https://github.com/chef/cookstyle/pull/215) ([tas50](https://github.com/tas50))
- Add Chef/DefinesChefSpecMatchers: cop [#216](https://github.com/chef/cookstyle/pull/216) ([tas50](https://github.com/tas50))
- Add auto correct specs where possible [#220](https://github.com/chef/cookstyle/pull/220) ([tas50](https://github.com/tas50))
- Autocorrect Apache v2.0 license to Apache-2.0 [#221](https://github.com/chef/cookstyle/pull/221) ([tas50](https://github.com/tas50))
- Add Chef/ExecuteAptUpdate rule [#222](https://github.com/chef/cookstyle/pull/222) ([tas50](https://github.com/tas50))
- Fix autocorrection of comments that are indented with more than one space [#223](https://github.com/chef/cookstyle/pull/223) ([tas50](https://github.com/tas50))

## [v5.2.17](https://github.com/chef/cookstyle/tree/v5.2.17) (2019-08-15)

#### Merged Pull Requests
- Add Chef/CookbooksDependsOnSelf and Chef/MetadataMissingName [#162](https://github.com/chef/cookstyle/pull/162) ([tas50](https://github.com/tas50))
- Add Chef/RequireRecipe rule [#161](https://github.com/chef/cookstyle/pull/161) ([tas50](https://github.com/tas50))
- Add Chef/InvalidLicenseString cop [#171](https://github.com/chef/cookstyle/pull/171) ([tas50](https://github.com/tas50))
- Add Chef/LongDescriptionMetadata cop [#170](https://github.com/chef/cookstyle/pull/170) ([tas50](https://github.com/tas50))
- Add Chef/RespondToInMetadata cop [#174](https://github.com/chef/cookstyle/pull/174) ([tas50](https://github.com/tas50))
- Add Chef/InvalidPlatformMetadata cop [#173](https://github.com/chef/cookstyle/pull/173) ([tas50](https://github.com/tas50))
- fix node.set/set_unless autocorrects to not break ChefSpec tests [#175](https://github.com/chef/cookstyle/pull/175) ([lamont-granquist](https://github.com/lamont-granquist))
- don&#39;t need the ${}&#39;s guess that is grouping [#176](https://github.com/chef/cookstyle/pull/176) ([lamont-granquist](https://github.com/lamont-granquist))
- Enable UseBuildEssentialResource and improve messaging [#177](https://github.com/chef/cookstyle/pull/177) ([tas50](https://github.com/tas50))
- Fix file matching in the configs [#178](https://github.com/chef/cookstyle/pull/178) ([tas50](https://github.com/tas50))
- Fix typo in method name [#179](https://github.com/chef/cookstyle/pull/179) ([tas50](https://github.com/tas50))
- Add Chef/RespondToResourceName and Chef/RespondToProvides cops [#180](https://github.com/chef/cookstyle/pull/180) ([tas50](https://github.com/tas50))
- Add Chef/SetOrReturnInResources cop [#181](https://github.com/chef/cookstyle/pull/181) ([tas50](https://github.com/tas50))
- Add autocorrecting to CookbooksDependsOnSelf [#186](https://github.com/chef/cookstyle/pull/186) ([tas50](https://github.com/tas50))
- Fix the regression where we no longer show the cookstyle version [#188](https://github.com/chef/cookstyle/pull/188) ([tas50](https://github.com/tas50))
- Add Chef/BlockGuardWithOnlyString [#189](https://github.com/chef/cookstyle/pull/189) ([tas50](https://github.com/tas50))
- Add Cookstyle 5.2 release notes [#182](https://github.com/chef/cookstyle/pull/182) ([tas50](https://github.com/tas50))
- Add Chef/CustomResourceWithAttributes cop [#193](https://github.com/chef/cookstyle/pull/193) ([tas50](https://github.com/tas50))
- Add Chef/CustomResourceWithAllowedActions [#192](https://github.com/chef/cookstyle/pull/192) ([tas50](https://github.com/tas50))

## [v5.1.19](https://github.com/chef/cookstyle/tree/v5.1.19) (2019-08-08)

#### Merged Pull Requests
- Add cop to detect old Berksfile sources [#81](https://github.com/chef/cookstyle/pull/81) ([tas50](https://github.com/tas50))
- Add an autocorrect for insecure gitlab/github source/issue url metadata [#82](https://github.com/chef/cookstyle/pull/82) ([tas50](https://github.com/tas50))
- Add Chef/CommentSentenceSpacing cop (disabled by default) [#83](https://github.com/chef/cookstyle/pull/83) ([tas50](https://github.com/tas50))
- Add Chef/NodeSetUnless to autocorrect node.set_unless usage [#102](https://github.com/chef/cookstyle/pull/102) ([lamont-granquist](https://github.com/lamont-granquist))
- Add Chef/NodeNormal &amp; Chef/NodeNormalUnless for node.normal/node.normal_unless usage [#104](https://github.com/chef/cookstyle/pull/104) ([lamont-granquist](https://github.com/lamont-granquist))
- Add Chef/WhyRunSupportedTrue [#115](https://github.com/chef/cookstyle/pull/115) ([tas50](https://github.com/tas50))
- Test the cookstyle binary on Windows in Buildkite [#116](https://github.com/chef/cookstyle/pull/116) ([tas50](https://github.com/tas50))
- Improve detection of double spaces after sentences [#120](https://github.com/chef/cookstyle/pull/120) ([tas50](https://github.com/tas50))
- Add new UseBuildEssentialResource cop [#118](https://github.com/chef/cookstyle/pull/118) ([tas50](https://github.com/tas50))
- Force the fail level to :convention and set rules to :refactor level [#117](https://github.com/chef/cookstyle/pull/117) ([tas50](https://github.com/tas50))
- Add Chef/EpicFail [#124](https://github.com/chef/cookstyle/pull/124) ([tas50](https://github.com/tas50))
- Add new PropertyWithNameAttribute rule [#125](https://github.com/chef/cookstyle/pull/125) ([tas50](https://github.com/tas50))
- Add new Chef/PropertyWithRequiredAndDefault [#129](https://github.com/chef/cookstyle/pull/129) ([tas50](https://github.com/tas50))
- Avoid false positives in header cleanup [#133](https://github.com/chef/cookstyle/pull/133) ([tas50](https://github.com/tas50))
- Rework the docs for the new world of Chef specific rules [#122](https://github.com/chef/cookstyle/pull/122) ([tas50](https://github.com/tas50))
- Add rules for Effortless Infra pattern [#137](https://github.com/chef/cookstyle/pull/137) ([tas50](https://github.com/tas50))
- Add the majority of specs from rubocop-chef [#138](https://github.com/chef/cookstyle/pull/138) ([tas50](https://github.com/tas50))
- Add introduced fields and turn off Chef/UseBuildEssentialResource by default [#139](https://github.com/chef/cookstyle/pull/139) ([tas50](https://github.com/tas50))
- Add additional specs [#142](https://github.com/chef/cookstyle/pull/142) ([tas50](https://github.com/tas50))
- Add Chef/CookbookDependsOnPoise rule [#140](https://github.com/chef/cookstyle/pull/140) ([tas50](https://github.com/tas50))
- Add Chef/NamePropertyIsRequired cop [#141](https://github.com/chef/cookstyle/pull/141) ([tas50](https://github.com/tas50))
- Add 10 additional cops for detected deprecated behavior [#143](https://github.com/chef/cookstyle/pull/143) ([tas50](https://github.com/tas50))

## [v5.0.4](https://github.com/chef/cookstyle/tree/v5.0.4) (2019-07-15)

#### Merged Pull Requests
- add Chef/NodeSet cop with autocorrect [#70](https://github.com/chef/cookstyle/pull/70) ([lamont-granquist](https://github.com/lamont-granquist))
- Fix version bumps and codeowners [#71](https://github.com/chef/cookstyle/pull/71) ([tas50](https://github.com/tas50))
- Add and update cookstyle cop descriptions [#72](https://github.com/chef/cookstyle/pull/72) ([tas50](https://github.com/tas50))
- Fix node matchers to properly trigger [#73](https://github.com/chef/cookstyle/pull/73) ([tas50](https://github.com/tas50))

## [v5.0.0](https://github.com/chef/cookstyle/tree/v5.0.0) (2019-07-02)

#### Merged Pull Requests
- Add buildkite PR test pipeline [#67](https://github.com/chef/cookstyle/pull/67) ([tas50](https://github.com/tas50))
- Fix buildkite pipeline setup [#68](https://github.com/chef/cookstyle/pull/68) ([tas50](https://github.com/tas50))
- Update RuboCop to 0.72 &amp; merge rubocop-chef [#69](https://github.com/chef/cookstyle/pull/69) ([tas50](https://github.com/tas50))

## [v4.0.0](https://github.com/chef/cookstyle/tree/v4.0.0) (2019-01-22)

#### Merged Pull Requests
- Require Ruby 2.2+ and update boilerplate [#57](https://github.com/chef/cookstyle/pull/57) ([tas50](https://github.com/tas50))
- Unpin the bundler dev dep [#59](https://github.com/chef/cookstyle/pull/59) ([tas50](https://github.com/tas50))
- Fix the update version script for expeditor [#60](https://github.com/chef/cookstyle/pull/60) ([tas50](https://github.com/tas50))
- Update cases in the readme [#61](https://github.com/chef/cookstyle/pull/61) ([tas50](https://github.com/tas50))
- Update to RuboCop 0.62 and require Ruby 2.4 [#62](https://github.com/chef/cookstyle/pull/62) ([tas50](https://github.com/tas50))
- Bump to 4.0 and resolve new cookstyle warnings [#63](https://github.com/chef/cookstyle/pull/63) ([tas50](https://github.com/tas50))

## 3.0.2 (2018-12-14)

- Add back the gemspec and gemfile in the gem artifact so this gem can be appbundled in projects like Chef DK / Workstation.

## 3.0.1 (2018-11-20)

Cookstyle now ignores lazy { } for symbol proc check. The autocorrected code produced by the RuboCop engine would cause chef-client failures in this situation. Thanks @martinisoft for the fix

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

RuboCop has been upgraded from 0.47.1 to 0.49.1 to resolve <http://www.cvedetails.com/cve/CVE-2017-8418/>. Unfortunately between these versions a large number of rules were moved from the style namespace to the layout namespace. If you previously enabled/disabled whitespace or layout related rules in your own .rubocop.yml there is a good chance you'll need to update your config.

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

- Upgraded the RuboCop engine from 0.46 -> 0.47.1, but disabled all new cops. This aligns cookstyle with the RuboCop in Chefstyle and also resolves multiple bugs in RuboCop 0.46\. If you previously disabled the Lint/Eval cop in your own RuboCop config you'll need to update that with the new cop name of Security/Eval.

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