#!/bin/bash

set -ex

wget --quiet https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz -O /tmp/Python-2.7.13.tgz
tar -xf /tmp/Python-2.7.13.tgz -C /tmp
cd /tmp/Python-2.7.13


echo "Stage 1: compiling host executables .."
./configure
make -j$(nproc) python Parser/pgen
mv python hostpython
mv Parser/pgen Parser/hostpgen

# export CC=aarch64-linux-gnu-gcc
# export CXX=aarch64-linux-gnu-g++
# export AR=aarch64-linux-gnu-ar
# export RANLIB=aarch64-linux-gnu-ranlib
# export LD=aarch64-linux-gnu-ld

# export CFLAGS=--sysroot=$SYSROOT
# export CPPFLAGS=--sysroot=$SYSROOT
# export LDFLAGS=--sysroot=$SYSROOT
# make distclean

# ./configure \
#     --build=$MACHTYPE \
#     --host=$TRIPLET \
#     --target=$TRIPLET \
#     --prefix=$SYSROOT \
#     --disable-ipv6 \
#     --enable-optimizations \
#     ac_cv_file__dev_ptmx=no \
#     ac_cv_file__dev_ptc=no \
#     ac_cv_have_long_long_format=yes \
#     PYTHON_FOR_BUILD=${PWD}/hostpython

CROSS_COMPILE=${TRIPLET}-
./configure \
    --host=$TRIPLET \
    --build=$MACHTYPE \
    --target=$TRIPLET \
    --prefix=$SYSROOT/usr \
    --disable-ipv6 \
    --enable-shared \
    --with-ensurepip=yes \
    --with-system-ffi \
    --with-system-expat \
    PYTHON_FOR_BUILD=${PWD}/hostpython \
    ac_cv_file__dev_ptmx=no \
    ac_cv_file__dev_ptc=no \
    ac_cv_have_long_long_format=yes

sed -i -e 's%\([[:space:]]\)\(PYTHONPATH=$(DESTDIR)$(LIBDEST)\)%\1-\2%' Makefile
make -j$(nproc) PYTHON_FOR_BUILD=./hostpython CROSS_COMPILE_TARGET=yes
make commoninstall

cd /
rm -rf /tmp/*
