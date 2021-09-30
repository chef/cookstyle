# Cookstyle Changelog

 <!-- latest_release 7.25.5 -->
## [v7.25.5](https://github.com/chef/cookstyle/tree/v7.25.5) (2021-09-30)

#### Merged Pull Requests
- Update RuboCop to 1.22 [#912](https://github.com/chef/cookstyle/pull/912) ([tas50](https://github.com/tas50))
<!-- latest_release -->

<!-- release_rollup since=7.24.1 -->
### Changes not yet released to rubygems.org

#### Merged Pull Requests
- Update RuboCop to 1.22 [#912](https://github.com/chef/cookstyle/pull/912) ([tas50](https://github.com/tas50)) <!-- 7.25.5 -->
- Vendor rubocop-1.21.0 upstream configuration. [#911](https://github.com/chef/cookstyle/pull/911) ([tas50](https://github.com/tas50)) <!-- 7.25.4 -->
- Update to RuboCop 1.21 + move windows testing to GH [#910](https://github.com/chef/cookstyle/pull/910) ([tas50](https://github.com/tas50)) <!-- 7.25.3 -->
- Add dependabot config [#909](https://github.com/chef/cookstyle/pull/909) ([tas50](https://github.com/tas50)) <!-- 7.25.2 -->
- Move Ubuntu / lint testing to GitHub actions [#908](https://github.com/chef/cookstyle/pull/908) ([tas50](https://github.com/tas50)) <!-- 7.25.1 -->
- Add Chef/Correctness/MetadataMissingVersion [#907](https://github.com/chef/cookstyle/pull/907) ([tas50](https://github.com/tas50)) <!-- 7.25.0 -->
<!-- release_rollup -->

<!-- latest_stable_release -->
## [v7.24.1](https://github.com/chef/cookstyle/tree/v7.24.1) (2021-09-02)

#### Merged Pull Requests
- Add Chef target versions to existing cops [#900](https://github.com/chef/cookstyle/pull/900) ([tas50](https://github.com/tas50))
- Add Chef/Modernize/UseChefLanguageSystemdHelper cop [#901](https://github.com/chef/cookstyle/pull/901) ([tas50](https://github.com/tas50))
<!-- latest_stable_release -->

## [v7.23.0](https://github.com/chef/cookstyle/tree/v7.23.0) (2021-09-02)

#### Merged Pull Requests
- Fix typos in descriptions [#894](https://github.com/chef/cookstyle/pull/894) ([tas50](https://github.com/tas50))
- Replace deprecated --without flag with bundle config [#885](https://github.com/chef/cookstyle/pull/885) ([skeshari12](https://github.com/skeshari12))
- Add Chef/Modernize/ClassEvalActionClass cop [#897](https://github.com/chef/cookstyle/pull/897) ([tas50](https://github.com/tas50))
- Fix typo in description [#898](https://github.com/chef/cookstyle/pull/898) ([tas50](https://github.com/tas50))

## [v7.22.3](https://github.com/chef/cookstyle/tree/v7.22.3) (2021-08-27)

#### Merged Pull Requests
- Add new Chef/Modernize/UseChefLanguageCloudHelpers cop [#890](https://github.com/chef/cookstyle/pull/890) ([tas50](https://github.com/tas50))
- Update all branch references to be main [#891](https://github.com/chef/cookstyle/pull/891) ([tas50](https://github.com/tas50))
- Fix spelling mistakes in descriptions [#892](https://github.com/chef/cookstyle/pull/892) ([tas50](https://github.com/tas50))
- Update RuboCop to 1.20 [#893](https://github.com/chef/cookstyle/pull/893) ([tas50](https://github.com/tas50))

## [v7.21](https://github.com/chef/cookstyle/tree/v7.21) (2021-08-25)

#### Merged Pull Requests
- Updates Chef/Style/ImmediateNotificationTiming to support subscribes [#887](https://github.com/chef/cookstyle/pull/887) ([tas50](https://github.com/tas50))
- Fix typos in the docs + incorrect description in config [#888](https://github.com/chef/cookstyle/pull/888) ([tas50](https://github.com/tas50))
- Add new Chef/Modernize/UseChefLanguageEnvHelpers cop [#889](https://github.com/chef/cookstyle/pull/889) ([tas50](https://github.com/tas50))

## [v7.20.0](https://github.com/chef/cookstyle/tree/v7.20.0) (2021-08-19)

#### Merged Pull Requests
- Add 6 more cops to detect deprecated or integrated cookbooks [#886](https://github.com/chef/cookstyle/pull/886) ([tas50](https://github.com/tas50))

## [v7.19.0](https://github.com/chef/cookstyle/tree/v7.19.0) (2021-08-18)

#### Merged Pull Requests
- Add new Chef/Correctness/PowershellFileExists cop [#883](https://github.com/chef/cookstyle/pull/883) ([tas50](https://github.com/tas50))
- Add 5 new cops to detect deprecated cookbooks [#884](https://github.com/chef/cookstyle/pull/884) ([tas50](https://github.com/tas50))

## [v7.18.0](https://github.com/chef/cookstyle/tree/v7.18.0) (2021-08-14)

#### Merged Pull Requests
- Add a new cop Chef/Deprecations/DeprecatedSudoActions [#882](https://github.com/chef/cookstyle/pull/882) ([tas50](https://github.com/tas50))

## [v7.17.0](https://github.com/chef/cookstyle/tree/v7.17.0) (2021-08-12)

#### Merged Pull Requests
- Update RuboCop to 1.19 [#881](https://github.com/chef/cookstyle/pull/881) ([tas50](https://github.com/tas50))

## [v7.16.1](https://github.com/chef/cookstyle/tree/v7.16.1) (2021-08-06)

#### Merged Pull Requests
- Add a new cop for detecting malformed cookbook depends [#879](https://github.com/chef/cookstyle/pull/879) ([tas50](https://github.com/tas50))
- Fix MetadataMissingName to properly autocorrect [#880](https://github.com/chef/cookstyle/pull/880) ([tas50](https://github.com/tas50))

## [v7.15.4](https://github.com/chef/cookstyle/tree/v7.15.4) (2021-07-30)

#### Merged Pull Requests
- Prevent ResourceWithoutUnifiedTrue fails with empty files [#876](https://github.com/chef/cookstyle/pull/876) ([tas50](https://github.com/tas50))

## [v7.15.3](https://github.com/chef/cookstyle/tree/v7.15.3) (2021-07-29)

#### Merged Pull Requests
- Ignore resource partials for Chef/Deprecations/ResourceWithoutUnifiedTrue [#875](https://github.com/chef/cookstyle/pull/875) ([jakauppila](https://github.com/jakauppila))

## [v7.15.2](https://github.com/chef/cookstyle/tree/v7.15.2) (2021-07-24)

#### Merged Pull Requests
- Update to RuboCop 1.18.4 [#874](https://github.com/chef/cookstyle/pull/874) ([tas50](https://github.com/tas50))

## [v7.15.1](https://github.com/chef/cookstyle/tree/v7.15.1) (2021-07-06)

#### Merged Pull Requests
- Update RuboCop engine to 1.18.3 [#870](https://github.com/chef/cookstyle/pull/870) ([tas50](https://github.com/tas50))

## [v7.15.0](https://github.com/chef/cookstyle/tree/v7.15.0) (2021-07-02)

#### Merged Pull Requests
- Add new Chef/Deprecations/PolicyfileCommunitySource cop [#869](https://github.com/chef/cookstyle/pull/869) ([tas50](https://github.com/tas50))

## [v7.14.2](https://github.com/chef/cookstyle/tree/v7.14.2) (2021-06-24)

#### Merged Pull Requests
- Update RuboCop to 1.17 [#861](https://github.com/chef/cookstyle/pull/861) ([tas50](https://github.com/tas50))
- Add new InSpec cops to Cookstyle [#862](https://github.com/chef/cookstyle/pull/862) ([tas50](https://github.com/tas50))
- Make sure we generate documentation for InSpec cops [#865](https://github.com/chef/cookstyle/pull/865) ([tas50](https://github.com/tas50))

## [v7.13.0](https://github.com/chef/cookstyle/tree/v7.13.0) (2021-05-27)

#### Merged Pull Requests
- Update to RuboCop 1.15 [#859](https://github.com/chef/cookstyle/pull/859) ([tas50](https://github.com/tas50))

## [v7.12.6](https://github.com/chef/cookstyle/tree/v7.12.6) (2021-05-27)

#### Merged Pull Requests
- Remove beginning slash from exclude path [#858](https://github.com/chef/cookstyle/pull/858) ([teknofire](https://github.com/teknofire))

## [v7.12.5](https://github.com/chef/cookstyle/tree/v7.12.5) (2021-05-17)

#### Merged Pull Requests
- Fix indentation in windows_uac causes bad docs generation [#855](https://github.com/chef/cookstyle/pull/855) ([tas50](https://github.com/tas50))
- Ignore specs for Chef/Deprecations/ResourceWithoutUnifiedTrue [#856](https://github.com/chef/cookstyle/pull/856) ([ramereth](https://github.com/ramereth))

## [v7.12.3](https://github.com/chef/cookstyle/tree/v7.12.3) (2021-05-16)

#### Merged Pull Requests
- Fix false positive in WindowsRegistryUAC [#854](https://github.com/chef/cookstyle/pull/854) ([tas50](https://github.com/tas50))

## [v7.12.2](https://github.com/chef/cookstyle/tree/v7.12.2) (2021-05-10)

#### Merged Pull Requests
- Move comments to the correct location for docs generation [#850](https://github.com/chef/cookstyle/pull/850) ([tas50](https://github.com/tas50))
- Add new unified_mode cop for HWRPs [#851](https://github.com/chef/cookstyle/pull/851) ([tas50](https://github.com/tas50))
- Test on Ruby 3.0 [#852](https://github.com/chef/cookstyle/pull/852) ([tas50](https://github.com/tas50))
- Add new cop for unified mode in custom resources [#853](https://github.com/chef/cookstyle/pull/853) ([tas50](https://github.com/tas50))

## [v7.11.3](https://github.com/chef/cookstyle/tree/v7.11.3) (2021-05-06)

#### Merged Pull Requests
- Disable Style/RedundantBegin for now [#848](https://github.com/chef/cookstyle/pull/848) ([tas50](https://github.com/tas50))
- Improve cop documenation [#849](https://github.com/chef/cookstyle/pull/849) ([tas50](https://github.com/tas50))

## [v7.11.1](https://github.com/chef/cookstyle/tree/v7.11.1) (2021-05-05)

#### Merged Pull Requests
- Update to RuboCop 1.13 and parse Ruby 2.5 and later only [#845](https://github.com/chef/cookstyle/pull/845) ([tas50](https://github.com/tas50))
- Update RuboCop Engine to 1.14 [#846](https://github.com/chef/cookstyle/pull/846) ([tas50](https://github.com/tas50))

## [v7.10.1](https://github.com/chef/cookstyle/tree/v7.10.1) (2021-04-17)

#### Merged Pull Requests
- Update to RuboCop 1.12.1 [#843](https://github.com/chef/cookstyle/pull/843) ([tas50](https://github.com/tas50))

## [v7.10.0](https://github.com/chef/cookstyle/tree/v7.10.0) (2021-03-24)

#### Merged Pull Requests
- Update RuboCop to 1.12 [#840](https://github.com/chef/cookstyle/pull/840) ([tas50](https://github.com/tas50))

## [v7.9.0](https://github.com/chef/cookstyle/tree/v7.9.0) (2021-03-08)

#### Merged Pull Requests
- Update RuboCop engine to 1.11 [#837](https://github.com/chef/cookstyle/pull/837) ([tas50](https://github.com/tas50))
- Add a spelling check [#831](https://github.com/chef/cookstyle/pull/831) ([tas50](https://github.com/tas50))
- Improve resource docs [#838](https://github.com/chef/cookstyle/pull/838) ([tas50](https://github.com/tas50))

## [v7.8.3](https://github.com/chef/cookstyle/tree/v7.8.3) (2021-02-17)

#### Merged Pull Requests
- Stop producing markdown docs + update styleguide to docs.chef.io [#832](https://github.com/chef/cookstyle/pull/832) ([tas50](https://github.com/tas50))
- Stop generating the legacy markdown docs [#833](https://github.com/chef/cookstyle/pull/833) ([tas50](https://github.com/tas50))
- Update link to the docs in the readme [#834](https://github.com/chef/cookstyle/pull/834) ([tas50](https://github.com/tas50))

## [v7.8.0](https://github.com/chef/cookstyle/tree/v7.8.0) (2021-02-15)

#### Merged Pull Requests
- Generate yaml docs pages for each cop on each PR merge [#826](https://github.com/chef/cookstyle/pull/826) ([tas50](https://github.com/tas50))
- Enable Lint/ErbNewArguments cop [#828](https://github.com/chef/cookstyle/pull/828) ([tas50](https://github.com/tas50))
- Improve the yaml we generate [#829](https://github.com/chef/cookstyle/pull/829) ([tas50](https://github.com/tas50))
- Bump RuboCop to 1.10 [#830](https://github.com/chef/cookstyle/pull/830) ([tas50](https://github.com/tas50))

## [v7.7.2](https://github.com/chef/cookstyle/tree/v7.7.2) (2021-02-01)

#### Merged Pull Requests
- Update the list of SPDX license strings [#824](https://github.com/chef/cookstyle/pull/824) ([tas50](https://github.com/tas50))
- Always enable the styleguide links to provide better docs [#823](https://github.com/chef/cookstyle/pull/823) ([tas50](https://github.com/tas50))
- Update RuboCop to 1.9.1 [#825](https://github.com/chef/cookstyle/pull/825) ([tas50](https://github.com/tas50))

## [v7.6.1](https://github.com/chef/cookstyle/tree/v7.6.1) (2021-01-29)

#### Merged Pull Requests
- Update dstr handling for new rubocop-ast [#820](https://github.com/chef/cookstyle/pull/820) ([tas50](https://github.com/tas50))
- Update RuboCop engine from 1.7 to 1.9 [#819](https://github.com/chef/cookstyle/pull/819) ([tas50](https://github.com/tas50))
- Enable Lint/DeprecatedConstants [#821](https://github.com/chef/cookstyle/pull/821) ([tas50](https://github.com/tas50))

## [v7.5.3](https://github.com/chef/cookstyle/tree/v7.5.3) (2020-12-31)

#### Merged Pull Requests
- Update the list of deprecated fauxhai platforms [#818](https://github.com/chef/cookstyle/pull/818) ([tas50](https://github.com/tas50))

## [v7.5.2](https://github.com/chef/cookstyle/tree/v7.5.2) (2020-12-31)

#### Merged Pull Requests
- TrailingBlankLines was renamed TrailingEmptyLines [#817](https://github.com/chef/cookstyle/pull/817) ([tas50](https://github.com/tas50))

## [v7.5.1](https://github.com/chef/cookstyle/tree/v7.5.1) (2020-12-30)

#### Merged Pull Requests
- Update RuboCop to 1.7.0 [#814](https://github.com/chef/cookstyle/pull/814) ([tas50](https://github.com/tas50))
- Update UnnecessaryNameProperty to not care about order [#815](https://github.com/chef/cookstyle/pull/815) ([tas50](https://github.com/tas50))

## [v7.4.0](https://github.com/chef/cookstyle/tree/v7.4.0) (2020-12-21)

#### Merged Pull Requests
- Update RuboCop to 1.6.2 [#813](https://github.com/chef/cookstyle/pull/813) ([tas50](https://github.com/tas50))

## [v7.3.11](https://github.com/chef/cookstyle/tree/v7.3.11) (2020-12-04)

#### Merged Pull Requests
- Update RuboCop to 1.5.2 [#812](https://github.com/chef/cookstyle/pull/812) ([tas50](https://github.com/tas50))

## [v7.3.10](https://github.com/chef/cookstyle/tree/v7.3.10) (2020-12-01)

#### Merged Pull Requests
- Disable cop with potentially misleading warning message. [#799](https://github.com/chef/cookstyle/pull/799) ([phiggins](https://github.com/phiggins))
- Bump RuboCop to 1.4.1 [#800](https://github.com/chef/cookstyle/pull/800) ([tas50](https://github.com/tas50))
- Update RuboCop to 1.4.2 [#801](https://github.com/chef/cookstyle/pull/801) ([tas50](https://github.com/tas50))
- Unpin parallel gem since it supports Ruby 2.4 again [#806](https://github.com/chef/cookstyle/pull/806) ([tas50](https://github.com/tas50))
- Don&#39;t use DSL actions in HWRPs [#802](https://github.com/chef/cookstyle/pull/802) ([tas50](https://github.com/tas50))
- Exclude more files in our cops to speed them up [#803](https://github.com/chef/cookstyle/pull/803) ([tas50](https://github.com/tas50))
- Add new Chef/Deprecations/DeprecatedYumRepositoryActions cop [#804](https://github.com/chef/cookstyle/pull/804) ([tas50](https://github.com/tas50))
- Run Chef/Modernize/RespondToProvides in resources as well [#808](https://github.com/chef/cookstyle/pull/808) ([tas50](https://github.com/tas50))
- Update Chef/Style/CommentSentenceSpacing to use the new RuboCop methods [#807](https://github.com/chef/cookstyle/pull/807) ([tas50](https://github.com/tas50))
- Add new Chef/Deprecations/ChefSugarHelpers cop [#805](https://github.com/chef/cookstyle/pull/805) ([tas50](https://github.com/tas50))
- Update to RuboCop 1.5.0 [#810](https://github.com/chef/cookstyle/pull/810) ([tas50](https://github.com/tas50))
- Add additional deprecated Fauxhai platforms [#811](https://github.com/chef/cookstyle/pull/811) ([tas50](https://github.com/tas50))

## [v7.2.1](https://github.com/chef/cookstyle/tree/v7.2.1) (2020-11-16)

#### Merged Pull Requests
- Add release notes for Cookstyle 7.1 [#794](https://github.com/chef/cookstyle/pull/794) ([tas50](https://github.com/tas50))
- Remove extra dev deps [#793](https://github.com/chef/cookstyle/pull/793) ([tas50](https://github.com/tas50))
- cookstyle.yml - Update the broken StyleGuideBaseURL values [#796](https://github.com/chef/cookstyle/pull/796) ([jamesnearn](https://github.com/jamesnearn))
- Update RuboCop to 1.3.0 [#797](https://github.com/chef/cookstyle/pull/797) ([tas50](https://github.com/tas50))
- Update RuboCop to 1.3.1 [#798](https://github.com/chef/cookstyle/pull/798) ([tas50](https://github.com/tas50))

## [v7.1.2](https://github.com/chef/cookstyle/tree/v7.1.2) (2020-11-05)

#### Merged Pull Requests
- Remove the release branch constraints [#782](https://github.com/chef/cookstyle/pull/782) ([tas50](https://github.com/tas50))
- Add a new Chef/Deprecations/LibrarianChefSpec cop [#783](https://github.com/chef/cookstyle/pull/783) ([tas50](https://github.com/tas50))
- Add new Chef/Deprecations/FoodcriticTesting cop [#785](https://github.com/chef/cookstyle/pull/785) ([tas50](https://github.com/tas50))
- Update to RuboCop 1.2.0 [#791](https://github.com/chef/cookstyle/pull/791) ([tas50](https://github.com/tas50))
- Enable Style/CollectionCompact [#792](https://github.com/chef/cookstyle/pull/792) ([tas50](https://github.com/tas50))
- Handle more multipackage scenarios [#790](https://github.com/chef/cookstyle/pull/790) ([tas50](https://github.com/tas50))

## [v7.0.0](https://github.com/chef/cookstyle/tree/v7.0.0) (2020-10-29)

#### Merged Pull Requests
- Disable Style/NumericPredicate [#780](https://github.com/chef/cookstyle/pull/780) ([tas50](https://github.com/tas50))
- Update to RuboCop 1.1 [#781](https://github.com/chef/cookstyle/pull/781) ([tas50](https://github.com/tas50))

## [v6.21.1](https://github.com/chef/cookstyle/tree/v6.21.1) (2020-10-15)

#### Merged Pull Requests
- Add new ChefCorrectness/OctalModeAsString cop [#777](https://github.com/chef/cookstyle/pull/777) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/UseYamlDump cop [#778](https://github.com/chef/cookstyle/pull/778) ([tas50](https://github.com/tas50))
- Add release notes for 6.21 [#779](https://github.com/chef/cookstyle/pull/779) ([tas50](https://github.com/tas50))

## [v6.20.2](https://github.com/chef/cookstyle/tree/v6.20.2) (2020-10-12)

#### Merged Pull Requests
- Update RuboCop to 0.93.1 [#776](https://github.com/chef/cookstyle/pull/776) ([tas50](https://github.com/tas50))

## [v6.20.1](https://github.com/chef/cookstyle/tree/v6.20.1) (2020-10-08)

#### Merged Pull Requests
- Update copyright to bump version [#774](https://github.com/chef/cookstyle/pull/774) ([tas50](https://github.com/tas50))
- Add release notes for 6.20 [#775](https://github.com/chef/cookstyle/pull/775) ([tas50](https://github.com/tas50))

## [v6.19.11](https://github.com/chef/cookstyle/tree/v6.19.11) (2020-10-02)

#### Merged Pull Requests
- Speedup runs by 4.3% with restrict on send [#766](https://github.com/chef/cookstyle/pull/766) ([tas50](https://github.com/tas50))
- Simplify ChefDeprecations/ResourceOverridesProvidesMethod [#767](https://github.com/chef/cookstyle/pull/767) ([tas50](https://github.com/tas50))
- Remove extra Gem::Dependency.new code [#768](https://github.com/chef/cookstyle/pull/768) ([tas50](https://github.com/tas50))
- Use + instead of dup to unfreeze a string [#769](https://github.com/chef/cookstyle/pull/769) ([tas50](https://github.com/tas50))
- Ident all the heredocs [#770](https://github.com/chef/cookstyle/pull/770) ([tas50](https://github.com/tas50))
- Enable rubocop-performance in CI [#771](https://github.com/chef/cookstyle/pull/771) ([tas50](https://github.com/tas50))

## [v6.19.5](https://github.com/chef/cookstyle/tree/v6.19.5) (2020-09-28)

#### Merged Pull Requests
- Simplify various cops [#758](https://github.com/chef/cookstyle/pull/758) ([tas50](https://github.com/tas50))
- Update RuboCop to 0.91.1 [#761](https://github.com/chef/cookstyle/pull/761) ([tas50](https://github.com/tas50))
- Catch more legacy metadata gating [#759](https://github.com/chef/cookstyle/pull/759) ([tas50](https://github.com/tas50))
- Run a single regex per comment line instead of 9 [#760](https://github.com/chef/cookstyle/pull/760) ([tas50](https://github.com/tas50))
- Update RuboCop to 0.92 [#763](https://github.com/chef/cookstyle/pull/763) ([tas50](https://github.com/tas50))
- Adds cops to detect Chef Vault usage. [#762](https://github.com/chef/cookstyle/pull/762) ([scottvidmar](https://github.com/scottvidmar))
- Update the description for the new vault plugins [#764](https://github.com/chef/cookstyle/pull/764) ([tas50](https://github.com/tas50))

## [v6.18.8](https://github.com/chef/cookstyle/tree/v6.18.8) (2020-09-17)

#### Merged Pull Requests
- Update RuboCop to 0.91 [#748](https://github.com/chef/cookstyle/pull/748) ([tas50](https://github.com/tas50))
- Add new ChefCorrectness/LazyInResourceGuard cop [#750](https://github.com/chef/cookstyle/pull/750) ([tas50](https://github.com/tas50))
- Backport a fix for Layout/RescueEnsureAlignment [#749](https://github.com/chef/cookstyle/pull/749) ([tas50](https://github.com/tas50))
- Enable Lint/RedundantRequireStatement cop [#752](https://github.com/chef/cookstyle/pull/752) ([tas50](https://github.com/tas50))
- Add new ChefCorrectness/PropertyWithoutType cop [#751](https://github.com/chef/cookstyle/pull/751) ([tas50](https://github.com/tas50))
- Enable 8 more RuboCop cops to simplify code [#753](https://github.com/chef/cookstyle/pull/753) ([tas50](https://github.com/tas50))
- Optimize our slowest cop [#754](https://github.com/chef/cookstyle/pull/754) ([tas50](https://github.com/tas50))
- Enable 3 new ruby cops &amp; remove duplicate disables [#756](https://github.com/chef/cookstyle/pull/756) ([tas50](https://github.com/tas50))
- Cookstyle 6.18 release notes [#755](https://github.com/chef/cookstyle/pull/755) ([tas50](https://github.com/tas50))

## [v6.17.7](https://github.com/chef/cookstyle/tree/v6.17.7) (2020-09-15)

#### Merged Pull Requests
- ChefCorrectness/IncorrectLibraryInjection: Avoid adding duplicate includes in autocorrection [#747](https://github.com/chef/cookstyle/pull/747) ([tas50](https://github.com/tas50))

## [v6.17.6](https://github.com/chef/cookstyle/tree/v6.17.6) (2020-09-14)

#### Merged Pull Requests
- ChefCorrectness/IncorrectLibraryInjection: Catch more offenses [#745](https://github.com/chef/cookstyle/pull/745) ([tas50](https://github.com/tas50))

## [v6.17.5](https://github.com/chef/cookstyle/tree/v6.17.5) (2020-09-11)

#### Merged Pull Requests
- Add missing description to rake task [#738](https://github.com/chef/cookstyle/pull/738) ([tas50](https://github.com/tas50))
- Replace uses of File.dirname(__FILE__) with __dir__ [#737](https://github.com/chef/cookstyle/pull/737) ([tas50](https://github.com/tas50))
- Minor optimizations from rubocop-performance [#739](https://github.com/chef/cookstyle/pull/739) ([tas50](https://github.com/tas50))
- Remove unused stuff from spec_helper. [#741](https://github.com/chef/cookstyle/pull/741) ([phiggins](https://github.com/phiggins))
- Spec cleanup from rubocop-rspec [#740](https://github.com/chef/cookstyle/pull/740) ([tas50](https://github.com/tas50))
- Add new deprecation cops to help people get off Chef 12 [#742](https://github.com/chef/cookstyle/pull/742) ([tas50](https://github.com/tas50))
- Add Cookstyle 6.17 release notes [#743](https://github.com/chef/cookstyle/pull/743) ([tas50](https://github.com/tas50))

## [v6.16.10](https://github.com/chef/cookstyle/tree/v6.16.10) (2020-09-03)

#### Merged Pull Requests
- Enable Lint/Syntax cop that previously enabled by default [#735](https://github.com/chef/cookstyle/pull/735) ([tas50](https://github.com/tas50))

## [v6.16.9](https://github.com/chef/cookstyle/tree/v6.16.9) (2020-09-02)

#### Merged Pull Requests
- Resolve another regression in CustomResourceWithAllowedActions [#731](https://github.com/chef/cookstyle/pull/731) ([tas50](https://github.com/tas50))
- Resolve a regression in ResourceOverridesProvidesMethod [#732](https://github.com/chef/cookstyle/pull/732) ([tas50](https://github.com/tas50))

## [v6.16.7](https://github.com/chef/cookstyle/tree/v6.16.7) (2020-09-02)

#### Merged Pull Requests
- Use RESTRICT_ON_SEND to speedup on_send checks [#728](https://github.com/chef/cookstyle/pull/728) ([tas50](https://github.com/tas50))
- Restrict on_sends to specific methods throughout [#729](https://github.com/chef/cookstyle/pull/729) ([tas50](https://github.com/tas50))
- Resolve a regression in CustomResourceWithAllowedActions [#730](https://github.com/chef/cookstyle/pull/730) ([tas50](https://github.com/tas50))

## [v6.16.4](https://github.com/chef/cookstyle/tree/v6.16.4) (2020-09-01)

#### Merged Pull Requests
- Update Deprecations rules to latest RuboCop format [#720](https://github.com/chef/cookstyle/pull/720) ([scottvidmar](https://github.com/scottvidmar))
- Effortless and Redundant cops refactor to latest Rubocop format [#721](https://github.com/chef/cookstyle/pull/721) ([scottvidmar](https://github.com/scottvidmar))
- Update Correctness cops to latest Rubocop format and added corrector for ResourceWithNoneAction [#722](https://github.com/chef/cookstyle/pull/722) ([scottvidmar](https://github.com/scottvidmar))
- Update RuboCop engine to 0.90 [#723](https://github.com/chef/cookstyle/pull/723) ([tas50](https://github.com/tas50))
-  Refactoring Cookstyle rules to latest format of Rubocop [#725](https://github.com/chef/cookstyle/pull/725) ([scottvidmar](https://github.com/scottvidmar))
- Move CookbooksDependsOnSelf from ChefCorrectness to ChefDeprecations [#726](https://github.com/chef/cookstyle/pull/726) ([tas50](https://github.com/tas50))

## [v6.15.9](https://github.com/chef/cookstyle/tree/v6.15.9) (2020-08-25)

#### Merged Pull Requests
- Update the list of deprecated fauxhai/chefspec platforms [#716](https://github.com/chef/cookstyle/pull/716) ([tas50](https://github.com/tas50))
- Refactor Ruby27KeywordArgumentWarnings [#717](https://github.com/chef/cookstyle/pull/717) ([tas50](https://github.com/tas50))
- Fix IncludePropertyDescriptions to catch all occurrences [#718](https://github.com/chef/cookstyle/pull/718) ([tas50](https://github.com/tas50))
- Update IncludeResourceDescriptions to allow string interpolation [#719](https://github.com/chef/cookstyle/pull/719) ([tas50](https://github.com/tas50))

## [v6.15.5](https://github.com/chef/cookstyle/tree/v6.15.5) (2020-08-13)

#### Merged Pull Requests
- Fix typo in ChefSharing/EmptyMetadataField [#714](https://github.com/chef/cookstyle/pull/714) ([tas50](https://github.com/tas50))
- Optimize requires for non omnibus installs [#715](https://github.com/chef/cookstyle/pull/715) ([tas50](https://github.com/tas50))

## [v6.15.3](https://github.com/chef/cookstyle/tree/v6.15.3) (2020-08-10)

#### Merged Pull Requests
- Disable Metrics/BlockNesting and Metrics/ParameterLists [#707](https://github.com/chef/cookstyle/pull/707) ([lamont-granquist](https://github.com/lamont-granquist))
- Turn off Naming/AccessorMethodName [#708](https://github.com/chef/cookstyle/pull/708) ([tas50](https://github.com/tas50))
- Update to RuboCop 0.89 [#709](https://github.com/chef/cookstyle/pull/709) ([tas50](https://github.com/tas50))
- Enable additional cops from recent RuboCop releases [#710](https://github.com/chef/cookstyle/pull/710) ([tas50](https://github.com/tas50))
- Fix doc generation [#711](https://github.com/chef/cookstyle/pull/711) ([phiggins](https://github.com/phiggins))
- Update RuboCop engine to 0.89.1 [#713](https://github.com/chef/cookstyle/pull/713) ([tas50](https://github.com/tas50))

## [v6.14.7](https://github.com/chef/cookstyle/tree/v6.14.7) (2020-07-30)

#### Merged Pull Requests
- Fix matcher name to match what we&#39;re doing [#691](https://github.com/chef/cookstyle/pull/691) ([tas50](https://github.com/tas50))
- Multiple spelling corrections including a cop name [#697](https://github.com/chef/cookstyle/pull/697) ([tas50](https://github.com/tas50))
- Update dead links [#696](https://github.com/chef/cookstyle/pull/696) ([dg42xyz](https://github.com/dg42xyz))
- Cleanup leftover config from rubocop-chef project [#698](https://github.com/chef/cookstyle/pull/698) ([tas50](https://github.com/tas50))
- Fix a few incorrect StyleGuide links [#699](https://github.com/chef/cookstyle/pull/699) ([tas50](https://github.com/tas50))
- Fix target_chef_version support in the new Rubocop 0.88+ format of cops [#700](https://github.com/chef/cookstyle/pull/700) ([tas50](https://github.com/tas50))
- Add 2 new cops for macos_userdefaults changes in 16.3 [#701](https://github.com/chef/cookstyle/pull/701) ([tas50](https://github.com/tas50))
- Update ChefStyle/FileMode to support files_mode as well [#702](https://github.com/chef/cookstyle/pull/702) ([tas50](https://github.com/tas50))

## [v6.13.3](https://github.com/chef/cookstyle/tree/v6.13.3) (2020-07-17)

#### Merged Pull Requests
- Add ChefCorrectness/InvalidDefaultAction cop [#685](https://github.com/chef/cookstyle/pull/685) ([tas50](https://github.com/tas50))
- Add new ChefModernize/CronDFileOrTemplate cop [#686](https://github.com/chef/cookstyle/pull/686) ([tas50](https://github.com/tas50))
- Add ChefRedundantCode/DoubleCompileTime cop [#687](https://github.com/chef/cookstyle/pull/687) ([tas50](https://github.com/tas50))
- Add ChefCorrectness/SupportsMustBeFloat [#689](https://github.com/chef/cookstyle/pull/689) ([tas50](https://github.com/tas50))
- Add release notes for 6.13 [#690](https://github.com/chef/cookstyle/pull/690) ([tas50](https://github.com/tas50))
- Add ChefModernize/ActionMethodInResource cop [#688](https://github.com/chef/cookstyle/pull/688) ([tas50](https://github.com/tas50))

## [v6.12.6](https://github.com/chef/cookstyle/tree/v6.12.6) (2020-07-15)

#### Merged Pull Requests
- Detect additional ways to shellout to apt-get update [#670](https://github.com/chef/cookstyle/pull/670) ([tas50](https://github.com/tas50))
- Add new ChefDeprecations/ChefDKGenerators cop [#671](https://github.com/chef/cookstyle/pull/671) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/ChefHandlerRecipe cop [#678](https://github.com/chef/cookstyle/pull/678) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/UseAutomaticResourceName cop [#680](https://github.com/chef/cookstyle/pull/680) ([tas50](https://github.com/tas50))
- Bump RuboCop to 0.88 [#683](https://github.com/chef/cookstyle/pull/683) ([tas50](https://github.com/tas50))
- Set frozen string literals to true in all files [#682](https://github.com/chef/cookstyle/pull/682) ([tas50](https://github.com/tas50))
- Copy over profiling support from RuboCop [#681](https://github.com/chef/cookstyle/pull/681) ([tas50](https://github.com/tas50))

## [v6.11.4](https://github.com/chef/cookstyle/tree/v6.11.4) (2020-07-09)

#### Merged Pull Requests
- Update RuboCop engine to 0.87.1 [#664](https://github.com/chef/cookstyle/pull/664) ([tas50](https://github.com/tas50))
- Expand NodeInitPackage to catch more bad systemd tests [#665](https://github.com/chef/cookstyle/pull/665) ([tas50](https://github.com/tas50))
- Add new ChefStyle/IncludeRecipeWithParentheses [#667](https://github.com/chef/cookstyle/pull/667) ([tas50](https://github.com/tas50))
- Add new cop ChefModernize/ConditionalUsingTest [#666](https://github.com/chef/cookstyle/pull/666) ([tas50](https://github.com/tas50))
- Expand IncorrectLibraryInjection to detect more types of injection [#668](https://github.com/chef/cookstyle/pull/668) ([tas50](https://github.com/tas50))

## [v6.10.2](https://github.com/chef/cookstyle/tree/v6.10.2) (2020-07-07)

#### Merged Pull Requests
- Add cookstyle cop to detect using .to_s on ohai attribute [#659](https://github.com/chef/cookstyle/pull/659) ([tas50](https://github.com/tas50))
- Add new ChefRedundantCode/MultiplePlatformChecks cop [#660](https://github.com/chef/cookstyle/pull/660) ([tas50](https://github.com/tas50))
- Monkeypatch the Migration/DepartmentName cop to suggest cookstyle [#661](https://github.com/chef/cookstyle/pull/661) ([tas50](https://github.com/tas50))
- Add ChefSharing/IncludeResourceExamples [#662](https://github.com/chef/cookstyle/pull/662) ([tas50](https://github.com/tas50))

## [v6.9.0](https://github.com/chef/cookstyle/tree/v6.9.0) (2020-06-25)

#### Merged Pull Requests
- Add Cookstyle 6.8 release notes [#652](https://github.com/chef/cookstyle/pull/652) ([tas50](https://github.com/tas50))
- Minor optimizations from Rubocop Performance [#653](https://github.com/chef/cookstyle/pull/653) ([tas50](https://github.com/tas50))
- Update Rubocop to 0.86 [#656](https://github.com/chef/cookstyle/pull/656) ([tas50](https://github.com/tas50))

## [v6.8.0](https://github.com/chef/cookstyle/tree/v6.8.0) (2020-06-08)

#### Merged Pull Requests
- Make sure we autocorrect to both provide and resource_name for Chef &lt; 16 [#647](https://github.com/chef/cookstyle/pull/647) ([tas50](https://github.com/tas50))
- Update to rubocop 0.85.1 [#650](https://github.com/chef/cookstyle/pull/650) ([tas50](https://github.com/tas50))
- Update resource_name/provides cops to detect new Chef 16.2+ behavior [#648](https://github.com/chef/cookstyle/pull/648) ([lamont-granquist](https://github.com/lamont-granquist))

## [v6.7.3](https://github.com/chef/cookstyle/tree/v6.7.3) (2020-06-02)

#### Merged Pull Requests
- Expand ChefModernize/IncludingMixinShelloutInResources to work in HWRPs [#643](https://github.com/chef/cookstyle/pull/643) ([tas50](https://github.com/tas50))
- Update RuboCop engine to 0.85 [#634](https://github.com/chef/cookstyle/pull/634) ([tas50](https://github.com/tas50))
- Improve a few specs [#645](https://github.com/chef/cookstyle/pull/645) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/ResourceUsesOnlyResourceName [#644](https://github.com/chef/cookstyle/pull/644) ([tas50](https://github.com/tas50))

## [v6.6.9](https://github.com/chef/cookstyle/tree/v6.6.9) (2020-05-27)

#### Merged Pull Requests
- Add new ChefCorrectness/LazyEvalNodeAttributeDefaults cop [#632](https://github.com/chef/cookstyle/pull/632) ([tas50](https://github.com/tas50))
- Minor update RELEASE_NOTES.md#cookstyle-62 [#633](https://github.com/chef/cookstyle/pull/633) ([vsingh-msys](https://github.com/vsingh-msys))
- Catch conditionals in ChefDeprecations/IncludingXMLRubyRecipe [#635](https://github.com/chef/cookstyle/pull/635) ([tas50](https://github.com/tas50))
- Add oracle as an invalid platform_family [#636](https://github.com/chef/cookstyle/pull/636) ([tas50](https://github.com/tas50))
- Add new ChefCorrectness/OpenSSLPasswordHelpers cop [#638](https://github.com/chef/cookstyle/pull/638) ([tas50](https://github.com/tas50))
- Detect package installs w/o an action in the multipackage cop [#637](https://github.com/chef/cookstyle/pull/637) ([tas50](https://github.com/tas50))
- Add new cops for incorrect platforms / platform families [#639](https://github.com/chef/cookstyle/pull/639) ([tas50](https://github.com/tas50))
- Add Cookstyle 6.6 release notes [#640](https://github.com/chef/cookstyle/pull/640) ([tas50](https://github.com/tas50))
- Add more styleguide links [#641](https://github.com/chef/cookstyle/pull/641) ([tas50](https://github.com/tas50))
- Add in the remaining styleguide links [#642](https://github.com/chef/cookstyle/pull/642) ([tas50](https://github.com/tas50))

## [v6.5.3](https://github.com/chef/cookstyle/tree/v6.5.3) (2020-05-19)

#### Merged Pull Requests
- mistyped name [#627](https://github.com/chef/cookstyle/pull/627) ([Xorima](https://github.com/Xorima))
- More cleanup of legacy ChefSpec/Fauxhai platforms [#628](https://github.com/chef/cookstyle/pull/628) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/Ruby27KeywordArgumentWarnings cop [#629](https://github.com/chef/cookstyle/pull/629) ([tas50](https://github.com/tas50))
- Add Cookstyle 6.5 release notes [#631](https://github.com/chef/cookstyle/pull/631) ([tas50](https://github.com/tas50))
- Add new ChefModernize/ShellOutHelper cop [#630](https://github.com/chef/cookstyle/pull/630) ([tas50](https://github.com/tas50))

## [v6.4.4](https://github.com/chef/cookstyle/tree/v6.4.4) (2020-05-12)

#### Merged Pull Requests
- Wire up the 5-stable branch [#612](https://github.com/chef/cookstyle/pull/612) ([tas50](https://github.com/tas50))
- Document the target chef version of each cop [#617](https://github.com/chef/cookstyle/pull/617) ([tas50](https://github.com/tas50))
- Remove double spaces after periods in documentation [#618](https://github.com/chef/cookstyle/pull/618) ([tas50](https://github.com/tas50))
- Update some descriptions [#619](https://github.com/chef/cookstyle/pull/619) ([tas50](https://github.com/tas50))
- Enable ChefModernize/FoodcriticComments by default [#622](https://github.com/chef/cookstyle/pull/622) ([tas50](https://github.com/tas50))
- Update RuboCop to 0.83 [#623](https://github.com/chef/cookstyle/pull/623) ([tas50](https://github.com/tas50))
- Support an edge case where the supports / manage_home value is a method [#624](https://github.com/chef/cookstyle/pull/624) ([tas50](https://github.com/tas50))
- Fix our files and vendor exclusion to work [#625](https://github.com/chef/cookstyle/pull/625) ([tas50](https://github.com/tas50))
- Add Cookstyle 6.4 release notes [#626](https://github.com/chef/cookstyle/pull/626) ([tas50](https://github.com/tas50))

## [v6.3.4](https://github.com/chef/cookstyle/tree/v6.3.4) (2020-04-16)

#### Merged Pull Requests
- Catch more offenses in ChefModernize/RespondToProvides [#605](https://github.com/chef/cookstyle/pull/605) ([tas50](https://github.com/tas50))
- Add new ChefModernize/RespondToCompileTime cop [#607](https://github.com/chef/cookstyle/pull/607) ([tas50](https://github.com/tas50))
- Update to RuboCop 0.82 engine [#608](https://github.com/chef/cookstyle/pull/608) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/DeprecatedShelloutMethods cop [#609](https://github.com/chef/cookstyle/pull/609) ([tas50](https://github.com/tas50))
- Add Cookstyle 6.3 notes [#610](https://github.com/chef/cookstyle/pull/610) ([tas50](https://github.com/tas50))
- Add a few missing shell_out methods [#611](https://github.com/chef/cookstyle/pull/611) ([tas50](https://github.com/tas50))

## [v6.2.9](https://github.com/chef/cookstyle/tree/v6.2.9) (2020-04-04)

#### Merged Pull Requests
- Fix a crash and false positive in ChefStyle/NegatingOnlyIf [#602](https://github.com/chef/cookstyle/pull/602) ([tas50](https://github.com/tas50))
- Improve ChefModernize/WhyRunSupportedTrue to detect a common typo [#603](https://github.com/chef/cookstyle/pull/603) ([tas50](https://github.com/tas50))
- Improve the LogResourceNotifications to tell when notify_group was introduced [#604](https://github.com/chef/cookstyle/pull/604) ([tas50](https://github.com/tas50))
- Fix typo in ChefRedundantCode/SensitivePropertyInResource warning [#606](https://github.com/chef/cookstyle/pull/606) ([tas50](https://github.com/tas50))

## [v6.2.5](https://github.com/chef/cookstyle/tree/v6.2.5) (2020-04-03)

#### Merged Pull Requests
- Add ChefRedundantCode/UseCreateIfMissing cop [#595](https://github.com/chef/cookstyle/pull/595) ([tas50](https://github.com/tas50))
- Update RuboCop to 0.81 [#596](https://github.com/chef/cookstyle/pull/596) ([tas50](https://github.com/tas50))
- Fix syntax on ChefCorrectness/IncorrectLibraryInjection. [#598](https://github.com/chef/cookstyle/pull/598) ([ncerny](https://github.com/ncerny))
- Add Chef version constraints to multiple deprecation cops [#600](https://github.com/chef/cookstyle/pull/600) ([tas50](https://github.com/tas50))
- Detect code that negates an only_if [#537](https://github.com/chef/cookstyle/pull/537) ([tas50](https://github.com/tas50))
- Add Cookstyle 6.2 notes [#601](https://github.com/chef/cookstyle/pull/601) ([tas50](https://github.com/tas50))

## [v6.1.6](https://github.com/chef/cookstyle/tree/v6.1.6) (2020-03-27)

#### Merged Pull Requests
- Add ChefCorrectness/ConditionalRubyShellout cop [#586](https://github.com/chef/cookstyle/pull/586) ([tas50](https://github.com/tas50))
- Move WindowsVersionHelper to ChefDeprecations &amp; add autocorrect [#587](https://github.com/chef/cookstyle/pull/587) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/PowershellCookbookHelpers [#588](https://github.com/chef/cookstyle/pull/588) ([tas50](https://github.com/tas50))
- Add ChefModernize/NodeRolesInclude rule [#589](https://github.com/chef/cookstyle/pull/589) ([tas50](https://github.com/tas50))
- Fix chef infra version in PowershellInstallWindowsFeature [#591](https://github.com/chef/cookstyle/pull/591) ([tas50](https://github.com/tas50))
- Add cops for resource / property descriptions [#590](https://github.com/chef/cookstyle/pull/590) ([tas50](https://github.com/tas50))
- Add Cookstyle 6.1 release notes [#593](https://github.com/chef/cookstyle/pull/593) ([tas50](https://github.com/tas50))

## [v6.0.19](https://github.com/chef/cookstyle/tree/v6.0.19) (2020-03-20)

#### Merged Pull Requests
- Move Cookstyle to the Chef Infra project [#538](https://github.com/chef/cookstyle/pull/538) ([tas50](https://github.com/tas50))
- Update RuboCop engine to 0.80.1 [#479](https://github.com/chef/cookstyle/pull/479) ([tas50](https://github.com/tas50))
- Disable the Naming/PredicateName [#552](https://github.com/chef/cookstyle/pull/552) ([tas50](https://github.com/tas50))
- Update ChefRedundant/UnnecessaryNameProperty to detect attributes [#551](https://github.com/chef/cookstyle/pull/551) ([tas50](https://github.com/tas50))
- Update DefaultActionFromInitialize to not care about variable order [#555](https://github.com/chef/cookstyle/pull/555) ([tas50](https://github.com/tas50))
- Enable ChefStyle/UnnecessaryOSCheck [#573](https://github.com/chef/cookstyle/pull/573) ([tas50](https://github.com/tas50))
- Add autocorrection to ChefCorrectness/DnfPackageAllowDowngrades [#571](https://github.com/chef/cookstyle/pull/571) ([tas50](https://github.com/tas50))
- Update ChefModernize/PowerShellGuardInterpreter to look at all resources [#572](https://github.com/chef/cookstyle/pull/572) ([tas50](https://github.com/tas50))
- Add ChefCorrectness/ChefApplicationFatal cop [#570](https://github.com/chef/cookstyle/pull/570) ([tas50](https://github.com/tas50))
- Add new cop ChefModernize/UseMultipackageInstalls [#553](https://github.com/chef/cookstyle/pull/553) ([tas50](https://github.com/tas50))
- Detect the short form the of registry key in ChefModernize/WindowsRegistryUAC [#575](https://github.com/chef/cookstyle/pull/575) ([tas50](https://github.com/tas50))
- Add ChefCorrectness/PowershellScriptDeleteFile [#576](https://github.com/chef/cookstyle/pull/576) ([tas50](https://github.com/tas50))
- Add ChefModernize/ProvidesFromInitialize cop [#574](https://github.com/chef/cookstyle/pull/574) ([tas50](https://github.com/tas50))
- Add ChefModernize/DatabagHelpers [#577](https://github.com/chef/cookstyle/pull/577) ([tas50](https://github.com/tas50))
- Allow arrays in match_property_in_resource and fix powershell interp cop [#578](https://github.com/chef/cookstyle/pull/578) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/DeprecatedWindowsVersionCheck check [#580](https://github.com/chef/cookstyle/pull/580) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/ChefWindowsPlatformHelper cop [#581](https://github.com/chef/cookstyle/pull/581) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/LogResourceNotifications cop [#583](https://github.com/chef/cookstyle/pull/583) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/ResourceWithoutNameOrProvides cop [#584](https://github.com/chef/cookstyle/pull/584) ([tas50](https://github.com/tas50))
- Update the severity for all deprecation cops to be :warning [#585](https://github.com/chef/cookstyle/pull/585) ([tas50](https://github.com/tas50))
- Add release notes for Cookstyle 6 [#582](https://github.com/chef/cookstyle/pull/582) ([tas50](https://github.com/tas50))

## [v5.22.6](https://github.com/chef/cookstyle/tree/v5.22.6) (2020-02-28)

#### Merged Pull Requests
- Add ChefModernize/UseRequireRelative [#535](https://github.com/chef/cookstyle/pull/535) ([tas50](https://github.com/tas50))
- Use node[&#39;init_package&#39;] to detect systemd [#536](https://github.com/chef/cookstyle/pull/536) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/WindowsFeatureServermanagercmd [#541](https://github.com/chef/cookstyle/pull/541) ([tas50](https://github.com/tas50))
- Revert &quot;Match on attributes in TrueClassFalseClassResourceProperties&quot; [#542](https://github.com/chef/cookstyle/pull/542) ([tas50](https://github.com/tas50))
- Add ChefModernize/WindowsRegistryUAC cop [#540](https://github.com/chef/cookstyle/pull/540) ([tas50](https://github.com/tas50))
- Detect more apt-get update scenarios [#546](https://github.com/chef/cookstyle/pull/546) ([tas50](https://github.com/tas50))
- Disable Naming/MethodName and Naming/VariableName [#545](https://github.com/chef/cookstyle/pull/545) ([tas50](https://github.com/tas50))

## [v5.21.9](https://github.com/chef/cookstyle/tree/v5.21.9) (2020-02-19)

#### Merged Pull Requests
- Disable Style/ModuleFunction [#517](https://github.com/chef/cookstyle/pull/517) ([tas50](https://github.com/tas50))
- Set the target ruby version to 2.3 to support Chef 12 [#518](https://github.com/chef/cookstyle/pull/518) ([tas50](https://github.com/tas50))
- Make sure metadata cops properly autocorrect heredocs [#520](https://github.com/chef/cookstyle/pull/520) ([tas50](https://github.com/tas50))
- Remove the duplicate Style/ModuleFunction config [#521](https://github.com/chef/cookstyle/pull/521) ([tas50](https://github.com/tas50))
- Expand ChefStyle/UsePlatformHelpers to also detect node[&#39;platform&#39;].eql? [#523](https://github.com/chef/cookstyle/pull/523) ([tas50](https://github.com/tas50))
- Autocorrect Layout/EndAlignment and Layout/DefEndAlignment [#529](https://github.com/chef/cookstyle/pull/529) ([tas50](https://github.com/tas50))
- Autocorrect &#39;apache v2&#39; to &#39;Apache-2.0&#39; [#530](https://github.com/chef/cookstyle/pull/530) ([tas50](https://github.com/tas50))
- Don&#39;t fail ChefDeprecations/WindowsTaskChangeAction with a non-string action [#531](https://github.com/chef/cookstyle/pull/531) ([tas50](https://github.com/tas50))
- Fix IncludingYumDNFCompatRecipe to not break with inline conditionals [#532](https://github.com/chef/cookstyle/pull/532) ([tas50](https://github.com/tas50))
- Add 3 new cops [#522](https://github.com/chef/cookstyle/pull/522) ([tas50](https://github.com/tas50))
- Add new ChefStyle/UnnecessaryOSCheck cop [#524](https://github.com/chef/cookstyle/pull/524) ([tas50](https://github.com/tas50))

## [v5.20.0](https://github.com/chef/cookstyle/tree/v5.20.0) (2020-01-24)

#### Merged Pull Requests
- Add Style/ChefWhaaat cop [#507](https://github.com/chef/cookstyle/pull/507) ([tas50](https://github.com/tas50))
- Add autocorrect to libarchive_file resources [#509](https://github.com/chef/cookstyle/pull/509) ([tas50](https://github.com/tas50))
- Catch shelling out to sysctl when using the full path [#510](https://github.com/chef/cookstyle/pull/510) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/DeprecatedChefSpecPlatform [#511](https://github.com/chef/cookstyle/pull/511) ([tas50](https://github.com/tas50))
- Fix autocorrection failures in ChefDeprecations/ChefHandlerUsesSupports [#508](https://github.com/chef/cookstyle/pull/508) ([tas50](https://github.com/tas50))

## [v5.19.9](https://github.com/chef/cookstyle/tree/v5.19.9) (2020-01-13)

#### Merged Pull Requests
- Update metadata.rb cops to not leave empty lines behind [#487](https://github.com/chef/cookstyle/pull/487) ([tas50](https://github.com/tas50))
- Properly cleanup heredoc long_description metadata [#488](https://github.com/chef/cookstyle/pull/488) ([tas50](https://github.com/tas50))
- Add ChefRedundantCode/GroupingMetadata [#489](https://github.com/chef/cookstyle/pull/489) ([tas50](https://github.com/tas50))
- Better trim metadata.rb whitespace [#490](https://github.com/chef/cookstyle/pull/490) ([tas50](https://github.com/tas50))
- Remove more empty lines in autocorrection [#491](https://github.com/chef/cookstyle/pull/491) ([tas50](https://github.com/tas50))
- Handle user resource supports with hash rockets [#493](https://github.com/chef/cookstyle/pull/493) ([tas50](https://github.com/tas50))
- Fix ChefStyle/FileMode to autocorrect single quotes [#494](https://github.com/chef/cookstyle/pull/494) ([tas50](https://github.com/tas50))
- Add ChefStyle/OverlyComplexSupportsDependsMetadata [#495](https://github.com/chef/cookstyle/pull/495) ([tas50](https://github.com/tas50))
- Add clarity to License Strings [#501](https://github.com/chef/cookstyle/pull/501) ([Xorima](https://github.com/Xorima))
- Additional fixes for ChefDeprecations/UserDeprecatedSupportsProperty [#502](https://github.com/chef/cookstyle/pull/502) ([tas50](https://github.com/tas50))
- Fix false positives in ChefModernize/AllowedActionsFromInitialize [#503](https://github.com/chef/cookstyle/pull/503) ([tas50](https://github.com/tas50))
- Avoid false positives in ChefModernize/DefaultActionFromInitialize [#504](https://github.com/chef/cookstyle/pull/504) ([tas50](https://github.com/tas50))

## [v5.18.4](https://github.com/chef/cookstyle/tree/v5.18.4) (2020-01-03)

#### Merged Pull Requests
- Test on Ruby 2.7 + other minor testing updates [#477](https://github.com/chef/cookstyle/pull/477) ([tas50](https://github.com/tas50))
- Improve property cops [#478](https://github.com/chef/cookstyle/pull/478) ([tas50](https://github.com/tas50))
- Match on attributes in TrueClassFalseClassResourceProperties [#480](https://github.com/chef/cookstyle/pull/480) ([tas50](https://github.com/tas50))
- Better exclude the files / vendor directories [#481](https://github.com/chef/cookstyle/pull/481) ([tas50](https://github.com/tas50))
- Add ChefModernize/ResourceForcingCompileTime [#482](https://github.com/chef/cookstyle/pull/482) ([tas50](https://github.com/tas50))
- Add 5.18 release notes [#484](https://github.com/chef/cookstyle/pull/484) ([tas50](https://github.com/tas50))
- Add ChefModernize/ExecuteSysctl cop [#483](https://github.com/chef/cookstyle/pull/483) ([tas50](https://github.com/tas50))

## [v5.17.4](https://github.com/chef/cookstyle/tree/v5.17.4) (2019-12-21)

#### Merged Pull Requests
- Add ChefModernize/DslIncludeInResource [#470](https://github.com/chef/cookstyle/pull/470) ([tas50](https://github.com/tas50))
- Add Powershell mixins to ChefModernize/IncludingMixinShelloutInResources [#469](https://github.com/chef/cookstyle/pull/469) ([tas50](https://github.com/tas50))
- Handle supports metadata in an array [#473](https://github.com/chef/cookstyle/pull/473) ([tas50](https://github.com/tas50))
- Add 2 new cops for removing redundant config in apt_repository [#472](https://github.com/chef/cookstyle/pull/472) ([tas50](https://github.com/tas50))
- Fix .start_with? errors on Ruby 2.4 [#474](https://github.com/chef/cookstyle/pull/474) ([tas50](https://github.com/tas50))
- Substitute require for require_relative [#476](https://github.com/chef/cookstyle/pull/476) ([tas50](https://github.com/tas50))

## [v5.16.11](https://github.com/chef/cookstyle/tree/v5.16.11) (2019-12-17)

#### Merged Pull Requests
- Enable several cops that were accidently disabled [#468](https://github.com/chef/cookstyle/pull/468) ([tas50](https://github.com/tas50))

## [v5.16.10](https://github.com/chef/cookstyle/tree/v5.16.10) (2019-12-17)

#### Merged Pull Requests
- Add new TargetChefVersion config option [#419](https://github.com/chef/cookstyle/pull/419) ([tas50](https://github.com/tas50))
- Add a cop for removing legacy Foodcritic comments [#446](https://github.com/chef/cookstyle/pull/446) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/RubyBlockCreateAction cop [#449](https://github.com/chef/cookstyle/pull/449) ([tas50](https://github.com/tas50))
- Add ChefStyle/UnnecessaryPlatformCaseStatements [#448](https://github.com/chef/cookstyle/pull/448) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/DeprecatedPlatformMethods [#450](https://github.com/chef/cookstyle/pull/450) ([tas50](https://github.com/tas50))
- Support checking both notifies and subscribes properties in cops [#451](https://github.com/chef/cookstyle/pull/451) ([tas50](https://github.com/tas50))
- Add ChefCorrectness/InvalidNotificationTiming cop [#454](https://github.com/chef/cookstyle/pull/454) ([tas50](https://github.com/tas50))
- Add ChefStyle/ImmediateNotificationTiming cop [#453](https://github.com/chef/cookstyle/pull/453) ([tas50](https://github.com/tas50))
- Add ChefRedundantCode/SensitivePropertyInResource cop [#457](https://github.com/chef/cookstyle/pull/457) ([tas50](https://github.com/tas50))
- Improve the cops that check properties / attributes [#458](https://github.com/chef/cookstyle/pull/458) ([tas50](https://github.com/tas50))
- Detect additional ways of checking platform / platform_family with node data [#456](https://github.com/chef/cookstyle/pull/456) ([tas50](https://github.com/tas50))
- Add ChefCorrectness/MalformedPlatformValueForPlatformHelper cop [#459](https://github.com/chef/cookstyle/pull/459) ([tas50](https://github.com/tas50))
- Add ChefCorrectness/DnfPackageAllowDowngrades [#452](https://github.com/chef/cookstyle/pull/452) ([tas50](https://github.com/tas50))
- Speed up Cookstyle by excluding more files [#460](https://github.com/chef/cookstyle/pull/460) ([tas50](https://github.com/tas50))
- Add 5 new cops for the 5.16 release [#462](https://github.com/chef/cookstyle/pull/462) ([tas50](https://github.com/tas50))
- Handle additional scenarios of platform checks [#464](https://github.com/chef/cookstyle/pull/464) ([tas50](https://github.com/tas50))
- Add additional release notes for 5.16 [#465](https://github.com/chef/cookstyle/pull/465) ([tas50](https://github.com/tas50))

## [v5.15.7](https://github.com/chef/cookstyle/tree/v5.15.7) (2019-12-11)

#### Merged Pull Requests
- Add new rubygems metadata [#425](https://github.com/chef/cookstyle/pull/425) ([tas50](https://github.com/tas50))
- Move the metadata cops to ChefModernize [#426](https://github.com/chef/cookstyle/pull/426) ([tas50](https://github.com/tas50))
- Add a new ChefRedundantCode and ChefSharing cop groups [#428](https://github.com/chef/cookstyle/pull/428) ([tas50](https://github.com/tas50))
- Add ChefCorrectness/InvalidPlatformHelper and ChefCorrectness/InvalidPlatformFamilyHelper [#430](https://github.com/chef/cookstyle/pull/430) ([tas50](https://github.com/tas50))
- Add ChefCorrectness/ScopedFileExist cop [#432](https://github.com/chef/cookstyle/pull/432) ([tas50](https://github.com/tas50))
- Update ChefModernize/LegacyBerksfileSource to detect REALLY old configs [#434](https://github.com/chef/cookstyle/pull/434) ([tas50](https://github.com/tas50))
- Detect @default_action in the initializer as well [#435](https://github.com/chef/cookstyle/pull/435) ([tas50](https://github.com/tas50))
- Don&#39;t detect poise resources in CustomResourceWithAllowedActions [#439](https://github.com/chef/cookstyle/pull/439) ([tas50](https://github.com/tas50))
- Rework how we autocorrect allowed actions [#436](https://github.com/chef/cookstyle/pull/436) ([tas50](https://github.com/tas50))
- Move invalid platform constants into a single helper [#440](https://github.com/chef/cookstyle/pull/440) ([tas50](https://github.com/tas50))
- Add more invalid platform families to our helper [#444](https://github.com/chef/cookstyle/pull/444) ([tas50](https://github.com/tas50))
- Add new platform cops for the value_for_platform / value_for_platform_family helpers [#445](https://github.com/chef/cookstyle/pull/445) ([tas50](https://github.com/tas50))

## [v5.14.1](https://github.com/chef/cookstyle/tree/v5.14.1) (2019-12-06)

#### Merged Pull Requests
- Add new ChefDeprecations/ChefRewind cop [#422](https://github.com/chef/cookstyle/pull/422) ([tas50](https://github.com/tas50))
- Add new ChefModernize/ChefGemNokogiri cop [#421](https://github.com/chef/cookstyle/pull/421) ([tas50](https://github.com/tas50))
- Improve IncludingMixinShelloutInResources cops message to include Chef Versions [#423](https://github.com/chef/cookstyle/pull/423) ([tas50](https://github.com/tas50))
- Expand ChefDeprecations/UsesRunCommandHelper to catch more cases [#424](https://github.com/chef/cookstyle/pull/424) ([tas50](https://github.com/tas50))

## [v5.13.7](https://github.com/chef/cookstyle/tree/v5.13.7) (2019-11-21)

#### Merged Pull Requests
- DefaultActionFromInitialize: don&#39;t insert dupe default_action [#410](https://github.com/chef/cookstyle/pull/410) ([tas50](https://github.com/tas50))
- Add ChefModernize/EmptyResourceInitializeMethod cop [#411](https://github.com/chef/cookstyle/pull/411) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/LegacyNotifySyntax [#412](https://github.com/chef/cookstyle/pull/412) ([tas50](https://github.com/tas50))
- Adding correctable info to json formatter [#413](https://github.com/chef/cookstyle/pull/413) ([tyler-ball](https://github.com/tyler-ball))
- Improve auto correction in LegacyNotifySyntax [#415](https://github.com/chef/cookstyle/pull/415) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/NodeSetWithoutLevel cop [#416](https://github.com/chef/cookstyle/pull/416) ([tas50](https://github.com/tas50))
- Add Ruby 2.7 testing in Buildkite [#417](https://github.com/chef/cookstyle/pull/417) ([tas50](https://github.com/tas50))
- Cache the bundles in S3 to speed up tests [#418](https://github.com/chef/cookstyle/pull/418) ([tas50](https://github.com/tas50))
- Add Cookstyle 5.13 notes [#414](https://github.com/chef/cookstyle/pull/414) ([tas50](https://github.com/tas50))

## [v5.12.13](https://github.com/chef/cookstyle/tree/v5.12.13) (2019-11-14)

#### Merged Pull Requests
- Readme updates to trigger a new build [#409](https://github.com/chef/cookstyle/pull/409) ([tas50](https://github.com/tas50))

## [v5.12.12](https://github.com/chef/cookstyle/tree/v5.12.12) (2019-11-14)

#### Merged Pull Requests
- Update the readme cop count on each merge [#388](https://github.com/chef/cookstyle/pull/388) ([tas50](https://github.com/tas50))
- Add ChefModernize/IfProvidesDefaultAction cop [#389](https://github.com/chef/cookstyle/pull/389) ([tas50](https://github.com/tas50))
- Add ChefStyle/DefaultCopyrightComments [#393](https://github.com/chef/cookstyle/pull/393) ([tas50](https://github.com/tas50))
- Add ChefModernize/ZipfileResource [#392](https://github.com/chef/cookstyle/pull/392) ([tas50](https://github.com/tas50))
- Autocorrect node[&#39;platform&#39;] != to platform?() helpers [#391](https://github.com/chef/cookstyle/pull/391) ([tas50](https://github.com/tas50))
- Handle non modifier if statements in ChefModernize/RespondToInMetadata [#396](https://github.com/chef/cookstyle/pull/396) ([tas50](https://github.com/tas50))
- Add ChefCorrectness/ResourceWithNothingAction cop [#399](https://github.com/chef/cookstyle/pull/399) ([tas50](https://github.com/tas50))
- Add ChefEffortless/Berksfile [#398](https://github.com/chef/cookstyle/pull/398) ([tas50](https://github.com/tas50))
- Allow # cookstyle comments in addition to # rubocop comments [#400](https://github.com/chef/cookstyle/pull/400) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/Cheffile [#397](https://github.com/chef/cookstyle/pull/397) ([tas50](https://github.com/tas50))
- add cops for chef-sugar&#39;s node.deep_fetch [#402](https://github.com/chef/cookstyle/pull/402) ([lamont-granquist](https://github.com/lamont-granquist))
- Add ChefModernize/UnnecessaryMixlibShelloutRequire [#403](https://github.com/chef/cookstyle/pull/403) ([tas50](https://github.com/tas50))
- Detect run_command_with_systems_locale in ChefDeprecations/UsesRunCommandHelper [#407](https://github.com/chef/cookstyle/pull/407) ([tas50](https://github.com/tas50))
- Add Cookstyle 5.12 release notes [#404](https://github.com/chef/cookstyle/pull/404) ([tas50](https://github.com/tas50))

## [v5.11.0](https://github.com/chef/cookstyle/tree/v5.11.0) (2019-11-08)

#### Merged Pull Requests
- Add additional helpers for working with resources [#310](https://github.com/chef/cookstyle/pull/310) ([tas50](https://github.com/tas50))
- Fix docs updater script to work with Rubocop 0.75+ [#361](https://github.com/chef/cookstyle/pull/361) ([tas50](https://github.com/tas50))
- Add new poise_archive cop and definition cop [#362](https://github.com/chef/cookstyle/pull/362) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/PartialSearchHelperUsage [#363](https://github.com/chef/cookstyle/pull/363) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/SearchUsesPositionalParameters: [#366](https://github.com/chef/cookstyle/pull/366) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/PartialSearchClassUsage [#367](https://github.com/chef/cookstyle/pull/367) ([tas50](https://github.com/tas50))
- Add ChefEffortless/SearchForEnvironmentsOrRoles [#368](https://github.com/chef/cookstyle/pull/368) ([tas50](https://github.com/tas50))
- Fix the description of ChefModernize/UseBuildEssentialResource [#386](https://github.com/chef/cookstyle/pull/386) ([tas50](https://github.com/tas50))
- RespondToInMetadata: Catch if defined in metadata as well [#385](https://github.com/chef/cookstyle/pull/385) ([tas50](https://github.com/tas50))
- Add 5.11 release notes [#384](https://github.com/chef/cookstyle/pull/384) ([tas50](https://github.com/tas50))

## [v5.10.13](https://github.com/chef/cookstyle/tree/v5.10.13) (2019-10-25)

#### Merged Pull Requests
- Detect poise-service in addition to just poise [#353](https://github.com/chef/cookstyle/pull/353) ([tas50](https://github.com/tas50))
- Fix the files we target with NotifiesActionNotSymbol &amp; IncorrectLibraryInjection [#357](https://github.com/chef/cookstyle/pull/357) ([tas50](https://github.com/tas50))

## [v5.10.11](https://github.com/chef/cookstyle/tree/v5.10.11) (2019-10-24)

#### Merged Pull Requests
- Add ChefCorrectness/NotifiesActionNotSymbol cop [#335](https://github.com/chef/cookstyle/pull/335) ([tas50](https://github.com/tas50))
- Expand ChefModernize/CustomResourceWithAllowedActions to work in HWRPs [#334](https://github.com/chef/cookstyle/pull/334) ([tas50](https://github.com/tas50))
- Add ChefCorrectness/IncorrectLibraryInjection cop [#338](https://github.com/chef/cookstyle/pull/338) ([tas50](https://github.com/tas50))
- Add 3 new cops for migrating to Effortless [#337](https://github.com/chef/cookstyle/pull/337) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/LegacyYumRepositoryProperties [#343](https://github.com/chef/cookstyle/pull/343) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/EOLAuditModeUsage [#344](https://github.com/chef/cookstyle/pull/344) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/ResourceInheritsFromCompatResource [#340](https://github.com/chef/cookstyle/pull/340) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/VerifyPropertyUsesFileExpansion cop [#339](https://github.com/chef/cookstyle/pull/339) ([tas50](https://github.com/tas50))
- Add Cookstyle 5.10 release notes [#347](https://github.com/chef/cookstyle/pull/347) ([tas50](https://github.com/tas50))
- Expand what we detect in ChefModernize/CustomResourceWithAllowedActions [#345](https://github.com/chef/cookstyle/pull/345) ([tas50](https://github.com/tas50))
- Add ChefModernize/DefaultActionFromInitialize and ChefModernize/ResourceNameFromInitialize: [#348](https://github.com/chef/cookstyle/pull/348) ([tas50](https://github.com/tas50))
- Expand the detection of node.chef_environment [#349](https://github.com/chef/cookstyle/pull/349) ([tas50](https://github.com/tas50))

## [v5.9.3](https://github.com/chef/cookstyle/tree/v5.9.3) (2019-10-16)

#### Merged Pull Requests
- Add Cookstyle 5.8 release notes [#319](https://github.com/chef/cookstyle/pull/319) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/UsesRunCommandHelper cop [#327](https://github.com/chef/cookstyle/pull/327) ([tas50](https://github.com/tas50))
- Add a better description to the gem [#328](https://github.com/chef/cookstyle/pull/328) ([tas50](https://github.com/tas50))
- Add ChefModernize/PowerShellGuardInterpreter cop [#329](https://github.com/chef/cookstyle/pull/329) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/ChefHandlerUsesSupports [#326](https://github.com/chef/cookstyle/pull/326) ([tas50](https://github.com/tas50))
- Fix ChefModernize/UnnecessaryDependsChef14 to detect version constraints [#325](https://github.com/chef/cookstyle/pull/325) ([tas50](https://github.com/tas50))

## [v5.8.1](https://github.com/chef/cookstyle/tree/v5.8.1) (2019-10-12)

#### Merged Pull Requests
- Update CustomResourceWithAllowedActions to trigger on LWRPs as well [#305](https://github.com/chef/cookstyle/pull/305) ([tas50](https://github.com/tas50))
- Auto generate the docs with expeditor on PR merge [#311](https://github.com/chef/cookstyle/pull/311) ([tas50](https://github.com/tas50))
- Reformat text comments for better docs [#312](https://github.com/chef/cookstyle/pull/312) ([tas50](https://github.com/tas50))
- Catch use_inline_resources if respond_to?(:use_inline_resources) [#318](https://github.com/chef/cookstyle/pull/318) ([tas50](https://github.com/tas50))
- Add autocorrection to ChefDeprecations/UserDeprecatedSupportsProperty [#317](https://github.com/chef/cookstyle/pull/317) ([tas50](https://github.com/tas50))
-  Add ChefCorrectness/UnnecessaryNameProperty [#316](https://github.com/chef/cookstyle/pull/316) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/ChefSpecCoverageReport &amp; ChefDeprecations/ChefSpecLegacyRunner cops [#306](https://github.com/chef/cookstyle/pull/306) ([tas50](https://github.com/tas50))
- Simplify ChefDeprecations/LongDescriptionMetadata [#308](https://github.com/chef/cookstyle/pull/308) ([tas50](https://github.com/tas50))
- Add ChefStyle/SimplifyPlatformMajorVersionCheck [#315](https://github.com/chef/cookstyle/pull/315) ([tas50](https://github.com/tas50))
- Add ChefCorrectness/EmptyMetadataField cop [#313](https://github.com/chef/cookstyle/pull/313) ([tas50](https://github.com/tas50))
- Add ChefCorrectness/InvalidVersionMetadata cop [#309](https://github.com/chef/cookstyle/pull/309) ([tas50](https://github.com/tas50))

## [v5.7.0](https://github.com/chef/cookstyle/tree/v5.7.0) (2019-10-04)

#### Merged Pull Requests
- Add 5 more cops for LWRP deprecations in Chef 13 [#296](https://github.com/chef/cookstyle/pull/296) ([tas50](https://github.com/tas50))

## [v5.6.5](https://github.com/chef/cookstyle/tree/v5.6.5) (2019-10-02)

#### Merged Pull Requests
- Add release notes for 5.6 [#293](https://github.com/chef/cookstyle/pull/293) ([tas50](https://github.com/tas50))
- Fix autocorrection of multiple platform helpers in a recipe [#303](https://github.com/chef/cookstyle/pull/303) ([tas50](https://github.com/tas50))
- Remove the newline when autocorrecting long_description in metadata [#304](https://github.com/chef/cookstyle/pull/304) ([tas50](https://github.com/tas50))

## [v5.6.2](https://github.com/chef/cookstyle/tree/v5.6.2) (2019-09-16)

#### Merged Pull Requests
- Add ChefDeprecations/WindowsTaskChangeAction [#288](https://github.com/chef/cookstyle/pull/288) ([tas50](https://github.com/tas50))
- Add ChefDeprecations/RecipeMetadata cop [#287](https://github.com/chef/cookstyle/pull/287) ([tas50](https://github.com/tas50))
- Add ChefStyle/UsePlatformHelpers cop [#286](https://github.com/chef/cookstyle/pull/286) ([tas50](https://github.com/tas50))
- Add 9 new cops for updating to resources in Chef Infra Client  [#289](https://github.com/chef/cookstyle/pull/289) ([tas50](https://github.com/tas50))
- Add autocorrects to 7 cops [#290](https://github.com/chef/cookstyle/pull/290) ([tas50](https://github.com/tas50))

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