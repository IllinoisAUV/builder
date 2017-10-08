#!/bin/bash

set -xe


wget --quiet https://github.com/lz4/lz4/archive/v1.8.0.tar.gz -O /tmp/v1.8.0.tar.gz
tar -xf /tmp/v1.8.0.tar.gz -C /tmp
cd /tmp/lz4-1.8.0/contrib/cmake_unofficial

cmake . -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${SYSROOT}/usr
make install

cd /
rm -rf /tmp/*
