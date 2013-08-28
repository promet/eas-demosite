#!/usr/bin/env bash

# Pass all arguments to drush
while [ $# -gt 0 ]; do
  drush_flags="$drush_flags $1"
  shift
done

drush="drush $drush_flags"

build_path=$(dirname "$0")

#Details to build on prometdev.
$drush si -y --account-pass='drupaladm1n' --db-url=mysql://default-d7DBA:default-d7PASS@localhost/default-d7DB &&
$drush dis $(cat $build_path/mods_disabled | tr '\n' ' ') -y &&
$drush en $(cat $build_path/mods_enabled | tr '\n' ' ') -y &&
$drush cc all -y &&
#Set theme.
$drush scr $(dirname "$0")/scripts/default_set_theme.php &&
$drush cc all -y
