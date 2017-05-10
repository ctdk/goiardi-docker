goiardi-docker
--------------

A repository of Dockerfiles and such for running goiardi and associated services inside docker.

Still in progress as far as getting everything together goes.

Usage
=====

Layout
======

* `goiardi/` - The various goiardi Dockerfiles are in here. The `latest` one, oddly enough, has whatever's in the latest master branch. Dockerfiles for specific releases are in subdirectories here as well, at least when they get made.

* `goiardi-compose/` - docker-compose configs for different goiardi configurations. Currently, there are configs for a minimal in-memory goiardi, one to initialize the database for postgres, and one to run goiardi and postgres together.

* `supporting-images/` - a variety of Dockerfiles that are not required to run goiardi in docker, but may be helpful for certain configurations. These images are:

  * `webui` - runs the old chef-server-webui rails app. Depends on:

  * `rails-3.2` - provides rails 3.2 for the webui. The only one of these docker images that's built off of a Debian image (specifically, wheezy), because between the various dependencies of the webui getting it to work with a newer version of ruby than 1.9.3 is a massive headache. If you don't need to run the webui you'd be well advised not to.

  * `statsdaemon` - provides statsdaemon, for gathering metrics about goiardi to send to graphite.

  * `goiardi-sqitch` - a helper image with the sqitch files for initializing goiardi's database. Not something that needs to be run in the normal course of events, only when initializing goiardi with a database for the first time and when upgrading requires database migrations.
