#!/bin/bash

set -e

cd /tmp
wget http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2 -O /tmp/libtheora-1.1.1.tar.bz2
tar -xf /tmp/libtheora-1.1.1.tar.bz2 -C /tmp
cd libtheora-1.1.1

LD="$TRIPLET-ld" CC="$TRIPLET-gcc" ./configure \
    --prefix=$SYSROOT/usr \
    --host=arm-linux-gnu \
    --disable-asm \
    --disable-vorbistest \
    --disable-sdltest \
    --disable-examples

make -j$(nproc)
make install

cd /
rm -rf /tmp/*
