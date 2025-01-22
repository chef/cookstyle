# export HAB_REFRESH_CHANNEL="LTS-2024"
ruby_pkg="core/ruby3_1"
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
)
pkg_deps=(${ruby_pkg} core/coreutils core/git)

pkg_svc_user=root

do_setup_environment() {
  build_line 'Setting GEM_HOME="$pkg_prefix/vendor"'
  export GEM_HOME="$pkg_prefix/vendor"

  build_line "Setting GEM_PATH=$GEM_HOME"
  export GEM_PATH="$GEM_HOME"
}

pkg_version() {
  cat "$SRC_PATH/VERSION"
}

do_before() {
  update_pkg_version
}

do_unpack() {
  mkdir -pv "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  cp -RT "$PLAN_CONTEXT"/.. "$HAB_CACHE_SRC_PATH/$pkg_dirname/"
}

do_build() {

  export GEM_HOME="$pkg_prefix/vendor"

  build_line "Setting GEM_PATH=$GEM_HOME"
  export GEM_PATH="$GEM_HOME"
  bundle config --local without integration deploy maintenance
  bundle config --local jobs 4
  bundle config --local retry 5
  bundle config --local silence_root_warning 1
  bundle install
  gem build cookstyle.gemspec
}

do_install() {
  export GEM_HOME="$pkg_prefix/vendor"

  build_line "Setting GEM_PATH=$GEM_HOME"
  export GEM_PATH="$GEM_HOME"
  gem install cookstyle-*.gem --no-document
  wrap_ruby_cookstyle
  set_runtime_env "GEM_PATH" "${pkg_prefix}/vendor"
}

wrap_ruby_cookstyle() {
  local bin="$pkg_prefix/bin/$pkg_name"
  local real_bin="$GEM_HOME/gems/cookstyle-${pkg_version}/bin/cookstyle"
  wrap_bin_with_ruby "$bin" "$real_bin"
}

wrap_bin_with_ruby() {
  local bin="$1"
  local real_bin="$2"
  build_line "Adding wrapper $bin to $real_bin"
  cat <<EOF > "$bin"
#!$(pkg_path_for core/bash)/bin/bash
set -e

# Set binary path that allows cookstyle to use non-Hab pkg binaries
export PATH="/sbin:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:\$PATH"

# Set Ruby paths defined from 'do_setup_environment()'
export GEM_HOME="$pkg_prefix/vendor"
export GEM_PATH="$GEM_PATH"

exec $(pkg_path_for ${ruby_pkg})/bin/ruby $real_bin \$@
EOF
  chmod -v 755 "$bin"
}

do_strip() {
  return 0
}
