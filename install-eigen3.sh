#!/bin/bash
set -e

wget --quiet http://bitbucket.org/eigen/eigen/get/3.3.4.tar.bz2 -O /tmp/3.3.4.tar.bz2
tar -xf /tmp/3.3.4.tar.bz2 -C /tmp

cd /tmp/eigen-eigen-5a0156e40feb

mkdir build && cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${SYSROOT}/usr
make -j$(nproc)
make install

cd /
rm -rf /tmp/*
