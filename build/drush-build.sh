#!/usr/bin/env bash

if [ -z "$1" ];
then
  echo "You must supply an environment argument. See README for details.";
  exit
fi

if [ "$1" = "local" ];
then
  $(dirname "$0")/local/build-local.sh
fi

if [ $1 = "dev" ];
then
 $(dirname "$0")/dev/build-dev.sh
fi

if [ $1 = "prod" ];
then
  $(dirname "$0")/prod/build-prod.sh
fi

# Pass all arguments to drush
while [ $# -gt 0 ]; do
  drush_flags="$drush_flags"
  shift
done

drush="drush $drush_flags"

build_path=$(dirname "$0")
echo "Disabling all modules we do not need on any environment.";
$drush dis $(cat $build_path/mods_purge | tr '\n' ' ') -y
echo "Uninstalling modules we do not need on any environment.";
$drush pm-uninstall $(cat $build_path/mods_purge | tr '\n' ' ') -y
echo "Enabling modules we need on every environment.";
$drush en $(cat $build_path/mods_enabled | tr '\n' ' ') -y
echo "Clearing caches.";
$drush cc all -y
echo "Reverting all features.";
$drush fra -y
echo "Running any updates.";
$drush updb -y
echo "Setting the theme default.";
$drush scr $(dirname "$0")/scripts/default_set_theme.php
echo "Clearing caches one last time.";
$drush cc all -y
