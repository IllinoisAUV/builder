#!/bin/bash

set -xe
wget https://developer.nvidia.com/embedded/dlc/l4t-sample-root-filesystem-28-2 -O /tmp/sysroot.tar.bz2 
tar -xf /tmp/sysroot.tar.bz2 -C $SYSROOT
rm /tmp/sysroot.tar.bz2
