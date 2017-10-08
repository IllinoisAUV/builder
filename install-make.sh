#!/bin/bash

set -xe


wget --quiet https://ftp.gnu.org/gnu/make/make-3.79.1.tar.gz -O /tmp/make-3.79.1.tar.gz
tar -xf /tmp/make-3.79.1.tar.gz -C /tmp

cd /tmp/make-3.79.1

./configure
make -j$(nproc)

mv make /make

cd /
rm -rf /tmp/*
