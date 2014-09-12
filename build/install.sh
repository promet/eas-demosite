#!/bin/bash
set -e
path=$(dirname "$0")
base=$PWD/$path/..
drush_flags='-y'
# Pass all arguments to drush
while [ $# -gt 0 ]; do
  drush_flags="$drush_flags $1"
  shift
done
drush="drush $drush_flags"

pushd $base/www

$drush si minimal --account-name=admin --account-pass=drupaladm1n
echo "Enabling modules";
$drush en $(cat $base/build/mods_enabled | tr '\n' ' ')
echo "Rebuilding registry and clearing caches.";
$drush rr
$drush cc drush
echo "Enable everyting, perform updates, revert all features.";
$drush kw-m

popd

