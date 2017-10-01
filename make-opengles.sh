#!/bin/bash

set -xe

CROSS_COMPILE=${TRIPLET}-

wget https://xcb.freedesktop.org/dist/libpthread-stubs-0.4.tar.gz -O /tmp/libpthread-stubs-0.4.tar.gz
tar -xf /tmp/libpthread-stubs-0.4.tar.gz -C /tmp
cd /tmp/libpthread-stubs-0.4
./configure --prefix=${SYSROOT}/usr
make -j$(nproc)
make install


wget https://www.x.org/releases/individual/proto/glproto-1.4.17.tar.gz -O /tmp/glproto-1.4.17.tar.gz
tar -xf /tmp/glproto-1.4.17.tar.gz -C /tmp
cd /tmp/glproto-1.4.17
./configure --prefix=$SYSROOT/usr
make install

wget https://www.x.org/archive/individual/proto/dri2proto-2.8.tar.gz -O /tmp/dri2proto-2.8.tar.gz
tar -xf /tmp/dri2proto-2.8.tar.gz -C /tmp
cd /tmp/dri2proto-2.8
./configure --prefix=$SYSROOT/usr
make install



wget https://dri.freedesktop.org/libdrm/libdrm-2.4.83.tar.gz -O /tmp/libdrm-2.4.83.tar.gz
tar -xf /tmp/libdrm-2.4.83.tar.gz -C /tmp
cd /tmp/libdrm-2.4.83
CFLAGS='-Wl,-v -Wl,--verbose' ./configure \
    --prefix=$SYSROOT/usr \
    --enable-udev \
    --with-sysroot=$SYSROOT \
    --disable-intel \
    --disable-freedreno \
    --disable-vmwgfx \
    --disable-radeon \
    --disable-amdgpu \
    --disable-libkms \
    --host=$TRIPLET
# Prevent libtool from trying to relink things without the correct sysroot
patch < /libtool.patch
make -j$(nproc)
make install

wget https://www.x.org/archive/individual/proto/dri3proto-1.0.tar.bz2 -O /tmp/dri3proto-1.0.tar.bz2
tar -xf /tmp/dri3proto-1.0.tar.bz2 -C /tmp
cd /tmp/dri3proto-1.0
./configure --prefix=$SYSROOT/usr
make install


wget https://www.x.org/archive/individual/proto/presentproto-1.1.tar.bz2 -O /tmp/presentproto-1.1.tar.bz2
tar -xf /tmp/presentproto-1.1.tar.bz2 -C /tmp
cd /tmp/presentproto-1.1
./configure --prefix=$SYSROOT/usr
make install



wget https://xcb.freedesktop.org/dist/xcb-proto-1.12.tar.bz2 -O /tmp/xcb-proto-1.12.tar.bz
tar -xf /tmp/xcb-proto-1.12.tar.bz -C /tmp
cd /tmp/xcb-proto-1.12
./configure --prefix=$SYSROOT/usr
make install

wget https://www.x.org/archive/individual/proto/xproto-7.0.31.tar.bz2 -O /tmp/xproto-7.0.31.tar.bz2
tar -xf /tmp/xproto-7.0.31.tar.bz2 -C /tmp
cd /tmp/xproto-7.0.31
./configure --prefix=$SYSROOT/usr
make install


wget https://www.x.org/archive//individual/lib/libXau-1.0.8.tar.bz2 -O /tmp/libXau-1.0.8.tar.bz2
tar -xf /tmp/libXau-1.0.8.tar.bz2 -C /tmp
cd /tmp/libXau-1.0.8
./configure \
    --prefix=$SYSROOT/usr \
    --with-sysroot=$SYSROOT \
    --host=$TRIPLET
make -j$(nproc)
make install

wget https://xcb.freedesktop.org/dist/libxcb-1.12.tar.bz2 -O /tmp/libxcb-1.12.tar.bz2
tar -xf /tmp/libxcb-1.12.tar.bz2 -C /tmp
cd /tmp/libxcb-1.12
CFLAGS='-Wl,--verbose' ./configure \
    --prefix=$SYSROOT/usr \
    --with-sysroot=$SYSROOT \
    --host=$TRIPLET \
    --disable-devel-docs
patch < /libtool.patch
make SHELL='sh -x' # -j$(nproc)
make install


wget https://mesa.freedesktop.org/archive/17.0.0/mesa-17.0.0.tar.xz -O /tmp/mesa-17.0.0.tar.xz
tar -xf /tmp/mesa-17.0.0.tar.xz -C /tmp

cd /tmp/mesa-17.0.0

./configure \
    --prefix=$SYSROOT/usr \
    --host=$TRIPLET \
    --with-sysroot=$SYSROOT


make -j$(nproc)
make install

cd /
rm -rf /tmp/*
