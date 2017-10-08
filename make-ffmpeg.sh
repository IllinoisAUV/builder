#!/bin/bash

set -xe

wget --quiet https://www.ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 -O /tmp/ffmpeg.tar.bz2
tar -xf /tmp/ffmpeg.tar.bz2 -C /tmp

cd /tmp/ffmpeg

./configure \
    --cross-prefix=${TRIPLET}- \
    --sysroot=$SYSROOT \
    --enable-pic \
