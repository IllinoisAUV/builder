#!/bin/bash
set -e


cd /tmp
apt-get source libpng
cd libpng*
./configure --prefix=$SYSROOT/usr --host=${TRIPLET}
make
make install

cd /
rm -rf /tmp/*
