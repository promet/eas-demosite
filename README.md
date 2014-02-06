default
=======

requirements
------------
* [vagrant](http://downloads.vagrantup.com/) >= 1.2.0 (1.4.x recommended)

Legacy Note: you no longer need any particular vagrant plugins. The box is
already provisioned, so there's no need for a chef run.

Building
---

* Run `vagrant up` to build the environment.
* ssh in with `vagrant ssh`
* Navigate to `/var/www/sites/PROJECT`.
* cp `env.json` from `/var/drupal/default/` to next to your `settings.php`.
* From inside your drupal root, run `../build/drush-build.sh local` and party.

Use
---

The build script `drush-build.sh` takes an environment argument which can be
one of the following:

* local
* dev
* prod

additional environments can be added by simply adding a directory for it with
a build.sh in it.

Global
------
For all environments, the build script will:

* enable and purge all modules within the build root (`mods_enable` and `mods_purge`) on every build for every environment.
* Revert all features (`drush fra`), run update hooks (`drush updb`), and clear caches.

Local
-----
This script is intended to create a local installation with a copy of the database and files. Use `mods_enable` in the environment directory to enable only modules needed for local development.

Dev
-----
This script is intended to run on a development or staging environment. Use `mods_purge` in the environment directory to disable modules not needed on development or staging.

Prod
-----
This script is intended to run on a production environment. Use `mods_purge` in the environment directory to disbale modules not needed on development or staging.
