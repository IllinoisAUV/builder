#!/bin/bash

set -xe

wget --quiet https://mesa.freedesktop.org/archive/17.0.0/mesa-17.0.0.tar.xz -O /tmp/mesa-17.0.0.tar.xz
tar -xf https://mesa.freedesktop.org/archive/17.0.0/mesa-17.0.0.tar.xz -C /tmp

cd /tmp/mesa-17.0.0

./configure

./configure --prefix=$SYSROOT/usr \
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
