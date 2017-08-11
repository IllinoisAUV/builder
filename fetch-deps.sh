#!/bin/sh

# Fetch the latest boost release
wget https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.bz2
tar -xf boost_1_64_0.tar.bz2

# Get boost to build for aarch64
./b2 toolset=gcc-arm -j4 architecture=arm abi=aapcs address-model=64
./bjam install --prefix=/usr/aarch64-linux-gnu toolset=gcc-arm -j4

