#!/bin/bash

set -e 

wget --quiet http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz -O /tmp/libogg-1.3.2.tar.gz
tar -xf /tmp/libogg-1.3.2.tar.gz -C /tmp

cd /tmp/libogg-1.3.2

./configure --prefix=$SYSROOT/usr --host=$TRIPLET
make -j$(nproc)
make install

cd /
rm -rf /tmp/*
