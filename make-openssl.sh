#!/bin/bash

set -ex

wget https://www.openssl.org/source/openssl-1.0.2l.tar.gz -O /tmp/openssl-1.0.2l.tar.gz
tar -xf /tmp/openssl-1.0.2l.tar.gz -C /tmp
cd /tmp/openssl-1.0.2l

mkdir -p $SYSROOT/etc/ssl
export TRIPLET=aarch64-linux-gnu
export CROSS_COMPILE=$TRIPLET-
./Configure --prefix=$SYSROOT \
         --openssldir=$SYSROOT/etc/ssl \
         shared \
         zlib-dynamic \
         linux-aarch64


make
make install_sw

cd /
rm -rf /tmp/*
