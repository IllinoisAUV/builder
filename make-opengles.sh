#!/bin/bash

set -xe

wget --quiet https://dri.freedesktop.org/libdrm/libdrm-2.4.83.tar.gz -O /tmp/libdrm-2.4.83.tar.gz
tar -xf /tmp/libdrm-2.4.83.tar.gz -C /tmp
cd /tmp/libdrm-2.4.83
./configure \
    --prefix=$SYSROOT/usr \
    --enable-udev \
    --with-sysroot=$SYSROOT \
    --disable-intel \
    --disable-freedreno \
    --disable-vmwgfx \
    --disable-radeon \
    --disable-amdgpu \
    --host=$TRIPLET
make -j$(nproc)
make install

wget --quiet https://mesa.freedesktop.org/archive/17.0.0/mesa-17.0.0.tar.xz -O /tmp/mesa-17.0.0.tar.xz
tar -xf /tmp/mesa-17.0.0.tar.xz -C /tmp

cd /tmp/mesa-17.0.0

CFLAGS="-I$SYSROOT/usr/include/libdrm/nouveau -I$SYSROOT/usr/include/libdrm" ./configure \
    --prefix=$SYSROOT/usr \
    --host=$TRIPLET \
    --enable-driglx-direct \
    --enable-gles1 \
    --enable-gles2 \
    --enable-glx-tls \
    --with-dri-driverdir=/usr/lib/dri \
    --with-dri-drivers=nouveau \
    --with-gallium-drivers=nouveau \
    --with-egl-platforms='drm x11'


make -j$(nproc)
make install

cd /
rm -rf /tmp/*
