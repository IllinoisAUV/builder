#!/bin/bash

set -xe

# wget https://developer.nvidia.com/embedded/dlc/l4t-gcc-toolchain-64-bit-sources-28-1 -O /tmp/gcc-4.8.5-aarch64.tgz
# mkdir /tmp/gcc
# tar -xf /tmp/gcc-4.8.5-aarch64.tgz -C /tmp/gcc


cd /opt/gcc
mv /tmp/make-aarch64-toolchain.sh .
./make-aarch64-toolchain.sh
