#!/bin/bash

set -xe

wget http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.bz2 -O /tmp/boost_1_58_0.tar.bz2
tar -xf /tmp/boost_1_58_0.tar.bz2 -C /tmp

cd /tmp/boost_1_58_0/tools/build
./bootstrap.sh
./b2 install


cd /tmp/boost_1_58_0
./bootstrap.sh toolset=gcc-arm --prefix=${SYSROOT}/usr
sed -i 's/using python.*//g' /tmp/boost_1_58_0/project-config.jam
./bjam -q --no-samples --no-tests target-os=linux toolset=gcc-arm architecture=arm abi=aapcs address-model=64 -j4 --prefix=$SYSROOT/usr --debug-configuration install

cd /
rm -rf /tmp/*
