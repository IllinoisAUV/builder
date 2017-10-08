#!/bin/bash

set -xe

wget --quiet http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz -O /tmp/bzip2-1.0.6.tar.gz
tar -xf /tmp/bzip2-1.0.6.tar.gz -C /tmp
cd /tmp/bzip2-1.0.6

export CC=${TRIPLET}-gcc
export CXX=${TRIPLET}-g++
export AR=${TRIPLET}-ar
export RANLIB=${TRIPLET}-ranlib
export LD=${TRIPLET}-ld

# CFLAGS=--sysroot=$SYSROOT
# CPPFLAGS=--sysroot=$SYSROOT
# LDFLAGS=--sysroot=$SYSROOT

sed -i 's/CC=.*$//g' Makefile-libbz2_so

make -f Makefile-libbz2_so
# make -f Makefile-libbz2_so install PREFIX=$SYSROOT
cp libbz2.so.1.0.6 libbz2.so.1.0 $SYSROOT/usr/lib
cp bzlib.h $SYSROOT/usr/include

# Link the binary
cd $SYSROOT/usr/lib && ln -s libbz2.so.1.0 libbz2.so

cd /
rm -rf /tmp/*
