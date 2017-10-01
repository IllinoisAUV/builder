#!/bin/bash

set -xe

wget https://developer.nvidia.com/embedded/dlc/l4t-gcc-toolchain-64-bit-sources-28-1 -O /tmp/gcc-4.8.5-aarch64.tgz
mkdir /tmp/gcc
tar -xf /tmp/gcc-4.8.5-aarch64.tgz -C /opt/gcc


cd /opt/gcc
mv /tmp/make-aarch64-toolchain.sh .
# cat make-aarch64-toolchain.sh


# Glibc requires make 3.8* or 3.9*
wget https://ftp.gnu.org/gnu/make/make-3.82.tar.gz -O /tmp/make-3.82.tar.gz
tar -xf /tmp/make-3.82.tar.gz -C /tmp
pushd /tmp/make-3.82
./configure
make -j$(nproc)
make install
popd
# export MAKE_PATH=/tmp/make-3.82

./make-aarch64-toolchain.sh

cd /
rm -rf /tmp/*
