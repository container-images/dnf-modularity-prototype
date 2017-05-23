Container, based on baseruntime, that allows you to run the latest modularity
DNF prototype.

Requirements
============

dnf-repo needs to be a build of the dnf module (via. mbs-build local is fine).

Building
========

Run "make" for help.
Running "make build" should build an image, and "make run" should run it.
Afterwards you can run "make update" to update to the latest baseruntime.

Result
======

The built image is available from: docker pull jamesantill/flat-modules-dnf
