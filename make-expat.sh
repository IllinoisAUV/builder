#!/bin/bash

set -ex

wget --quiet https://github.com/libexpat/libexpat/archive/R_2_2_4.tar.gz -O /tmp/libexpat-R_2_2_4.tar.gz
tar -xf /tmp/libexpat-R_2_2_4.tar.gz -C /tmp
cd /tmp/libexpat-R_2_2_4/expat

mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$SYSROOT/usr -DBUILD_tests=OFF
make -j$(nproc)
make install

cd /
rm -rf /tmp/*
