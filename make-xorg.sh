#!/bin/bash

set -e

apt-get install -y jhbuild sudo meson
cd /tmp

USER=jhbuild
useradd -m -u 1000 $USER
mkdir -p /home/$USER
cp /root/.jhbuildrc /home/$USER/.jhbuildrc
chown -R $USER /home/$USER
mkdir -p /tmp/gnome
chown -R $USER:$USER /tmp/gnome
echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nopasswd
export JHBUILD_PREFIX=/tmp/gnome

HOME=/home/$USER sudo -E -u $USER jhbuild --no-interact -f /home/$USER/.jhbuildrc xserver
