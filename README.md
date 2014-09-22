# default-d7

## Requirements

* [vagrant](http://downloads.vagrantup.com/) >= 1.2.0 (1.4.x recommended)

Legacy Note: you no longer need any particular vagrant plugins. The box is
already provisioned, so there's no need for a chef run.

### Getting Started

* You need to edit your machine's local host file. Add the entry 110.33.36.11 default-d7.dev
* Make a copy of cnf/config.yml.dist: `cp cnf/config.yml.dist cnf/config.yml`
* Run `vagrant up --provision` to build the environment.
* ssh in with `vagrant ssh`
* Navigate to `/var/www/sites/PROJECT`.
* PARTY!!!

### Use

#### Environment Variables

Environment variables are used to configure tunables. These are spelled out in
`env.dist` and the provision step for Vagrant will load the variables from there
unless you create a `.env` file to override those values.

*IMPORTANT*

This project uses the [drop_ship]('github.com/promet/drop_ship') module to
handle the reusable part of deployment, so everything will get disabled if you
don't set `DROPSHIP_SEEDS` to a `:`-delimited list of modules you need at
runtime, like this:

```
DROPSHIP_SEEDS=default-d7:devel:new_module_im_testing
```
