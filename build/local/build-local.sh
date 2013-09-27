#! /usr/bin/env bash

TMP_PWD=$PWD

pushd $PWD

drupal_path="/var/drupals/gc011/www"
build_path=$(dirname "$0")

# Pass all arguments to drush
while [ $# -gt 0 ]; do
  drush_flags="$drush_flags $1"
  shift
done

drush="drush $drush_flags"

echo "Installing database.";
$drush si -y --account-pass='drupaladm1n'
echo "Enabling modules needed for local development.";
$drush en $(cat $build_path/dev_mods_enabled | tr '\n' ' ') -y -v
echo "Clearing caches.";
$drush cc all -y
echo "Disabling css and js caching.";
$drush vset -y preprocess_css 0
$drush vset -y preprocess_js 0

popd
