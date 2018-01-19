#!/bin/bash

set -e

wget --quiet https://developer.nvidia.com/embedded/dlc/l4t-jetson-tx1-driver-package-28-1 -O /tmp/Linux_for_Tegra.tar.bz2
tar -xf /tmp/Linux_for_Tegra.tar.bz2 -C /tmp


cd /tmp/Linux_for_Tegra/nv_tegra
tar -xf nvidia_drivers.tbz2
cp -rf /tmp/Linux_for_Tegra/nv_tegra/usr/lib/aarch64-linux-gnu/* $SYSROOT/usr/lib

cd /
rm -rf /tmp/*
