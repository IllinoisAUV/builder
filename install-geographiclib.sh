#!/bin/bash

set -e

wget --quiet https://sourceforge.net/projects/geographiclib/files/distrib/GeographicLib-1.49.tar.gz -O /tmp/GeographicLib-1.49.tar.gz
tar -xf /tmp/GeographicLib-1.49.tar.gz -C /tmp
cd /tmp/GeographicLib-1.49

./configure --prefix=$SYSROOT/usr --host=$TRIPLET
make -j$(nproc)
make install

cd /
rm -rf /tmp/*
