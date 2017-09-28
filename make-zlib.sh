#!/bin/sh

wget https://zlib.net/zlib-1.2.11.tar.gz -O /tmp/zlib-1.2.11.tar.gz
tar -xf /tmp/zlib-1.2.11.tar.gz -C /tmp
cd /tmp/zlib-1.2.11

CROSS_COMPILE=aarch64-linux-gnu-
./configure --prefix=$SYSROOT

make
make install

cd /
rm -rf /tmp/*
