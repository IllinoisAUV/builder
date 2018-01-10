#!/bin/bash

set -xe

wget --quiet https://github.com/ros/urdfdom_headers/archive/1.0.0.tar.gz -O /tmp/1.0.0.tar.gz
tar -xf /tmp/1.0.0.tar.gz -C /tmp
cd /tmp/urdfdom_headers-1.0.0

cmake . -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${SYSROOT}/usr
make -j$(nproc)
make install

cd /
rm -rf /tmp/*
