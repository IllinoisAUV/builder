#!/bin/bash

set -e

# wget --quiet https://developer.nvidia.com/embedded/dlc/l4t-gcc-toolchain-64-bit-sources-28-1 -O /tmp/gcc-4.8.5-aarch64.tgz
mkdir -p /tmp/gcc
# tar -xf /tmp/gcc-4.8.5-aarch64.tgz -C /opt/gcc


cd /tmp/gcc
mv /tmp/make-aarch64-toolchain.sh .
# cat make-aarch64-toolchain.sh


./make-aarch64-toolchain.sh

cd /
rm -rf /tmp/*
