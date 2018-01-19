#!/bin/bash

set -e


cd /tmp
apt-get source zlib
cd zlib*
AR=${CROSS_COMPILE}ar CC=${CROSS_COMPILE}gcc RANLIB=${CROSS_COMPILE}ranlib ./configure --prefix=$SYSROOT/usr
make -j$(nproc)
make install

cd /
rm -rf /tmp/*
