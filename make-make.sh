#!/bin/bash
set -xe


# Glibc requires make 3.8* or 3.9*
wget --quiet https://ftp.gnu.org/gnu/make/make-3.82.tar.gz -O /tmp/make-3.82.tar.gz
tar -xf /tmp/make-3.82.tar.gz -C /tmp
pushd /tmp/make-3.82
./configure
make -j$(nproc)
make install

cd /
rm -rf /tmp/*
