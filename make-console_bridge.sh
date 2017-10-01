#!/bin/bash


wget https://github.com/ros/console_bridge/archive/0.3.2.tar.gz -O /tmp/0.3.2.tar.gz
tar -xf /tmp/0.3.2.tar.gz -C /tmp
cd /tmp/console_bridge-0.3.2

cmake . -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${SYSROOT}/usr
make
make install

cd /
rm -rf /tmp/*
