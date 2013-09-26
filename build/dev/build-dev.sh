#! /usr/bin/env bash

TMP_PWD=$PWD

pushd $PWD

# Pass all arguments to drush
while [ $# -gt 0 ]; do
  drush_flags="$drush_flags $1"
  shift
done

drush="drush $drush_flags"
build_path=$(dirname "$0")

echo "Disabling modules we do not need on dev or staging.";
$drush dis $(cat $build_path/dev_mods_purge | tr '\n' ' ') -y
echo "Uninstalling modules we do not need on dev or staging.";
$drush pm-uninstall $(cat $build_path/dev_mods_purge | tr '\n' ' ') -y
echo "Enabling css and js caching.";
$drush vset -y preprocess_css 1 &&
$drush vset -y preprocess_js 1

popd
