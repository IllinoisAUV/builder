#!/bin/sh
set -e

wget --quiet https://zlib.net/zlib-1.2.11.tar.gz -O /tmp/zlib-1.2.11.tar.gz
tar -xf /tmp/zlib-1.2.11.tar.gz -C /tmp
cd /tmp/zlib-1.2.11

CROSS_COMPILE=${TRIPLET}-
export CC=${TRIPLET}-gcc
export LD=${TRIPLET}-ld
export AS=${TRIPLET}-as
./configure --prefix=$SYSROOT/usr

make -j$(nproc)
make install

cd /
rm -rf /tmp/*
