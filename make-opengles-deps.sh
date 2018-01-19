#!/bin/bash

set -e


apt-get update

wget --quiet https://xcb.freedesktop.org/dist/libpthread-stubs-0.4.tar.gz -O /tmp/libpthread-stubs-0.4.tar.gz
tar -xf /tmp/libpthread-stubs-0.4.tar.gz -C /tmp
cd /tmp/libpthread-stubs-0.4
./configure --prefix=${SYSROOT}/usr
make -j$(nproc)
make install


wget --quiet https://www.x.org/releases/individual/proto/glproto-1.4.17.tar.gz -O /tmp/glproto-1.4.17.tar.gz
tar -xf /tmp/glproto-1.4.17.tar.gz -C /tmp
cd /tmp/glproto-1.4.17
./configure --prefix=$SYSROOT/usr
make install

wget --quiet https://www.x.org/archive/individual/proto/dri2proto-2.8.tar.gz -O /tmp/dri2proto-2.8.tar.gz
tar -xf /tmp/dri2proto-2.8.tar.gz -C /tmp
cd /tmp/dri2proto-2.8
./configure --prefix=$SYSROOT/usr
make install



# wget --quiet https://dri.freedesktop.org/libdrm/libdrm-2.4.83.tar.gz -O /tmp/libdrm-2.4.83.tar.gz
# tar -xf /tmp/libdrm-2.4.83.tar.gz -C /tmp
# cd /tmp/libdrm-2.4.83
# ./configure \
#     --prefix=$SYSROOT/usr \
#     --enable-udev \
#     --with-sysroot=$SYSROOT \
#     --disable-intel \
#     --disable-freedreno \
#     --disable-vmwgfx \
#     --disable-radeon \
#     --disable-amdgpu \
#     --disable-libkms \
#     --host=$TRIPLET
# # Prevent libtool from trying to relink things without the correct sysroot
# patch < /libtool.patch
# make -j$(nproc)
# make install

wget --quiet https://www.x.org/archive/individual/proto/dri3proto-1.0.tar.bz2 -O /tmp/dri3proto-1.0.tar.bz2
tar -xf /tmp/dri3proto-1.0.tar.bz2 -C /tmp
cd /tmp/dri3proto-1.0
./configure --prefix=$SYSROOT/usr
make install


wget --quiet https://www.x.org/archive/individual/proto/presentproto-1.1.tar.bz2 -O /tmp/presentproto-1.1.tar.bz2
tar -xf /tmp/presentproto-1.1.tar.bz2 -C /tmp
cd /tmp/presentproto-1.1
./configure --prefix=$SYSROOT/usr
make install



wget --quiet https://xcb.freedesktop.org/dist/xcb-proto-1.12.tar.bz2 -O /tmp/xcb-proto-1.12.tar.bz
tar -xf /tmp/xcb-proto-1.12.tar.bz -C /tmp
cd /tmp/xcb-proto-1.12
./configure --prefix=$SYSROOT/usr
make install

wget --quiet https://www.x.org/archive/individual/proto/xproto-7.0.31.tar.bz2 -O /tmp/xproto-7.0.31.tar.bz2
tar -xf /tmp/xproto-7.0.31.tar.bz2 -C /tmp
cd /tmp/xproto-7.0.31
./configure --prefix=$SYSROOT/usr
make install


wget --quiet https://www.x.org/archive//individual/lib/libXau-1.0.8.tar.bz2 -O /tmp/libXau-1.0.8.tar.bz2
tar -xf /tmp/libXau-1.0.8.tar.bz2 -C /tmp
cd /tmp/libXau-1.0.8
./configure \
    --prefix=$SYSROOT/usr \
    --host=$TRIPLET
make -j$(nproc)
make install


cd /tmp
wget --quiet https://xcb.freedesktop.org/dist/libxcb-1.12.tar.bz2 -O /tmp/libxcb-1.12.tar.bz2
tar -xf /tmp/libxcb-1.12.tar.bz2 -C /tmp
cd /tmp/libxcb-1.12
./configure \
    --prefix=$SYSROOT/usr \
    --host=$TRIPLET \
    --disable-devel-docs
patch < /libtool.patch
make -j$(nproc)
make install


cd /tmp
apt-get source libxshmfence
cd libxshmfence*
./configure \
    --prefix=$SYSROOT/usr \
    --host=$TRIPLET
make -j$(nproc)
make install



wget --quiet https://www.x.org/archive/individual/proto/xextproto-7.3.0.tar.bz2 -O /tmp/xextproto-7.3.0.tar.bz2
tar -xf /tmp/xextproto-7.3.0.tar.bz2 -C /tmp
cd /tmp/xextproto-7.3.0
./configure \
    --prefix=$SYSROOT/usr
make -j$(nproc)
make install

cd /tmp
apt-get source xtrans-dev
cd xtrans*
./configure \
    --prefix=$SYSROOT/usr \
    --host=$TRIPLET
make -j$(nproc)
make install

wget --quiet https://www.x.org/archive/individual/proto/kbproto-1.0.7.tar.bz2 -O /tmp/kbproto-1.0.7.tar.bz2
tar -xf /tmp/kbproto-1.0.7.tar.bz2 -C /tmp
cd /tmp/kbproto-1.0.7
./configure \
    --prefix=$SYSROOT/usr
make -j$(nproc)
make install


wget --quiet https://www.x.org/archive/individual/proto/inputproto-2.3.tar.bz2 -O /tmp/inputproto-2.3.tar.bz2
tar -xf /tmp/inputproto-2.3.tar.bz2 -C /tmp
cd /tmp/inputproto-2.3
./configure \
    --prefix=$SYSROOT/usr
make -j$(nproc)
make install

cd /tmp
apt-get source libx11
cd libx11*
./configure \
    --prefix=$SYSROOT/usr \
    --enable-malloc0returnsnull \
    --host=$TRIPLET
make -j$(nproc)
make install

cd /tmp
apt-get source libxext6
cd libxext*
./configure \
    --prefix=$SYSROOT/usr \
    --enable-malloc0returnsnull \
    --host=$TRIPLET
make -j$(nproc)
make install

cd /tmp
apt-get source x11proto-fixes-dev
cd x11proto-fixes*
./configure \
    --prefix=$SYSROOT/usr
make -j$(nproc)
make install

cd /tmp
apt-get source libxfixes
cd libxfixes*
./configure \
    --prefix=$SYSROOT/usr \
    --host=$TRIPLET
make -j$(nproc)
make install

cd /tmp
apt-get source x11proto-damage-dev
cd x11proto-damage*
./configure \
    --prefix=$SYSROOT/usr
make -j$(nproc)
make install


wget --quiet https://www.x.org/archive//individual/util/util-macros-1.19.1.tar.bz2 -O /tmp/util-macros-1.19.1.tar.bz2
tar -xf /tmp/util-macros-1.19.1.tar.bz2 -C /tmp
cd /tmp/util-macros-1.19.1
./configure --prefix=$SYSROOT/usr
make install

# Pull some tricks to get things to work right
export ACLOCAL_PATH=$SYSROOT/usr/share/aclocal
wget --quiet https://www.x.org/archive//individual/lib/libXdamage-1.1.4.tar.bz2 -O /tmp/libXdamage-1.1.4.tar.bz2
tar -xf /tmp/libXdamage-1.1.4.tar.bz2 -C /tmp
cd /tmp/libXdamage-1.1.4
LD="$TRIPLET-ld" CC="$TRIPLET-gcc" ./configure \
    --prefix=$SYSROOT/usr \
    --host=arm-linux-gnu
make -j$(nproc)
make install


cd /tmp
apt-get source libxext-dev
cd libxext*
./configure \
    --prefix=$SYSROOT/usr
make -j$(nproc)
make install


cd /tmp
apt-get source libpciaccess-dev
cd libpciaccess*
./configure \
    --prefix=$SYSROOT/usr
make -j$(nproc)
make install


cd /tmp
apt-get source libdrm-nouveau2
cd libdrm*
./configure \
    --prefix=$SYSROOT/usr \
    --host=$TRIPLET \
    --disable-intel \
    --disable-radeon \
    --disable-freedreno \
    --disable-amdgpu \
    --disable-manpages \
    --disable-valgrind
make -j$(nproc)
make install

cd /
rm -rf /tmp/* 
