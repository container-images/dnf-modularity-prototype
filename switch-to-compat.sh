#! /bin/sh -e


# Enable compat. repos. and disable the regular modular ones...
echo enabled=1 >> /etc/yum.repos.d/fedora-compat.repo
echo enabled=1 >> /etc/yum.repos.d/fedora-compat-rawhide.repo
echo enabled=1 >> /etc/yum.repos.d/fedora-compat-nodejs.repo

echo enabled=0 >> /etc/yum.repos.d/fedora-modular.repo
echo enabled=0 >> /etc/yum.repos.d/fedora-modular-rawhide.repo
echo enabled=0 >> /etc/yum.repos.d/fedora-modular-nodejs.repo

