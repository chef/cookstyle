# frozen_string_literal: true
#
# Copyright:: 2026, Tim Smith
# Author:: Tim Smith (<tsmith84@proton.me>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
module RuboCop
  module Cop
    # Registers the Chef Infra and Chefstyle cops for lazy loading. Each cop's file is
    # loaded only when the cop class is actually needed, which keeps `require "cookstyle"`
    # from paying for every cop on every run. The registration order matches the order the
    # files were previously required in, so cop execution order is unchanged.
    module Chef
      # The Chef/Correctness department.
      module Correctness
        extend LazyLoader

        register_cop :BlockGuardWithOnlyString, "#{__dir__}/chef/correctness/block_guard_clause_string_only"
        register_cop :ChefApplicationFatal, "#{__dir__}/chef/correctness/chef_application_fatal"
        register_cop :ConditionalRubyShellout, "#{__dir__}/chef/correctness/conditional_ruby_shellout"
        register_cop :ConditionalUnifiedModeTrue, "#{__dir__}/chef/correctness/conditional_unified_mode_true"
        register_cop :DnfPackageAllowDowngrades, "#{__dir__}/chef/correctness/dnf_package_allow_downgrades"
        register_cop :EmptyResourceGuard, "#{__dir__}/chef/correctness/empty_resource_guard"
        register_cop :ExecuteDeleteFile, "#{__dir__}/chef/correctness/execute_delete_file"
        register_cop :IncorrectLibraryInjection, "#{__dir__}/chef/correctness/incorrect_library_injection"
        register_cop :InvalidChecksum, "#{__dir__}/chef/correctness/invalid_checksum"
        register_cop :InvalidCookbookName, "#{__dir__}/chef/correctness/invalid_cookbook_name"
        register_cop :InvalidDefaultAction, "#{__dir__}/chef/correctness/invalid_default_action"
        register_cop :InvalidNotificationResource, "#{__dir__}/chef/correctness/invalid_notification_resource"
        register_cop :InvalidNotificationTiming, "#{__dir__}/chef/correctness/invalid_notification_timing"
        register_cop :InvalidPlatformFamilyHelper, "#{__dir__}/chef/correctness/invalid_platform_family_helper"
        register_cop :InvalidPlatformFamilyInCase, "#{__dir__}/chef/correctness/invalid_platform_family_values_in_case"
        register_cop :InvalidPlatformHelper, "#{__dir__}/chef/correctness/invalid_platform_helper"
        register_cop :InvalidPlatformMetadata, "#{__dir__}/chef/correctness/invalid_platform_metadata"
        register_cop :InvalidPlatformInCase, "#{__dir__}/chef/correctness/invalid_platform_values_in_case"
        register_cop :InvalidPlatformValueForPlatformFamilyHelper, "#{__dir__}/chef/correctness/invalid_value_for_platform_family_helper"
        register_cop :InvalidPlatformValueForPlatformHelper, "#{__dir__}/chef/correctness/invalid_value_for_platform_helper"
        register_cop :InvalidVersionMetadata, "#{__dir__}/chef/correctness/invalid_version_metadata"
        register_cop :LazyEvalNodeAttributeDefaults, "#{__dir__}/chef/correctness/lazy_eval_node_attribute_defaults"
        register_cop :LazyInResourceGuard, "#{__dir__}/chef/correctness/lazy_in_resource_guard"
        register_cop :MacosUserdefaultsInvalidType, "#{__dir__}/chef/correctness/macos_userdefaults_invalid_type"
        register_cop :MalformedPlatformValueForPlatformHelper, "#{__dir__}/chef/correctness/malformed_value_for_platform"
        register_cop :MetadataMalformedDepends, "#{__dir__}/chef/correctness/metadata_malformed_version"
        register_cop :MetadataMissingName, "#{__dir__}/chef/correctness/metadata_missing_name"
        register_cop :MetadataMissingVersion, "#{__dir__}/chef/correctness/metadata_missing_version"
        register_cop :NodeNormal, "#{__dir__}/chef/correctness/node_normal"
        register_cop :NodeNormalUnless, "#{__dir__}/chef/correctness/node_normal_unless"
        register_cop :CookbookUsesNodeSave, "#{__dir__}/chef/correctness/node_save"
        register_cop :NotifiesActionNotSymbol, "#{__dir__}/chef/correctness/notifies_action_not_symbol"
        register_cop :OctalModeAsString, "#{__dir__}/chef/correctness/octal_mode_as_string"
        register_cop :OpenSSLPasswordHelpers, "#{__dir__}/chef/correctness/openssl_password_helpers"
        register_cop :PlatformVersionStringComparison, "#{__dir__}/chef/correctness/platform_version_string_comparison"
        register_cop :PowershellScriptDeleteFile, "#{__dir__}/chef/correctness/powershell_delete_file"
        register_cop :PowershellFileExists, "#{__dir__}/chef/correctness/powershell_file_exists"
        register_cop :PropertyWithoutType, "#{__dir__}/chef/correctness/property_without_type"
        register_cop :ResourceSetsInternalProperties, "#{__dir__}/chef/correctness/resource_sets_internal_properties"
        register_cop :ResourceSetsNameProperty, "#{__dir__}/chef/correctness/resource_sets_name_property"
        register_cop :ResourceWithNoneAction, "#{__dir__}/chef/correctness/resource_with_none_action"
        register_cop :RubyGuardWithoutBlock, "#{__dir__}/chef/correctness/ruby_guard_without_block"
        register_cop :ScopedFileExist, "#{__dir__}/chef/correctness/scoped_file_exist"
        register_cop :ServiceResource, "#{__dir__}/chef/correctness/service_resource"
        register_cop :SupportsMustBeFloat, "#{__dir__}/chef/correctness/supports_must_be_float"
        register_cop :TmpPath, "#{__dir__}/chef/correctness/tmp_path"
      end

      # The Chef/Deprecations department.
      module Deprecations
        extend LazyLoader

        register_cop :CookbooksDependsOnSelf, "#{__dir__}/chef/deprecation/cb_depends_on_self"
        register_cop :ChefHandlerRecipe, "#{__dir__}/chef/deprecation/chef_handler_recipe"
        register_cop :ChefHandlerUsesSupports, "#{__dir__}/chef/deprecation/chef_handler_supports"
        register_cop :UsesChefRESTHelpers, "#{__dir__}/chef/deprecation/chef_rest"
        register_cop :ChefRewind, "#{__dir__}/chef/deprecation/chef_rewind"
        register_cop :ChefShellout, "#{__dir__}/chef/deprecation/chef_shellout"
        register_cop :ChefSugarHelpers, "#{__dir__}/chef/deprecation/chef_sugar_helpers"
        register_cop :ChefWindowsPlatformHelper, "#{__dir__}/chef/deprecation/chef_windows_platform_helper"
        register_cop :ChefDKGenerators, "#{__dir__}/chef/deprecation/chefdk_generators"
        register_cop :Cheffile, "#{__dir__}/chef/deprecation/cheffile"
        register_cop :ChefSpecCoverageReport, "#{__dir__}/chef/deprecation/chefspec_coverage_report"
        register_cop :ChefSpecLegacyRunner, "#{__dir__}/chef/deprecation/chefspec_legacy_runner"
        register_cop :ChocolateyPackageUninstallAction, "#{__dir__}/chef/deprecation/chocolatey_package_uninstall_action"
        register_cop :Delivery, "#{__dir__}/chef/deprecation/delivery"
        register_cop :DependsOnChefNginxCookbook, "#{__dir__}/chef/deprecation/depends_chef_nginx_cookbook"
        register_cop :DependsOnChefReportingCookbook, "#{__dir__}/chef/deprecation/depends_chef_reporting_cookbook"
        register_cop :CookbookDependsOnCompatResource, "#{__dir__}/chef/deprecation/depends_compat_resource"
        register_cop :DependsOnOmnibusUpdaterCookbook, "#{__dir__}/chef/deprecation/depends_omnibus_updater_cookbook"
        register_cop :CookbookDependsOnPartialSearch, "#{__dir__}/chef/deprecation/depends_partial_search"
        register_cop :CookbookDependsOnPoise, "#{__dir__}/chef/deprecation/depends_poise"
        register_cop :DeprecatedChefSpecPlatform, "#{__dir__}/chef/deprecation/deprecated_chefspec_platform"
        register_cop :UsesDeprecatedMixins, "#{__dir__}/chef/deprecation/deprecated_mixins"
        register_cop :DeprecatedPlatformMethods, "#{__dir__}/chef/deprecation/deprecated_platform_methods"
        register_cop :DeprecatedShelloutMethods, "#{__dir__}/chef/deprecation/deprecated_shellout_methods"
        register_cop :DeprecatedSudoActions, "#{__dir__}/chef/deprecation/deprecated_sudo_actions"
        register_cop :DeprecatedWindowsVersionCheck, "#{__dir__}/chef/deprecation/deprecated_windows_version_check"
        register_cop :DeprecatedYumRepositoryActions, "#{__dir__}/chef/deprecation/deprecated_yum_repository_actions"
        register_cop :DeprecatedYumRepositoryProperties, "#{__dir__}/chef/deprecation/deprecated_yum_repository_properties"
        register_cop :EasyInstallResource, "#{__dir__}/chef/deprecation/easy_install"
        register_cop :EOLAuditModeUsage, "#{__dir__}/chef/deprecation/eol_audit_mode"
        register_cop :EpicFail, "#{__dir__}/chef/deprecation/epic_fail"
        register_cop :ErlCallResource, "#{__dir__}/chef/deprecation/erl_call"
        register_cop :ExecutePathProperty, "#{__dir__}/chef/deprecation/execute_path_property"
        register_cop :ExecuteRelativeCreatesWithoutCwd, "#{__dir__}/chef/deprecation/execute_relative_creates_without_cwd"
        register_cop :FoodcriticFile, "#{__dir__}/chef/deprecation/foodcritic_file"
        register_cop :FoodcriticTesting, "#{__dir__}/chef/deprecation/foodcritic_testing"
        register_cop :HWRPWithoutProvides, "#{__dir__}/chef/deprecation/hwrp_without_provides"
        register_cop :HWRPWithoutUnifiedTrue, "#{__dir__}/chef/deprecation/hwrp_without_unified_mode_true"
        register_cop :ResourceInheritsFromCompatResource, "#{__dir__}/chef/deprecation/inherits_compat_resource"
        register_cop :LaunchdDeprecatedHashProperty, "#{__dir__}/chef/deprecation/launchd_deprecated_hash_property"
        register_cop :LegacyNotifySyntax, "#{__dir__}/chef/deprecation/legacy_notify_syntax"
        register_cop :LegacyYumCookbookRecipes, "#{__dir__}/chef/deprecation/legacy_yum_cookbook_recipes"
        register_cop :LibrarianChefSpec, "#{__dir__}/chef/deprecation/librarian_chefspec"
        register_cop :LocaleDeprecatedLcAllProperty, "#{__dir__}/chef/deprecation/locale_lc_all_property"
        register_cop :LogResourceNotifications, "#{__dir__}/chef/deprecation/log_resource_notifications"
        register_cop :MacosUserdefaultsGlobalProperty, "#{__dir__}/chef/deprecation/macos_userdefaults_global_property"
        register_cop :NamePropertyWithDefaultValue, "#{__dir__}/chef/deprecation/name_property_and_default"
        register_cop :NodeDeepFetch, "#{__dir__}/chef/deprecation/node_deep_fetch"
        register_cop :NodeMethodsInsteadofAttributes, "#{__dir__}/chef/deprecation/node_methods_not_attributes"
        register_cop :NodeSet, "#{__dir__}/chef/deprecation/node_set"
        register_cop :NodeSetUnless, "#{__dir__}/chef/deprecation/node_set_unless"
        register_cop :NodeSetWithoutLevel, "#{__dir__}/chef/deprecation/node_set_without_level"
        register_cop :PartialSearchClassUsage, "#{__dir__}/chef/deprecation/partial_search_class_usage"
        register_cop :PartialSearchHelperUsage, "#{__dir__}/chef/deprecation/partial_search_helper_usage"
        register_cop :PoiseArchiveUsage, "#{__dir__}/chef/deprecation/poise_archive"
        register_cop :PolicyfileCommunitySource, "#{__dir__}/chef/deprecation/policyfile_community_source"
        register_cop :PowershellCookbookHelpers, "#{__dir__}/chef/deprecation/powershell_cookbook_helpers"
        register_cop :RequireRecipe, "#{__dir__}/chef/deprecation/require_recipe"
        register_cop :ResourceOverridesProvidesMethod, "#{__dir__}/chef/deprecation/resource_overrides_provides_method"
        register_cop :ResourceUsesDslNameMethod, "#{__dir__}/chef/deprecation/resource_uses_dsl_name_method"
        register_cop :ResourceUsesOnlyResourceName, "#{__dir__}/chef/deprecation/resource_uses_only_resource_name"
        register_cop :ResourceUsesProviderBaseMethod, "#{__dir__}/chef/deprecation/resource_uses_provider_base_method"
        register_cop :ResourceUsesUpdatedMethod, "#{__dir__}/chef/deprecation/resource_uses_updated_method"
        register_cop :ResourceWithoutUnifiedTrue, "#{__dir__}/chef/deprecation/resource_without_unified_mode_true"
        register_cop :Ruby27KeywordArgumentWarnings, "#{__dir__}/chef/deprecation/ruby_27_keyword_argument_warnings"
        register_cop :RubyBlockCreateAction, "#{__dir__}/chef/deprecation/ruby_block_create_action"
        register_cop :UsesRunCommandHelper, "#{__dir__}/chef/deprecation/run_command_helper"
        register_cop :SearchUsesPositionalParameters, "#{__dir__}/chef/deprecation/search_uses_positional_parameters"
        register_cop :UseAutomaticResourceName, "#{__dir__}/chef/deprecation/use_automatic_resource_name"
        register_cop :UseInlineResourcesDefined, "#{__dir__}/chef/deprecation/use_inline_resources"
        register_cop :UseYamlDump, "#{__dir__}/chef/deprecation/use_yaml_dump"
        register_cop :UserDeprecatedSupportsProperty, "#{__dir__}/chef/deprecation/user_supports_property"
        register_cop :VerifyPropertyUsesFileExpansion, "#{__dir__}/chef/deprecation/verify_property_file_expansion"
        register_cop :WindowsFeatureServermanagercmd, "#{__dir__}/chef/deprecation/windows_feature_servermanagercmd"
        register_cop :WindowsPackageInstallerTypeString, "#{__dir__}/chef/deprecation/windows_package_installer_type_string"
        register_cop :WindowsTaskChangeAction, "#{__dir__}/chef/deprecation/windows_task_change_action"
        register_cop :WindowsVersionHelpers, "#{__dir__}/chef/deprecation/windows_version_helpers"
        register_cop :IncludingXMLRubyRecipe, "#{__dir__}/chef/deprecation/xml_ruby_recipe"
        register_cop :IncludingYumDNFCompatRecipe, "#{__dir__}/chef/deprecation/yum_dnf_compat_recipe"
      end

      # The Chef/Effortless department.
      module Effortless
        extend LazyLoader

        register_cop :Berksfile, "#{__dir__}/chef/effortless/berksfile"
        register_cop :ChefVaultUsed, "#{__dir__}/chef/effortless/chef_vault_used"
        register_cop :CookbookUsesDatabags, "#{__dir__}/chef/effortless/data_bags"
        register_cop :DependsChefVault, "#{__dir__}/chef/effortless/depends_chef_vault"
        register_cop :CookbookUsesEnvironments, "#{__dir__}/chef/effortless/node_environment"
        register_cop :CookbookUsesPolicygroups, "#{__dir__}/chef/effortless/node_policygroup"
        register_cop :CookbookUsesRoles, "#{__dir__}/chef/effortless/node_roles"
        register_cop :SearchForEnvironmentsOrRoles, "#{__dir__}/chef/effortless/search_for_environments_or_roles"
        register_cop :CookbookUsesSearch, "#{__dir__}/chef/effortless/search_used"
      end

      # The Chef/Modernize department.
      module Modernize
        extend LazyLoader

        register_cop :ActionMethodInResource, "#{__dir__}/chef/modernize/action_method_in_resource"
        register_cop :AllowedActionsFromInitialize, "#{__dir__}/chef/modernize/allowed_actions_initializer"
        register_cop :IncludingAptDefaultRecipe, "#{__dir__}/chef/modernize/apt_default_recipe"
        register_cop :LegacyBerksfileSource, "#{__dir__}/chef/modernize/berksfile_source"
        register_cop :UseBuildEssentialResource, "#{__dir__}/chef/modernize/build_essential"
        register_cop :UnnecessaryDependsChef14, "#{__dir__}/chef/modernize/chef_14_resources"
        register_cop :UnnecessaryDependsChef15, "#{__dir__}/chef/modernize/chef_15_resources"
        register_cop :ChefGemNokogiri, "#{__dir__}/chef/modernize/chef_gem_nokogiri"
        register_cop :ClassEvalActionClass, "#{__dir__}/chef/modernize/class_eval_action_class"
        register_cop :ResourceForcingCompileTime, "#{__dir__}/chef/modernize/compile_time_resources"
        register_cop :ConditionalUsingTest, "#{__dir__}/chef/modernize/conditional_using_test"
        register_cop :CronDFileOrTemplate, "#{__dir__}/chef/modernize/cron_d_file_or_template"
        register_cop :CronManageResource, "#{__dir__}/chef/modernize/cron_manage_resource"
        register_cop :DatabagHelpers, "#{__dir__}/chef/modernize/databag_helpers"
        register_cop :DeclareActionClass, "#{__dir__}/chef/modernize/declare_action_class"
        register_cop :DefaultActionFromInitialize, "#{__dir__}/chef/modernize/default_action_initializer"
        register_cop :DefinesChefSpecMatchers, "#{__dir__}/chef/modernize/defines_chefspec_matchers"
        register_cop :Definitions, "#{__dir__}/chef/modernize/definitions"
        register_cop :DependsOnChefVaultCookbook, "#{__dir__}/chef/modernize/depends_chef_vault_cookbook"
        register_cop :DependsOnChocolateyCookbooks, "#{__dir__}/chef/modernize/depends_chocolatey_cookbooks"
        register_cop :DependsOnKernelModuleCookbook, "#{__dir__}/chef/modernize/depends_kernel_module_cookbook"
        register_cop :DependsOnLocaleCookbook, "#{__dir__}/chef/modernize/depends_locale_cookbook"
        register_cop :DependsOnOpensslCookbook, "#{__dir__}/chef/modernize/depends_openssl_cookbook"
        register_cop :DependsOnTimezoneLwrpCookbook, "#{__dir__}/chef/modernize/depends_timezone_lwrp_cookbook"
        register_cop :DependsOnWindowsFirewallCookbook, "#{__dir__}/chef/modernize/depends_windows_firewall_cookbook"
        register_cop :DependsOnZypperCookbook, "#{__dir__}/chef/modernize/depends_zypper_cookbook"
        register_cop :DslIncludeInResource, "#{__dir__}/chef/modernize/dsl_include_in_resource"
        register_cop :EmptyResourceInitializeMethod, "#{__dir__}/chef/modernize/empty_resource_initialize"
        register_cop :ExecuteAptUpdate, "#{__dir__}/chef/modernize/execute_apt_update"
        register_cop :ExecuteArchiveExtract, "#{__dir__}/chef/modernize/execute_archive_extract"
        register_cop :ExecuteScExe, "#{__dir__}/chef/modernize/execute_sc_exe"
        register_cop :ExecuteSleep, "#{__dir__}/chef/modernize/execute_sleep"
        register_cop :ExecuteSysctl, "#{__dir__}/chef/modernize/execute_sysctl"
        register_cop :ExecuteTzUtil, "#{__dir__}/chef/modernize/execute_tzutil"
        register_cop :ExecuteUpdateAlternatives, "#{__dir__}/chef/modernize/execute_update_alternatives"
        register_cop :FoodcriticComments, "#{__dir__}/chef/modernize/foodcritic_comments"
        register_cop :IfProvidesDefaultAction, "#{__dir__}/chef/modernize/if_provides_default_action"
        register_cop :IncludingMixinShelloutInResources, "#{__dir__}/chef/modernize/includes_mixin_shellout"
        register_cop :LibarchiveFileResource, "#{__dir__}/chef/modernize/libarchive_file"
        register_cop :MacOsXUserdefaults, "#{__dir__}/chef/modernize/macos_user_defaults"
        register_cop :MinitestHandlerUsage, "#{__dir__}/chef/modernize/minitest_handler_usage"
        register_cop :NodeInitPackage, "#{__dir__}/chef/modernize/node_init_package"
        register_cop :NodeRolesInclude, "#{__dir__}/chef/modernize/node_roles_include"
        register_cop :IncludingOhaiDefaultRecipe, "#{__dir__}/chef/modernize/ohai_default_recipe"
        register_cop :OpensslRsaKeyResource, "#{__dir__}/chef/modernize/openssl_rsa_key_resource"
        register_cop :OpensslX509Resource, "#{__dir__}/chef/modernize/openssl_x509_resource"
        register_cop :OsxConfigProfileResource, "#{__dir__}/chef/modernize/osx_config_profile_resource"
        register_cop :PowershellDownloadFile, "#{__dir__}/chef/modernize/powershell_download_file"
        register_cop :PowershellScriptExpandArchive, "#{__dir__}/chef/modernize/powershell_expand_archive"
        register_cop :PowerShellGuardInterpreter, "#{__dir__}/chef/modernize/powershell_guard_interpreter"
        register_cop :PowershellInstallPackage, "#{__dir__}/chef/modernize/powershell_install_package"
        register_cop :PowershellInstallWindowsFeature, "#{__dir__}/chef/modernize/powershell_install_windowsfeature"
        register_cop :PropertyWithNameAttribute, "#{__dir__}/chef/modernize/property_with_name_attribute"
        register_cop :ProvidesFromInitialize, "#{__dir__}/chef/modernize/provides_initializer"
        register_cop :ResourceNameFromInitialize, "#{__dir__}/chef/modernize/resource_name_initializer"
        register_cop :SetOrReturnInResources, "#{__dir__}/chef/modernize/resource_set_or_return"
        register_cop :CustomResourceWithAttributes, "#{__dir__}/chef/modernize/resource_with_attributes"
        register_cop :RespondToCompileTime, "#{__dir__}/chef/modernize/respond_to_compile_time"
        register_cop :RespondToInMetadata, "#{__dir__}/chef/modernize/respond_to_metadata"
        register_cop :RespondToProvides, "#{__dir__}/chef/modernize/respond_to_provides"
        register_cop :RespondToResourceName, "#{__dir__}/chef/modernize/respond_to_resource_name"
        register_cop :WindowsScResource, "#{__dir__}/chef/modernize/sc_windows_resource"
        register_cop :SevenZipArchiveResource, "#{__dir__}/chef/modernize/seven_zip_archive"
        register_cop :ShellOutHelper, "#{__dir__}/chef/modernize/shell_out_helper"
        register_cop :ShellOutToChocolatey, "#{__dir__}/chef/modernize/shellouts_to_chocolatey"
        register_cop :SimplifyAptPpaSetup, "#{__dir__}/chef/modernize/simplify_apt_ppa_setup"
        register_cop :SysctlParamResource, "#{__dir__}/chef/modernize/sysctl_param_resource"
        register_cop :UnnecessaryMixlibShelloutRequire, "#{__dir__}/chef/modernize/unnecessary_mixlib_shellout_require"
        register_cop :UseChefLanguageCloudHelpers, "#{__dir__}/chef/modernize/use_chef_language_cloud_helpers"
        register_cop :UseChefLanguageEnvHelpers, "#{__dir__}/chef/modernize/use_chef_language_env_helpers"
        register_cop :UseChefLanguageSystemdHelper, "#{__dir__}/chef/modernize/use_chef_language_systemd_helper"
        register_cop :UseMultipackageInstalls, "#{__dir__}/chef/modernize/use_multipackage_installs"
        register_cop :UseRequireRelative, "#{__dir__}/chef/modernize/use_require_relative"
        register_cop :WhyRunSupportedTrue, "#{__dir__}/chef/modernize/whyrun_supported_true"
        register_cop :IncludingWindowsDefaultRecipe, "#{__dir__}/chef/modernize/windows_default_recipe"
        register_cop :WindowsRegistryUAC, "#{__dir__}/chef/modernize/windows_registry_uac"
        register_cop :WindowsZipfileUsage, "#{__dir__}/chef/modernize/windows_zipfile"
        register_cop :ZipfileResource, "#{__dir__}/chef/modernize/zipfile_resource"
        register_cop :UsesZypperRepo, "#{__dir__}/chef/modernize/zypper_repo"
      end

      # The Chef/RedundantCode department.
      module RedundantCode
        extend LazyLoader

        register_cop :AptRepositoryDistributionDefault, "#{__dir__}/chef/redundant/apt_repository_distribution_default"
        register_cop :AptRepositoryNotifiesAptUpdate, "#{__dir__}/chef/redundant/apt_repository_notifies_apt_update"
        register_cop :AttributeMetadata, "#{__dir__}/chef/redundant/attribute_metadata"
        register_cop :ConflictsMetadata, "#{__dir__}/chef/redundant/conflicts_metadata"
        register_cop :CustomResourceWithAllowedActions, "#{__dir__}/chef/redundant/custom_resource_with_allowed_actions"
        register_cop :DoubleCompileTime, "#{__dir__}/chef/redundant/double_compile_time"
        register_cop :GroupingMetadata, "#{__dir__}/chef/redundant/grouping_metadata"
        register_cop :LongDescriptionMetadata, "#{__dir__}/chef/redundant/long_description_metadata"
        register_cop :MultiplePlatformChecks, "#{__dir__}/chef/redundant/multiple_platform_checks"
        register_cop :NamePropertyIsRequired, "#{__dir__}/chef/redundant/name_property_and_required"
        register_cop :OhaiAttributeToString, "#{__dir__}/chef/redundant/ohai_attribute_to_string"
        register_cop :PropertySplatRegex, "#{__dir__}/chef/redundant/property_splat_regex"
        register_cop :PropertyWithRequiredAndDefault, "#{__dir__}/chef/redundant/property_with_default_and_required"
        register_cop :ProvidesMetadata, "#{__dir__}/chef/redundant/provides_metadata"
        register_cop :RecipeMetadata, "#{__dir__}/chef/redundant/recipe_metadata"
        register_cop :ReplacesMetadata, "#{__dir__}/chef/redundant/replaces_metadata"
        register_cop :ResourceWithNothingAction, "#{__dir__}/chef/redundant/resource_with_nothing_action"
        register_cop :SensitivePropertyInResource, "#{__dir__}/chef/redundant/sensitive_property_in_resource"
        register_cop :ServiceGuardOnStopDisable, "#{__dir__}/chef/redundant/service_guard_on_stop_disable"
        register_cop :StringPropertyWithNilDefault, "#{__dir__}/chef/redundant/string_property_with_nil_default"
        register_cop :SuggestsMetadata, "#{__dir__}/chef/redundant/suggests_metadata"
        register_cop :UnnecessaryDesiredState, "#{__dir__}/chef/redundant/unnecessary_desired_state"
        register_cop :UnnecessaryNameProperty, "#{__dir__}/chef/redundant/unnecessary_name_property"
        register_cop :UseCreateIfMissing, "#{__dir__}/chef/redundant/use_create_if_missing"
      end

      # The Chef/Security department.
      module Security
        extend LazyLoader

        register_cop :InsecureRemoteFileSource, "#{__dir__}/chef/security/insecure_remote_file_source"
        register_cop :SshPrivateKey, "#{__dir__}/chef/security/ssh_private_key"
      end

      # The Chef/Sharing department.
      module Sharing
        extend LazyLoader

        register_cop :DefaultMetadataMaintainer, "#{__dir__}/chef/sharing/default_maintainer_metadata"
        register_cop :EmptyMetadataField, "#{__dir__}/chef/sharing/empty_metadata_field"
        register_cop :EmptyPropertyDescription, "#{__dir__}/chef/sharing/empty_property_description"
        register_cop :IncludePropertyDescriptions, "#{__dir__}/chef/sharing/include_property_descriptions"
        register_cop :IncludeResourceDescriptions, "#{__dir__}/chef/sharing/include_resource_descriptions"
        register_cop :IncludeResourceExamples, "#{__dir__}/chef/sharing/include_resource_examples"
        register_cop :InsecureCookbookURL, "#{__dir__}/chef/sharing/insecure_cookbook_url"
        register_cop :InvalidLicenseString, "#{__dir__}/chef/sharing/invalid_license_string"
      end

      # The Chef/Style department.
      module Style
        extend LazyLoader

        register_cop :AttributeKeys, "#{__dir__}/chef/style/attribute_keys"
        register_cop :ChefWhaaat, "#{__dir__}/chef/style/chef_whaaat"
        register_cop :CommentSentenceSpacing, "#{__dir__}/chef/style/comment_sentence_spacing"
        register_cop :CopyrightCommentFormat, "#{__dir__}/chef/style/comments_copyright_format"
        register_cop :DefaultCopyrightComments, "#{__dir__}/chef/style/comments_default_copyright"
        register_cop :CommentFormat, "#{__dir__}/chef/style/comments_format"
        register_cop :FileMode, "#{__dir__}/chef/style/file_mode"
        register_cop :ImmediateNotificationTiming, "#{__dir__}/chef/style/immediate_notification_timing"
        register_cop :IncludeRecipeWithParentheses, "#{__dir__}/chef/style/include_recipe_with_parentheses"
        register_cop :NegatingOnlyIf, "#{__dir__}/chef/style/negating_only_if"
        register_cop :OverlyComplexSupportsDependsMetadata, "#{__dir__}/chef/style/overly_complex_supports_depends_metadata"
        register_cop :SimplifyPlatformMajorVersionCheck, "#{__dir__}/chef/style/simplify_platform_major_version_check"
        register_cop :TrueClassFalseClassResourceProperties, "#{__dir__}/chef/style/true_false_resource_properties"
        register_cop :UnnecessaryOSCheck, "#{__dir__}/chef/style/unnecessary_os_check"
        register_cop :UnnecessaryPlatformCaseStatement, "#{__dir__}/chef/style/unnecessary_platform_case_statement"
        register_cop :UsePlatformHelpers, "#{__dir__}/chef/style/use_platform_helpers"
      end

      # The Chef/Ruby department. These are the Chefstyle cops, which live under
      # `cop/chefstyle/ruby` but share the Chef department namespace.
      module Ruby
        extend LazyLoader

        register_cop :GemspecLicense, "#{__dir__}/chefstyle/ruby/gemspec_license"
        register_cop :GemspecRequireRubygems, "#{__dir__}/chefstyle/ruby/gemspec_require_rubygems"
        register_cop :LegacyPowershellOutMethods, "#{__dir__}/chefstyle/ruby/legacy_powershell_out_methods"
        register_cop :RequireNetHttps, "#{__dir__}/chefstyle/ruby/require_net_https"
        register_cop :UnlessDefinedRequire, "#{__dir__}/chefstyle/ruby/unless_defined_require"
      end
    end
  end
end
