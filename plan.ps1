$pkg_name="cacerts-custom"
$pkg_origin="js"
$pkg_description="A package that appends your own CA Cert Bundle to the core/cacerts pkg"
$pkg_version="0.1.0"
$pkg_license=@('MPL-2.0')
$pkg_maintainer="Jeff Stasko <jeff.stasko@pgrogress.com>"
$pkg_deps=@("core/cacerts")

function  Invoke-Download {
  Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/y-me-y/cacerts-custom/main/cert/newca.pem'  -OutFile '.\newcap.pem'
}
function Invoke-Build {
  Copy-Item "$(Get-HabPackagePath cacerts)/ssl" "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Recurse
  $From = Get-Content -Path "$PLAN_CONTEXT/newca.pem"
  Add-Content -Path "$HAB_CACHE_SRC_PATH/$pkg_dirname/ssl/certs/cacert.pem" -Value $From
  Add-Content -Path "$HAB_CACHE_SRC_PATH/$pkg_dirname/ssl/cert.pem" -Value $From
}

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" "$pkg_prefix/" -Recurse
}
