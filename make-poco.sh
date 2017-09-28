#!/bin/bash

set -xe

wget https://pocoproject.org/releases/poco-1.7.8/poco-1.7.8p3.tar.gz -O /tmp/poco-1.7.8p3.tar.gz
tar -xf /tmp/poco-1.7.8p3.tar.gz -C /tmp

cd /tmp/poco-1.7.8p3

cmake . -DCMAKE_TOOLCHAIN_FILE=/toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${SYSROOT} -DENABLE_ZIP=OFF -DENABLE_CRYPTO=OFF -DENABLE_DATA=OFF -DENABLE_MONGODB=OFF -DENABLE_NETSSL=OFF -DENABLE_PAGECOMPILER_FILE2PAGE=OFF -DENABLE_PAGECOMPILER=OFF
make -j$(nproc)
make install

# export POCO_TARGET_OSNAME=linux-gnu
# export POCO_TARGET_OSARCH=aarch64
# ./configure --prefix=$SYSROOT --config=ARM64-Linux --no-tests --no-samples --omit=Data/MySQL,Data/ODBC --include-path=$SYSROOT/include --library-path=$SYSROOT/lib; 
# make -j$(nproc) CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ STRIP=aarch64-linux-gnu-strip
# make install

cd /
rm -rf /tmp/*
