# Cookstyle Changelog

 <!-- latest_release -->
<!-- latest_release -->

<!-- release_rollup -->
<!-- release_rollup -->

<!-- latest_stable_release -->
## [v6.2.5](https://github.com/chef/cookstyle/tree/v6.2.5) (2020-04-03)

#### Merged Pull Requests
- Add ChefRedundantCode/UseCreateIfMissing cop [#595](https://github.com/chef/cookstyle/pull/595) ([tas50](https://github.com/tas50))
- Update RuboCop to 0.81 [#596](https://github.com/chef/cookstyle/pull/596) ([tas50](https://github.com/tas50))
- Fix syntax on ChefCorrectness/IncorrectLibraryInjection. [#598](https://github.com/chef/cookstyle/pull/598) ([ncerny](https://github.com/ncerny))
- Add Chef version constraints to multiple deprecation cops [#600](https://github.com/chef/cookstyle/pull/600) ([tas50](https://github.com/tas50))
- Detect code that negates an only_if [#537](https://github.com/chef/cookstyle/pull/537) ([tas50](https://github.com/tas50))
- Add Cookstyle 6.2 notes [#601](https://github.com/chef/cookstyle/pull/601) ([tas50](https://github.com/tas50))
<!-- latest_stable_release -->

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