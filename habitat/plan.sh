export HAB_BLDR_CHANNEL="base-2025"
export HAB_REFRESH_CHANNEL="base-2025"

# Resolve the repo root and habitat dir from this file's own location
# (BASH_SOURCE) rather than PLAN_CONTEXT. PLAN_CONTEXT is set by Habitat to
# the directory it started the build from, which is NOT necessarily the
# directory this file lives in -- e.g. when habitat/aarch64-linux/plan.sh
# sources this file, PLAN_CONTEXT is "habitat/aarch64-linux", not "habitat",
# which breaks any "${PLAN_CONTEXT}/.." or "${PLAN_CONTEXT}/binstub_patch.rb"
# reference used here. BASH_SOURCE[0] always points at this file, so it
# resolves correctly regardless of which plan sourced it.
COOKSTYLE_HABITAT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COOKSTYLE_REPO_ROOT="$(cd "${COOKSTYLE_HABITAT_DIR}/.." && pwd)"

ruby_pkg="core/ruby3_4"
pkg_name="cookstyle"
pkg_origin="chef"
pkg_maintainer="The Chef Maintainers <humans@chef.io>"
pkg_description="Chef Cookstyle - Chef Infra Cookbook and InSpec profile linting with autocorrection."
pkg_license=('Apache-2.0')
pkg_bin_dirs=(
  bin
)
pkg_build_deps=(
  core/make
  core/bash
  core/gcc
  core/git
)
pkg_deps=(${ruby_pkg} core/coreutils)

pkg_svc_user=root

do_setup_environment() {
  push_runtime_env GEM_PATH "${pkg_prefix}/vendor"
  set_runtime_env APPBUNDLER_ALLOW_RVM "true" # prevent appbundler from clearing out the carefully constructed runtime GEM_PATH
  set_runtime_env LANG "en_US.UTF-8"
  set_runtime_env LC_CTYPE "en_US.UTF-8"
}

pkg_version() {
  cat "$SRC_PATH/VERSION"
}

do_before() {
  update_pkg_version
}

do_unpack() {
  mkdir -pv "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  cp -RT "$COOKSTYLE_REPO_ROOT" "$HAB_CACHE_SRC_PATH/$pkg_dirname/"
}

do_build() {

  export GEM_HOME="$pkg_prefix/vendor"

  build_line "Setting GEM_PATH=$GEM_HOME"
  export GEM_PATH="$GEM_HOME"
  bundle config --local without integration deploy maintenance development profiling docs debug
  bundle config --local jobs 4
  bundle config --local retry 5
  bundle config --local silence_root_warning 1
  bundle install
  gem build cookstyle.gemspec
  ruby ./cleanup_gem_lockfiles.rb

}

do_install() {

  # Copy NOTICE.TXT to the package directory
  if [[ -f "${COOKSTYLE_REPO_ROOT}/NOTICE" ]]; then
    build_line "Copying NOTICE to package directory"
    cp "${COOKSTYLE_REPO_ROOT}/NOTICE" "$pkg_prefix/"
  else
    build_line "Warning: NOTICE not found at ${COOKSTYLE_REPO_ROOT}/NOTICE"
  fi

  export GEM_HOME="$pkg_prefix/vendor"

  build_line "Setting GEM_PATH=$GEM_HOME"
  export GEM_PATH="$GEM_HOME"
  gem install cookstyle-*.gem --no-document

  build_line "** generating binstubs for cookstyle with precise version pins"
  "${pkg_prefix}/vendor/bin/appbundler" . "$pkg_prefix/bin" cookstyle

  build_line "** patching binstubs to allow running directly"
  for binstub in "${pkg_prefix}"/bin/*; do
    sed -i -e "/require ['\"']rubygems['\"']/r ${COOKSTYLE_HABITAT_DIR}/binstub_patch.rb" "$binstub"
  done

  if ! grep -q 'APPBUNDLER_ALLOW_RVM' "${pkg_prefix}/bin/cookstyle"; then
    build_line "ERROR: binstub patch injection failed for ${pkg_prefix}/bin/cookstyle"
    return 1
  fi

  fix_interpreter "${pkg_prefix}/bin/*" "$ruby_pkg" bin/ruby
}

do_after() {
  build_line "Removing .github directories from vendored gems..."
  find "$pkg_prefix/vendor/gems" -type d -name ".github" \
      | while read github_dir; do rm -rf "$github_dir"; done

  build_line "Removing stray Gemfile.lock files from vendored gems..."
  find "$pkg_prefix/vendor/gems" -name "Gemfile.lock" -type f -delete
}

do_strip() {
  return 0
}
