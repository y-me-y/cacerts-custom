pkg_name=cacerts-custom
pkg_origin=js
pkg_description="A package that appends your own CA Cert Bundle to the core/cacerts pkg"
pkg_version="0.1.0"
pkg_maintainer="Jeff Stasko <jeff.stasko@pgrogress.com>"
pkg_license=("MPL-2.0")
pkg_deps=(core/cacerts)

do_download() {
  wget https://raw.githubusercontent.com/y-me-y/cacerts-custom/main/cert/newca.pem
}

do_build() {
  cp -r "$(pkg_path_for core/cacerts)/ssl" "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  cat "${PLAN_CONTEXT}/newca.pem" >> "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/ssl/certs/cacert.pem"
}

do_install() {
  cp -r "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"/* "${pkg_prefix}"/
}
