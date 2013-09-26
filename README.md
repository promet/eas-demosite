default
=====

requirements
------------
* [vagrant](http://downloads.vagrantup.com/) >= 1.2.0
* [berkshelf](http://berkshelf.com/) >= 2.0.0
* [vagrant-berkshelf plugin](https://github.com/RiotGames/vagrant-berkshelf) >= 1.3.3

Use
---

The build script `drush-build.sh` takes one of three arguments:

* local
* dev
* prod

Global
------
For all environments, the build script will:

* enable and purge all modules within the build root (`mods_enable` and `mods_purge`) on every build for every environment.
* Revert all features (`drush fra`), run update hooks (`drush updb`), and clear caches.

Local
-----
This script is intended to create a local installation with a copy of the database and files. Use `local_mods_enable` to enable only modules needed for local development.

Dev
-----
This script is intended to run on a development or staging environment. Use `dev_mods_purge` to disbale modules not needed on development or staging.

Prod
-----
This script is intended to run on a production environment. Use `prod_mods_purge` to disbale modules not needed on development or staging.
