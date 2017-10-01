#!/bin/bash

set -xe

wget http://ftpmirror.gnu.org/libtool/libtool-2.4.6.tar.gz -O /tmp/libtool-2.4.6.tar.gz
tar -xf /tmp/libtool-2.4.6.tar.gz -C /tmp
cd /tmp/libtool-2.4.6





cd /
rm -rf /tmp/*
