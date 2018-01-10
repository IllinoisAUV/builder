#!/bin/bash
set -xe

wget --quiet https://github.com/leethomason/tinyxml2/archive/6.0.0.tar.gz -O /tmp/6.0.0.tar.gz
tar -xf /tmp/6.0.0.tar.gz -C /tmp
cd /tmp/tinyxml2-6.0.0

cmake . -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${SYSROOT}/usr
make -j$(nproc)
make install

cd /
rm -rf /tmp/*
