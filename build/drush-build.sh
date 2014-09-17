#!/usr/bin/env bash
set -e

path=$(dirname "$0")

base=$PWD/$path/..

drush_flags='-y'
# Pass all arguments to drush
while [ $# -gt 0 ]; do
  drush_flags="$drush_flags $1"
  shift
done
drush="$base/vendor/bin/drush.php $drush_flags"

pushd $base/www

echo "Enabling modules";
$drush en $(cat $base/build/mods_enabled | tr '\n' ' ')
echo "Rebuilding registry and clearing caches.";
$drush rr
$drush cc drush
echo "Running manifests"
$drush kw-m
echo "Set default theme";
$drush scr $base/build/scripts/default_set_theme.php
echo "Setting environment config";
$drush scr $base/build/scripts/env.php
echo "Clearing caches one last time.";
$drush cc all

chmod -R +w ../cnf

popd
