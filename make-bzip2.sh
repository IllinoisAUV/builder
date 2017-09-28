#!/bin/bash

set -xe

wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz -O /tmp/bzip2-1.0.6.tar.gz
tar -xf /tmp/bzip2-1.0.6.tar.gz -C /tmp
cd /tmp/bzip2-1.0.6

export CC=aarch64-linux-gnu-gcc
export CXX=aarch64-linux-gnu-g++
export AR=aarch64-linux-gnu-ar
export RANLIB=aarch64-linux-gnu-ranlib
export LD=aarch64-linux-gnu-ld

# CFLAGS=--sysroot=$SYSROOT
# CPPFLAGS=--sysroot=$SYSROOT
# LDFLAGS=--sysroot=$SYSROOT

sed -i 's/CC=.*$//g' Makefile-libbz2_so

make -f Makefile-libbz2_so
# make -f Makefile-libbz2_so install PREFIX=$SYSROOT
cp libbz2.so.1.0.6 libbz2.so.1.0 $SYSROOT/lib
cp bzlib.h $SYSROOT/include

# Link the binary
cd $SYSROOT/lib && ln -s libbz2.so.1.0 libbz2.so

cd /
rm -rf /tmp/*
