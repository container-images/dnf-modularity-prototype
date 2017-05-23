Container, based on baseruntime, that allows you to run the latest modularity
DNF prototype.

**NOTE** If you add a repo. for a module you need make sure modules=1 is in the .repo file, currently DNF requires this (hoping to get this changed).

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
