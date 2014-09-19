#!/bin/bash
set -e
path=$(dirname "$0")
base=$(cd $PWD/$path/.. && pwd)
drush_flags='-y'
# Pass all arguments to drush
while [ $# -gt 0 ]; do
  drush_flags="$drush_flags $1"
  shift
done
drush="$base/vendor/bin/drush.php $drush_flags"

if [[ -f .env ]]; then 
  source .env
else
  echo "No env file found. Please create one. You can use env.dist as an example."
  exit 1
fi

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

