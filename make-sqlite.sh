#!/bin/bash

set -ex

wget https://www.sqlite.org/2017/sqlite-autoconf-3200100.tar.gz -O /tmp/sqlite-autoconf-3200100.tar.gz
tar -xf /tmp/sqlite-autoconf-3200100.tar.gz -C /tmp
cd /tmp/sqlite-autoconf-3200100

export CROSS_COMPILE=$TRIPLET-
./configure \
    --build=$MACHTYPE \
    --host=$TRIPLET \
    --prefix=$SYSROOT/usr \
    --enable-shared \

make
make install

cd /
rm -rf /tmp/*
